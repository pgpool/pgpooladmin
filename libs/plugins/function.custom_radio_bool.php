<?php
function smarty_function_custom_radio_bool($params)
{
    extract($params);
    global $select_options, $params, $errors;

    if (! isset($param_in_form)) {
        $param_in_form = $param;
    }

    $checked_val = $params[$param];

    $val_arr = array(1 => 'on', 0 => 'off');

    echo '<div class="radio_bool">';
    foreach ($val_arr as $val => $label) {
        $radio_id = "{$param}_{$val}";

        printf('<input type="radio" name="%s" id="%s" value="%s" %s>'.
               '<label for="%s">%s</label>',
               $param_in_form, $radio_id, $val, ($val == $checked_val) ? 'checked' : NULL,
               $radio_id, $label);
    }

    if ($error) {
        echo '<br>'. $error;
    }

    echo '</div>';
}
