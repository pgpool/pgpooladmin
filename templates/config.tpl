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
          <th><label>{$message.strLanguage|escape}</label>
            (string)</th>
          <td class="input"><select name="lang">
              <option value="auto">auto</option>
              {foreach key=key item=str from=$messageList}
              {if $params.lang == $key}
              <option value="{$key|escape}" selected="selected">{$str|escape}</option>
              {else}
              <option value="{$key|escape}">{$str|escape}</option>
              {/if}
              {/foreach}
            </select>
          </td>
        </tr>
        <tr>
          {if $errors.pgpool_config_file != null}<th class="error">{else}<th>{/if}
            <label>{$message.strPgConfFile|escape}</label>
            (string)</th>
          <td><input type="text" name="pgpool_config_file" size="50" value="{$params.pgpool_config_file|escape}" />
          {if $errors.pgpool_config_file != ''}
          <br />{$errors.pgpool_config_file|escape}
          {/if}
          </td></tr>
        <tr>
          {if $errors.password_file != null}<th class="error">{else}<th>{/if}
            <label>{$message.strPasswordFile|escape}</label>
            (string)</th>
          <td><input type="text" name="password_file" size="50" value="{$params.password_file|escape}" />
          {if $errors.password_file != ''}
          <br />{$errors.password_file|escape}
          {/if}
          </td></tr>
        <tr>
          {if $errors.pgpool_command != null}<th class="error">{else}<th>{/if}
          <label>{$message.strPgpoolCommand|escape}</label>
            (string)</th>
          <td><input type="text" name="pgpool_command" size="50" value="{$params.pgpool_command|escape}" />
          {if $errors.pgpool_command != ''}
          <br />{$errors.pgpool_command|escape}
          {/if}
          </td></tr>
        <tr>
          <th colspan="2"><label>{$message.strPgpoolCommandOption|escape}</label>
            (string)</th></tr>
        <tr><td>{$message.strCmdC|escape}(-c)</td>
          <td>
          {if $params.c == 1}
          <input type="checkbox" name="c" checked="checked" />
          {else}
          <input type="checkbox" name="c" />
          {/if}
          {if $errors.c != ''}
          <br />{$errors.c|escape}
          {/if}
          </td></tr>
        <tr><td>{$message.strCmdLargeD|escape}(-D)</td>
          <td>
          {if $params.d == 1}
          <input type="checkbox" name="D" checked="checked" />
          {else}
          <input type="checkbox" name="D" />
          {/if}
          {if $errors.D != ''}
          <br />{$errors.D|escape}
          {/if}
          </td></tr>
        <tr><td>{$message.strCmdN|escape}(-n)</td>
          <td>
          {if $params.n == 1}
          <input type="checkbox" name="n" checked="checked" />
          {else}
          <input type="checkbox" name="n" />
          {/if}
          {if $errors.n != ''}
          <br />{$errors.n|escape}
          {/if}
          </td></tr>
        <tr><td>{$message.strCmdD|escape}(-d)</td>
          <td>
          {if $params.d == 1}
          <input type="checkbox" name="d" checked="checked" />
          {else}
          <input type="checkbox" name="d" />
          {/if}
          {if $errors.d != ''}
          <br />{$errors.d|escape}
          {/if}
          </td></tr>
        <tr><td>{$message.strCmdM|escape}(-m)</td><td><select name="m">
          {if $params.m == 's'}
               <option value="s" selected="selected">smart</option>
               <option value="f">fast</option>
               <option value="i">immediate</option>
          {elseif $params.m == 'f'}
               <option value="s">smart</option>
               <option value="f" selected="selected">fast</option>
               <option value="i">immediate</option>
          {elseif $params.m == 'i'}
               <option value="s">smart</option>
               <option value="f">fast</option>
               <option value="i" selected="selected">immediate</option>
          {else}
               <option value="s">smart</option>
               <option value="f">fast</option>
               <option value="i">immediate</option>
          {/if}
          </td></tr>
        <tr>
          {if $errors.pgpool_logfile != null}<th class="error">{else}<th>{/if}
            <label>{$message.strPgpoolLogFile|escape}</label>
            (string)</th>
          <td><input type="text" name="pgpool_logfile" size="50" value="{$params.pgpool_logfile|escape}" />
          {if $errors.pgpool_logfile != ''}
          <br />{$errors.pgpool_logfile|escape}
          {/if}
          </td></tr>
        <tr>
          {if $errors.pcp_client_dir != null}<th class="error">{else}<th>{/if}
            <label>{$message.strPcpDir|escape}</label>
            (string)</th>
          <td><input type="text" name="pcp_client_dir" size="50" value="{$params.pcp_client_dir|escape}" />
          {if $errors.pcp_client_dir != ''}
          <br />{$errors.pcp_client_dir|escape}
          {/if}
          </td></tr>
        <tr>
          {if $errors.pcp_hostname != null}<th class="error">{else}<th>{/if}
            <label>{$message.strPcpHostName|escape}</label>
            (string)</th>
          <td><input type="text" name="pcp_hostname" size="50" value="{$params.pcp_hostname|escape}" />
          {if $errors.pcp_hostname != ''}
          <br />{$errors.pcp_hostname|escape}
          {/if}
          </td></tr>
        <tr>
          {if $errors.pcp_refresh_time != null}<th class="error">{else}<th>{/if}
            <label>{$message.strPcpRefreshTime|escape}</label>
            (integer)
          </th><td><input type="text" name="pcp_refresh_time" size="50" value="{$params.pcp_refresh_time|escape}" />
          {if $errors.pcp_refresh_time != ''}
          <br />{$errors.pcp_refresh_time|escape}
          {/if}
          </td></tr>
      </tbody>
    </table>
  </form>
</div>
<div id="footer">
{include file='footer.tpl'}
</div>
</body>
</html>
