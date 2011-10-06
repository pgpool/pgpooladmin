<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>{$message.strLogin|escape}</title>
<link href="screen.css" rel="stylesheet" type="text/css" />
</head>
<body>
<div id="header">
  <h1><img src="images/logo.gif" alt="pgpoolAdmin" /></h1>
</div>
<div id="menu">
</div>
<div id="content">
<div id="help">
<a href="help.php?help=login"><img src="images/question.gif" alt="help"/>{$message.strHelp|escape}</a>
</div>
  <h2>{$message.strLogin|escape}</h2>
  <form action="login.php" method="post" name="Login">
    <table>
     <tfoot>
      <tr><td colspan="2">
      <input type="submit" name="Button" value="{$message.strLogin|escape}" />
      </td></tr>
     </tfoot>
    <tbody>
      <tr>
        <th><label>{$message.strLoginName|escape}</label></th>
        <td><input id="username" name="username" type="text" size="25" /></td>
      </tr>
      <tr>
        <th><label>{$message.strPassword|escape}</label></th>
        <td><input id="password" name="password" type="password" size="25" /></td>
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
