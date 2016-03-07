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
  <h3>简介</h3>
  更改目前登录管理工具的用户密码。
  <h3>功能</h3>
  在每个输入框里输入新的密码后按更新按钮。
  进入登录页面后，请用用新密码登录。
  <p>
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
