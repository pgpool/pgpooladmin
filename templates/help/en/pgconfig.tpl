<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>{$message.strPgConfSetting|escape}</title>
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
<div id="help"><a href="{$help}.php"><img src="images/back.gif" />{$message.strBack}</a></div>

<h2>{$message.strHelp|escape}({$message.strPgConfSetting|escape})</h2>

<h3>{$message.strSummary|escape}</h3>
The content of pgpool.conf that is the configuration file of pgpool set can be displayed and be changed.
<p>
Official documentation:<br>
<a href="http://www.pgpool.net/docs/latest/pgpool-en.html" target="_blank">
http://www.pgpool.net/docs/latest/pgpool-en.html</a>
</p>

<h3>{$message.strFeature|escape}</h3>
Please input the value that wants to change and push the update button.

<h4>Addition of A backend host</h4>
Please push the add button when you want to add a new back end host. <br />
It inputs in back end host's item and a new input column can be done, and input information on a new back end host there, please.<br />
Please push the update button when input ends.

<h4>Deletion of backend host</h4>
Please push the delete button at the right of the host setting when you want to delete the back end host who has registered. <br />

</div>
<hr class="hidden" />
<div id="footer">
{include file='footer.tpl'}
</div>
</body>
</html>
