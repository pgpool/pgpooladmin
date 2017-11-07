<?php
function smarty_function_custom_tr_pgconfig($args)
{
    extract($args); // -> $param, $num
    global $params, $error, $message, $pgpoolConfigParamAll;

    // type
    switch ($pgpoolConfigParamAll[$param]['type']) {
    case 'B':
        $type = 'bool'; break;
    case 'C':
        $type = 'string'; break;
    case 'F':
        $type = 'float'; break;
    case 'N':
        $type = 'integer'; break;
    }

    // input's name
    if (! isset($param_in_form)) {
        $param_in_form = $param;
    }
    if (isset($pgpoolConfigParamAll[$param]['multiple']) &&
        $pgpoolConfigParamAll[$param]['multiple'])
    {
        $param_in_form = "{$param_in_form}[]";
    }

    // input
    switch ($pgpoolConfigParamAll[$param]['type']) {
    case 'B':
        $input = radio_switch($param, $param_in_form, $num);
        break;
    case 'C':
    case 'F':
    case 'N':
        if (isset($pgpoolConfigParamAll[$param]['select'])) {
            $input = select($param, $param_in_form, $num);
        } else {
            $input = input($param, $param_in_form, $num);
        }
        break;
    }

    printf('<tr>'.
           '<th class="colname %s"><label>%s</label> <br />%s (%s) %s</th>'.
           '<td>%s</td>'.
           '</tr>',
           (isset($error[$param])) ? 'error' : NULL,
           $message['desc' . ucfirst($param)],
           $param,
           $type,
           (isset($pgpoolConfigParamAll[$param]['restart']) &&
            $pgpoolConfigParamAll[$param]['restart']) ? '*' : NULL,
           $input
    );
}

function input($param, $param_in_form, $num)
{
    global $params, $errors, $pgpoolConfigParamAll;

    $val_arr = $select_options[$param];

    // in case of per node health_check parameters,
    // key is "health_check_period0"
    if (preg_match('/^(health_check|connect_time).*[a-z]$/', $param)) {
        $user_val = $params[$param . $num];
    } else {
        $user_val = $params[$param];
    }
    if (is_array($user_val)) {
       $user_val = ($num !== NULL) ? $user_val[$num] : NULL;
    }

    $rtn = sprintf(
        '<input type="text" name="%s" size="50" value="%s" />',
        $param_in_form, $user_val
    );

    if ($errors[$param]) {
        $rtn .= '<p class="check_error">'.
                '<span class="error">Error</span> '. $errors[$param].
                '</p>';
    }

    return $rtn;
}

function select($param, $param_in_form, $num)
{
    global $params, $errors, $pgpoolConfigParamAll;

    // in case of per node health_check parameters,
    // key is "health_check_period0"
    if (preg_match('/^(health_check|connect_time).*[a-z]$/', $param)) {
        $user_val = $params[$param . $num];
    } else {
        $user_val = $params[$param];
    }

    if ($user_val == '') {
        $user_val = $param_info['default'];
    }
    if (is_array($user_val) && $num !== NULL) {
        $user_val = $user_val[$num];
    }

    $param_info = $pgpoolConfigParamAll[$param];

    $rtn .= sprintf('<select name="%s">', $param_in_form);
    foreach ($param_info['select'] as $val) {
        $rtn .= sprintf(
            '<option value="%s" %s>%s</option>',
            $val, ($val == $user_val) ? 'selected' : NULL, $val
        );
    }
    $rtn .= '</select>';

    if ($errors[$param]) {
        $rtn .='<br>'. $errors[$param];
    }

    return $rtn;
}

function radio_switch($param, $param_in_form, $num)
{
    global $select_options, $params, $errors, $pgpoolConfigParamAll;

    $user_val = $params[$param];
    if (is_array($user_val) && $num !== NULL) {
        $user_val = $user_val[$num];
    }

    $val_arr = array('on' => 'on', 'off' => 'off');

    $rtn = '<div class="radio_bool">';
    foreach ($val_arr as $val => $label) {
        $radio_id = "{$param}_{$val}";

        $rtn .= sprintf(
            '<input type="radio" name="%s" id="%s" value="%s" %s>'.
            '<label for="%s">%s</label>',
            $param_in_form, $radio_id, $val, ($val == $user_val) ? 'checked' : NULL,
            $radio_id, $label
        );
    }

    if ($error) {
        $rtn .= '<br>'. $error;
    }

    $rtn .= '</div>';

    return $rtn;
}

