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
<div id="help"><a href="help.php?help={$help|escape}"><img src="images/question.gif" alt="help"/>{$message.strHelp|escape}</a></div>
  {if $status == 'success'}
  <table>
  <tr>
  <td>{$message.msgUpdateComplete|escape}</td>
  </tr>
  </table>
  {elseif $status == 'fail'}
  <table>
  <tr>
  <td>{$message.msgUpdateFailed|escape}</td>
  </tr>
  </table>
  {/if}
  <h2>{$message.strSetting|escape}</h2>
  <form action="config.php" method="post" id="Config">
    <input type="hidden" name="action" value="update" />
    <table>
      <tfoot>
      <tr><td colspan="2">
      <input type="submit" name="ButtonName" value="{$message.strUpdate|escape}" />
      </td></tr>
      </tfoot>
      <tbody>
        <tr>
          <th><label>{$message.strLanguage|escape}</label> (string)</th>
          <td>{custom_select param='lang' echo=true}</td>
        </tr>
        <tr>
          <th><label>{$message.strVersion|escape}</label> (float)</th>
          <td>{custom_select param='version' echo=true}</td>
        </tr>
        <tr>
          <th><label>{$message.strPgConfFile|escape}</label> (string)</th>
          <td>{custom_input param='pgpool_config_file' echo=true}</td>
        </tr>
        <tr>
          <th><label>{$message.strPasswordFile|escape}</label> (string)</th>
          <td>{custom_input param='password_file' echo=true}</td>
        </tr>
        <tr>
          <th><label>{$message.strPgpoolCommand|escape}</label> (string)</th>
          <td>{custom_input param='pgpool_command' echo=true}</td>
        </tr>

        <tr><th colspan="2"><label>{$message.strPgpoolCommandOption|escape}</label></th></tr>

        {if hasMemqCache() == false}
        <tr><td class="command_option">{$message.strCmdC|escape} (-c)</td>
            <td>{custom_radio_bool param='c' echo=true}</td>
        </tr>
        {/if}

        <tr><td class="command_option">{$message.strCmdLargeD|escape} (-D)</td>
            <td>{custom_radio_bool param='D' param_in_form='large_d' echo=true}</td>
        </tr>
        <tr><td class="command_option">{$message.strCmdN|escape} (-n)</td>
            <td>{custom_radio_bool param='n' echo=true}</td>
        </tr>

        {if hasMemqCache()}
        <tr><td class="command_option">{$message.strCmdLargeC|escape} (-C)</td>
            <td>{custom_radio_bool param='C' param_in_form='large_c'}</td>
        </tr>
        {/if}

        <tr><td class="command_option">{$message.strCmdD|escape} (-d)</td>
            <td>{custom_radio_bool param='d' echo=true}</td>
        </tr>
        <tr><td class="command_option">{$message.strCmdM|escape} (-m)</td>
            <td>{custom_select param='m' echo=true}</td>
            </td>
        </tr>
        <tr>
          <th><label>{$message.strPgpoolLogFile|escape}</label> (string)</th>
          <td>{custom_input param='pgpool_logfile' echo=true}</td>
        </tr>
        <tr>
          <th><label>{$message.strPcpDir|escape}</label> (string)</th>
          <td>{custom_input param='pcp_client_dir' echo=true}</td>
        </tr>
        <tr>
          <th><label>{$message.strPcpHostName|escape}</label> (string)</th>
          <td>{custom_input param='pcp_hostname' echo=true}</td>
        </tr>
        <tr>
          <th><label>{$message.strPcpRefreshTime|escape}</label> (string)</th>
          <td>{custom_input param='pcp_refresh_time' echo=true}</td>
        </tr>
        <tr>
          <th><label>{$message.strPgConnectTimeout|escape}</label> (string)</th>
          <td>{custom_input param='pg_connect_timeout' echo=true}</td>
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
