{* stop option *}
<div id="stopPgsqlDiv" style="visibility: hidden; position: absolute;">
<h3>{$message.strStopPgsqlOption|escape}</h3>
<form action="status.php" name="stopPgsqlForm" method="post"
      onSubmit="return execStopPgsql()" />
<table>
<thead>
    <tr><th colspan="2">{$message.strCmdM|escape}(-m)</th></tr>
</thead>
<tbody>
    {include file="elements/status_stop_option.tpl"}
</tbody>
<tfoot>
    <tr><td colspan="2">
    <input type="submit"
           value="{$message.strStopPgsql|escape}" />
    <input type="button" name="command" onclick="cancelButtonHandler('stopPgsqlDiv')"
           value="{$message.strCancel|escape}" />
    </td></tr>
</tfoot>
</table>
</form>
</div>

{* restart option *}
<div id="restartPgsqlDiv" style="visibility: hidden; position: absolute;">
<h3>{$message.strRestartPgsqlOption|escape}</h3>
<form action="status.php" name="restartPgsqlForm" method="post"
      onSubmit="return execRestartPgsql()" />
<table>
<thead>
    <tr><th colspan="2">{$message.strCmdM|escape}(-m)</th></tr>
</thead>
<tbody>
    {include file="elements/status_stop_option.tpl"}
</tbody>
<tfoot>
    <tr><td colspan="2">
    <input type="submit"
           value="{$message.strRestartPgsql|escape}" />
    <input type="button" name="command" onclick="cancelButtonHandler('restartPgsqlDiv')"
           value="{$message.strCancel|escape}" />
    </td></tr>
</tfoot>
</table>
</form>
</div>
