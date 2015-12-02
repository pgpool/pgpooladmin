<?php
function smarty_function_custom_input($args)
{
    extract($args);
    global $params, $errors;

    if (! isset($param_in_form)) {
        $param_in_form = $param;
    }

    $val_arr = $select_options[$param];

    $rtn = sprintf(
        '<input type="text" name="%s" size="50" value="%s" />',
        $param_in_form, $params[$param]
    );

    if ($errors[$param]) {
        $rtn .= '<p class="check_error">'.
                '<span class="error">Error</span> '. $errors[$param].
                '</p>';
    }

    if (isset($echo)) {
        echo $rtn;
    } else {
        return $rtn;
    }
}
