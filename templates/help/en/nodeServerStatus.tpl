<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>{$message.strNodeStatus|escape}</title>
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
<div id="help"><a href="{$help|escape}.php"><img src="images/back.gif" />{$message.strBack|escape}</a></div>
<h2>{$message.strHelp|escape}({$message.strNodeStatus|escape})</h2>
<h3>{$message.strSummary|escape}</h3>
On the node status screen,
<ul><li>IP Address</li>
  <li>Port</li>
  <li>Status</li>
  <li>Detail</li>
  </ul>
<p>can be acquired for each nodes.</p>
<h3>{$message.strFeature|escape}</h3>
<table>
  <tr>
    <th class="right_border"><label>IP Address</label></th>
    <td>The IP address of the node.</td>
  </tr>
  <tr>
    <th class="right_border"><label>Port</label></th>
    <td>The port number that the postmaster runs on.</td>
  </tr>
  <tr>
    <th class="right_border"><label>Status</label></th>
    <td>It is displayed whether postmaster is operating.</td>
  </tr>
  <tr>
    <th class="right_border"><label>Detail</label></th>
    <td>When the postmaster runs on, it will be displayed.<br />
Pg_settings information is displayed for PostgreSQL, and pool_status is displayed for pgpool. 
    </td>
    </tr>

</table>
    </td>
  </tr>
</div>
<div id="footer">
{include file='footer.tpl'}
</div>
</body>
</html>
