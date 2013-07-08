<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>{$message.strPgpoolStatus|escape}</title>
<link href="screen.css" rel="stylesheet" type="text/css" />
{include file="elements/status_js.tpl"}
</head>

<body onLoad="load()">
<div id="header">
  <h1><img src="images/logo.gif" alt="pgpoolAdmin" /></h1>
</div>

<div id="menu">
{include file="menu.tpl"}
</div>

<div id="content">
    <div id="help">
    <a href="help.php?help={$help|escape}"><img src="images/question.gif" alt="help"/>{$message.strHelp|escape}</a>
    </div>

    {* --------------------------------------------------------------------- *}
    {* pgpool's version                                                      *}
    {* --------------------------------------------------------------------- *}

    <h2>pgpoolAdmin</h2>
    <ul>
    <li>This is pgpoolAdmin on {$smarty.const.PGPOOLADMIN_HOST}</li>
    <li>For pgpool-II {$smarty.const._PGPOOL2_VERSION}.</li>
    <li>Login
        <ul>
        <li>login user: {$login_user}</li>
        <li>superuser: {if $is_superuser == NULL}unknown (Connection error)
                       {elseif $is_superuser == TRUE}yes{else}no{/if}
        </li>
        </ul>
    </li>
    </ul>

    {* --------------------------------------------------------------------- *}
    {* Status Info Buttons                                                   *}
    {* --------------------------------------------------------------------- *}

    <h2>Backend info (PostgreSQL)</h2>

    {if isset($complete_msg)}{$complete_msg}{/if}

    {* --------------------------------------------------------------------- *}
    {* Succeeed / Failed                                                     *}
    {* --------------------------------------------------------------------- *}

    {if isset($status)}
      {if $status == 'success'}
      <table id="complete_msg">
        <tr>
        <td class="pgconfig_msg"><p>{$message.msgUpdateComplete|escape}</p></td>
        </tr>
      </table>
      {elseif $status == 'fail'}
      <table id="command">
        <tr>
        <td class="pgconfig_msg"><p><img src="images/error.png"> {$message.msgUpdateFailed|escape}</p></td>
        </tr>
      </table>
      {/if}
    {/if}

    {if $pgpoolIsActive == true}
        <p>
        <input type="button" name="command" onClick="changeView('summary')"
               {if $action == 'summary'}class="command_active"{/if}
               value="{$message.strPgpoolSummary|escape}" />

        <input type="button" name="command" onClick="changeView('proc')"
               {if $action == 'proc'}class="command_active"{/if}
               value="{$message.strProcInfo|escape}" />

        {if $params.use_watchdog == 'on'}
        <input type="button" name="command" onClick="changeView('watchdog')"
               {if $action == 'watchdog'}class="command_active"{/if}
               value="Watchdog" />
        {/if}

        <input type="button" name="command" onClick="changeView('node')"
               {if $action == NULL || $action == 'node'}class="command_active"{/if}
               value="{$message.strNodeInfo|escape}" />

        {if $useSyslog == FALSE && $n == 1 && $pipe == 0}
        <input type="button" name="command" onClick="changeView('log')"
               {if $action == 'log'}class="command_active"{/if}
               value="{$message.strLog|escape}" />
        {/if}
        </p>

        <div id="div_status"></div>{* show elements/status_nodeinfo.tpl *}

    {else}
        <table>
          <thead>
          <tr>
            <th></th>
            <th><label>{$message.strIPaddress|escape}</label></th>
            <th><label>{$message.strPort|escape}</label></th>
            <th><label>{$message.strStatus|escape}</label></th>
            <th></th>
          </tr>
          </thead>

          <tbody>
          {if isset($params.backend_hostname)}
              {$i = 0}
              {foreach from=$params.backend_hostname key=node_num item=v}
                  {$i = $i + 1}
                  <tr class="{if $i % 2 == 0}even{else}odd{/if}">
                  <td>node {$node_num}</td>
                  <td class="input">{$params.backend_hostname.$node_num|escape}</td>
                  <td class="input">{$params.backend_port.$node_num|escape}</td>
                  <td>postgres:
                      {if $nodeInfo.$node_num.is_active}{$message.strUp|escape}
                      {else}{$message.strDown|escape}
                      {/if}
                  </td>
                  <td>{include file="elements/status_pgsql_buttons.tpl"}</td>
                  </tr>
              {/foreach}

          {else}
            <tr><td colspan="5">{$message.strNoNode|escape}</td></tr>
          {/if}
          </tbody>

          <tfoot>
          <tr><th colspan="5" align="right">
              <input type="button" onClick="addBackendButtonHandler()"
                     value="{$message.strAddBackend|escape}">
              </th></tr>
          </tfoot>
        </table>
    {/if}

    {* ---------------------------------------------------------------------- *}
    {* Form to add a new backend                                              *}
    {* ---------------------------------------------------------------------- *}

    <div id="addBackendDiv" style="visibility: hidden; position: absolute;">
    <h3>{$message.strAddBackend|escape}  (node {$next_node_num})</h3>
    <form action="status.php" name="addBackendForm" method="post"
          onSubmit="return checkAddForm()" />
    <input type="hidden" name="action" value="addBackend" />

    <table>
    <thead>
        <tr><th colspan="2">new backend</th></tr>
    </thead>
    <tbody>
        {include file="elements/pgconfig_new_backend.tpl"}
        <tr>
        <th>{$message.strAddBackendNow|escape}</th>
        <td><input type="checkbox" name="reload_ok" id="reload_ok" checked></td>
        </tr>
    </tbody>
    <tfoot>
        <tr><td colspan="2">
        <input type="submit"
               value="{$message.strAdd|escape}" />
        <input type="button" name="command" onclick="cancelButtonHandler('addBackendDiv')"
               value="{$message.strCancel|escape}" />
        </td></tr>
    </tfoot>
    </table>

    </form>
    </div>

    {* --------------------------------------------------------------------- *}
    {* Form of options to stop/restart PostgreSQL                            *}
    {* --------------------------------------------------------------------- *}

    {include file="elements/status_pgsql_options.tpl"}

    {* --------------------------------------------------------------------- *}
    {* start / stop / reload                                                 *}
    {* --------------------------------------------------------------------- *}

    <h2>{$message.strPgpool|escape}
    {if !$pgpoolIsActive}[ {$message.strStoppingNow|escape} ]{/if}
    </h2>
    {include file="elements/status_options.tpl"}

    {* ---------------------------------------------------------------------- *}
    {* Command form to execute a command without any option                   *}
    {* ---------------------------------------------------------------------- *}

    <div id="commandDiv">
    <form action="status.php" name="commandForm" method="post" />
      <input type="hidden" name="action" />
      <input type="hidden" name="nodeNumber" />
    </form>
    </div>


</div>{* end div#content *}

<div id="footer">
{include file='footer.tpl'}
</div>
</body>
</html>
