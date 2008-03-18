<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>{$message.strHelp|escape}({$message.strChangePassword|escape})</title>
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
<div id="help"><a href="{$help|escape}.php"><img src="images/back.gif" />{$message.strBack|escape}</a></div>
  <h2>{$message.strHelp|escape}({$message.strChangePassword|escape})</h2>
  <h3>{$message.strSummary|escape}</h3>
  The password of the user who is logging in the pgpool administration tool is changed.
  <h3>{$message.strFeature|escape}</h3>
  Please input a new password to each input column twice and push the update button.<br />
  When it is successful, the login screen is displayed. Please login with the new password. 
  <form aciton="changePassword.php?action=update" method="post">
    <input type="hidden" name="action" value="update"/>
    <table>
      <tbody>
        <tr>
          <th><label for="password">{$message.strPassword|escape}</label></th>
          <td><input id="password" name="password" type="password" size="25" /></td>
        </tr>
        <tr>
          <th><label for="password2">{$message.strPasswordConfirmation|escape}</label></th>
          <td><input id="password2" name="password2" type="password" size="25" /></td>
        </tr>
      </tbody>
      <tfoot>
      <tr><td colspan="2">
      <input type="submit" name="ButtonName" value="{$message.strUpdate|escape}" />
      </td></tr>
    </table>
  </form>
</div>
<div id="footer">
{include file='footer.tpl'}
</div>
</body>
</html>
