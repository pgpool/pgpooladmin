<?php
function smarty_function_custom_select($args)
{
    extract($args);
    global $params, $errors, $select_options;

    $user_val = $params[$param];
    if (is_array($user_val) && $num !== NULL) {
        $user_val = $user_val[$num];
    }

    $rtn = sprintf('<select name="%s">', $param);
    foreach ($select_options[$param] as $key => $val) {
        $rtn .= sprintf(
            '<option value="%s" %s>%s</option>',
            $key, ($val == $user_val) ? 'selected' : NULL, $val
        );
    }
    $rtn .= '</select>';

    if ($errors[$param]) {
        $rtn .='<br>'. $errors[$param];
    }

    echo $rtn;
}
