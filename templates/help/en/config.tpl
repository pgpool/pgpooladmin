<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>{$message.strSetting|escape}</title>
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
  <h2>{$message.strHelp|escape}({$message.strSetting|escape})</h2>
  <h3>{$message.strSummary|escape}</h3>
  The setting of the pgpool administration tool can be displayed and be changed.
  <h3>{$message.strFeature|escape}</h3>
    <table>
      <tbody>
        <tr>
          <th><label for="listen_addresses">{$message.strLanguage|escape}</label>
            (string)</th>
          <td class="input">The language that wants to be displayed is selected. </td>
        </tr>
        <tr>
          <th><label for="pgconfigPath">{$message.strPgConfFile|escape}</label>
            (string)</th>
          <td>Path to pgpool.conf is specified in the full path. </td></tr>
        <tr>
          <th><label for="PasswordFile">{$message.strPasswordFile|escape}</label>
            (string)</th>
          <td>Path to pcp.conf is specified in the full path. </td></tr>
        <tr>
          <th colspan="2"><label>{$message.strPgpoolCommandOption|escape}</label>
            (string)</th></tr>
          <tr><td>{$message.strCmdC|escape}(-c)</td>
          <td>When starting pgpool, the query cache is cleared.</td>
          </tr>
          <tr><td>{$message.strCmdN|escape}(-n)</td>
          <td>pgpool can be run in non-daemon mode. For display of pgpool log in this pool, it is necessary to turn on this item. </td>
          </tr>
          <tr><td>{$message.strCmdD|escape}(-d)</td>
          <td>pgpool can be run in debug mode. When the debugging log is necessary, it turns it on.</td>
          </tr>
          <tr>
          <tr><td>{$message.strCmdM|escape}(-d)</td>
          <td>All the processes of pgpool are stopped. The pgpool stop option is displayed, when "pgpool Stop" is pushed. There are stop mode for pgpool as follows.
          <ul>
          <li>smart</li>
          <li>fast</li>
          <li>immediate</li>
          </ul>
          If pgpool is stopped, pgpool status in the status window become "pgpool stop" and start option for pgpool is displayed.</td>
          </tr>
          <tr><td>{$message.strCmdPgpoolFile|escape}(-f)</td>
          <td>When pgpool starts, pgpool.conf must be specified. The path of pgpool.conf is specified in "{$message.strPgConfFile|escape}".</td>
          </tr>
          <tr><td>{$message.strCmdPcpFile|escape}(-F)</td>
          <td>When pgpool starts, pcp.conf must be specified. The path of pcp.conf is specified in "{$message.strPasswordFile|escape}".</td>
          </tr>
        <tr>
          <th><label>{$message.strPgpoolLogFile|escape}</label>
            (string)</th>
          <td>The full-path log file name OR pipe command is specified. To assign a pipe command, make sure it starts with a bar ('|'). If it is left blank and pgpool is started in non-daemon mode, "pgpool.log" file is created in the directory specified by the logdir parameter of pgpool.conf.</td></tr>
        <tr>
          <th><label for="PcpDir">{$message.strPcpDir|escape}</label>
            (string)</th>
          <td>The directory that has installed the PCP command is specified. </td></tr>
        <tr>
          <th><label for="PcpHostname">{$message.strPcpHostName|escape}</label>
            (string)</th>
          <td>The host name that executes the PCP command is specified. It usually becomes "localhost".</td>
        </tr>
        <tr>
          <th><label for="PcpRefreshTime">{$message.strPcpRefreshTime|escape}</label>
            (integer)
            </th>
          <td>The update interval of status is specified every second. When 0 is specified, it doesn't update it automatically. </td></tr>
        <tr>
          <th><label for="ConnectTimeout">{$message.strPgConnectTimeout|escape}</label>
            (integer)
            </th>
          <td>The connect timeout for postgresql connections when checking if backend is alive or not. </td></tr>
      </tbody>
    </table>
  <p>Finally, The update button is renewed pushing.</p>
</div>
<div id="footer">
{include file='footer.tpl'}
</div>
</body>
</html>
