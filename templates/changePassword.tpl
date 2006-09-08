<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>{$message.strChangePassword|escape}</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="screen.css" rel="stylesheet" type="text/css" />
</head>
<body>
<div id="header">
  <h1><img src="images/logo.gif" alt="pgpoolAdmin" /></h1>
</div>
<div id="menu">
{include file="menu.tpl"}
</div>
<div id="content">
<div id="help"><a href="help.php?help={$help|escape}"><img src="images/question.gif" alt="help" />{$message.strHelp|escape}</a></div>
  <h2>{$message.strChangePassword|escape}</h2>
  <form action="changePassword.php" method="post">
    <input type="hidden" name="action" value="update"/>
    <table>
      {if $error != ''}
      <thead><tr><td colspan="2">{$error|escape}</td></tr></thead>
      {/if}
      <tfoot>
      <tr><td colspan="2">
      <input type="submit" name="ButtonName" value="{$message.strUpdate|escape}" />
      </td></tr>
    </tfoot>
      <tbody>
        <tr>
          <th><label>{$message.strPassword|escape}</label></th>
          <td><input id="password" name="password" type="password" size="25" /></td>
        </tr>
        <tr>
          <th><label>{$message.strPasswordConfirmation|escape}</label></th>
          <td><input id="password2" name="password2" type="password" size="25" /></td>
        </tr>
      </tbody>
</table>
  </form>
</div>
<div id="footer">
{include file='footer.tpl'}
</div>
</body>
</html>
