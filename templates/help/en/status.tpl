<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>{$message.strPgpoolStatus|escape}</title>
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
<h2>{$message.strHelp|escape}({$message.strStatus|escape})</h2>
  <h3>{$message.strSummary|escape}</h3>
On the status screen, it is possible to display it for pgpool as follows,
<ul><li>Summary</li>
  <li>Process Information</li>
  <li>Node Information</li>
  <li>Log</li>
</ul>
and operate it.
<ul>
  <li>Start</li>
  <li>Stop</li>
  <li>Restart</li>
</ul>
<h3>  <h3>{$message.strFeature|escape}</h3></h3>

<table>
  <tr>
    <th class="right_border"><label>Summary</label></th>
    <td>The content of pgpool.conf is displayed.</td>
  </tr>
  <tr>
    <th class="right_border"><label>Process Information</label></th>
    <td><p>In each process for pgpool,</p>
      <ul>
        <li>Process ID</li>
        <li>Database Name</li>
        <li>Username</li>
        <li>Process start time</li>
        <li>Connection create time</li>
        <li>Protocol major version</li>
        <li>Protocol miner version</li>
        <li>Use of connection</li>
        </ul>
      <p>will be shown.<br />
      In each process, it will be displayed only the number of max_pool in pgpool.conf in the maximum.
      </p></td>
  </tr>
  <tr>
    <th class="right_border"><label>Node Information</label></th>
    <td><p>In each node,</p>
        <ul>
          <li>IP address</li>
          <li>Port number</li>
          <li>Status</li>
          <li>Weight</li>
          <li>Disconnect button</li>
        </ul>
      <p>will be shown. But, the button for disconnection will not be shown when pgpool is running on parallel mode.</p>
      <p>In the status,</p>
      <ul>
          <li>Up. Disconnect</li>
        <li>Up. Connected</li>
        <li>Down</li>
      </ul>
      <p>the three states will be shown.</p></td>
  </tr>
  <tr>
    <th class="right_border"><label>Log</label></th>
    <td>It is possible to display about log of pgpool when pgpool doesn't run in daemon mode(-n).</td>
  </tr>
  <tr>
    <th class="right_border"><label>Start</label></th>
    <td>It is possible to start pgpool when it is stopped. The start option of  pgpool
    <ul>
    <li>Clears query cache(-c)</li>
    <li>don't run in daemon mode(-n)</li>
    <li>stop mode(-m)</li>
    <li>pgpool.conf(-f)</li>
    <li>pcp.conf(-F)</li>
    </ul>
    can be specified. 
    </td>
  </tr>
  <tr>
  <tr>
    <th class="right_border"><label>Stop</label></th>
    <td>All the processes of pgpool are stopped. The pgpool stop option is displayed, when "pgpool Stop" is pushed. There are stop mode for pgpool as follows.
    <ul>
    <li>smart</li>
    <li>fast</li>
    <li>immediate</li>
    </ul>
    If pgpool is stopped, pgpool status in the status window becomes "pgpool stop" and the start option for pgpool is displayed.</td>
  </tr>
  <tr>
    <th class="right_border"><label>Restart</label></th>
    <td>First, all the processes of pgpool are stopped and then pgpool start process is executed. Both the start and the stop of the abovementioned items can be specified. </td>
  </tr>
</table>

<table>
</table>
</div>
<div id="footer">
{include file='footer.tpl'}
</div>
</body>
</html>
