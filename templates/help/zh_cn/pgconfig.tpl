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
<p>使用 pgpool.conf设置，可以显示以及修改pgpool的配置文件pgpool.conf</p>
<p>
官方手册:<br>
<a href="http://www.pgpool.net/docs/latest/pgpool-zh_cn.html" target="_blank">
http://www.pgpool.net/docs/latest/pgpool-zh_cn.html</a>
</p>

<h3>{$message.strFeature|escape}</h3>
<p>请输入需要修改的设定值，然后按更新按键。</p>
<p>
为了是变动生效，你需要重新加载配置文件。
如果是带有[*]符号的参数，你需要重启 pgpool，以使变动生效。
</p>
　
<h4>添加后台主机</h4>
<p>如果需要追加新的后台主机，请按添加按键。</p>
<p>
在新添加的后台主机的输入框里，输入新后台主机的信息。
输入完成后，请按更新按键。
</p>

<h4>删除后台主机</h4>
<p>如果要删除已经添加的后台主机，请按需要删除的主机右侧的删除按键。</p>

</div>
<hr class="hidden" />
<div id="footer">
{include file='footer.tpl'}
</div>
</body>
</html>
