<?php
function smarty_function_custom_table_pgconfig($args)
{
    global $message;
    extract($args);

echo <<<EOT
      <thead>
        <tr>
          <th>{$message['strParameter']}</th>
          <th>{$message['strValue']}</th>
        </tr>
      </thead>
EOT;

    if (isset($tfoot) && $tfoot == FALSE) { return; }

echo <<<EOT
      <tfoot>
        <tr>
          <td colspan="2"></td>
        </tr>
      </tfoot>
EOT;
}
