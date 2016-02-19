<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>{$message.strNodeStatus|escape}</title>
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
<h2>{$message.strHelp|escape}({$message.strNodeStatus|escape})</h2>
<h3>{$message.strSummary|escape}</h3>
用节点状态，可以获取每个节点的如下信息。
<ul><li>IP地址</li>
  <li>端口号</li>
  <li>状态</li>
  <li>详细信息</li>
  </ul>
<h3>{$message.strFeature|escape}</h3>
<table>
  <tr>
    <th class="right_border"><label>IP地址</label></th>
    <td>节点的IP地址</td>
  </tr>
  <tr>
    <th class="right_border"><label>端口号</label></th>
    <td>Postmaster运行的端口号</td>
  </tr>
  <tr>
    <th class="right_border"><label>状态</label></th>
    <td>显示Postmaster是否处于运行状态。</td>
  </tr>
  <tr>
    <th class="right_border"><label>詳細信息</label></th>
    <td>仅在Postmaster处于运行状态时显示此信息。<br />
    在 PostgreSQL 的情况下，获取 pg_settings 的信息，pgpool 的情况下，获取 pool_status 的信息。
    </td>
  </tr>
</table>
</div>
<div id="footer">
{include file='footer.tpl'}
</div>
</body>
</html>
