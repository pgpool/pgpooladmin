<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>{$message.strPgConfSetting|escape}</title>
<link href="screen.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">
<!--
var msgDeleteConfirm = "{$message.msgDeleteConfirm|escape}";
{literal}
function update(){
    document.pgconfig.action.value= "update";
    document.pgconfig.submit();
}

function resetData(){
    document.pgconfig.action.value= "reset";
    document.pgconfig.submit();
}

function del(num){
    if(window.confirm(msgDeleteConfirm)){
        document.pgconfig.action.value= "delete";
        document.pgconfig.num.value = num;
        document.pgconfig.submit();
    }
}

function addNode() {
    document.pgconfig.action.value= "add";
    document.pgconfig.submit();
}

function cancelNode() {
    document.pgconfig.action.value= "cancel";
    document.pgconfig.submit();
}

function addOtherWatchdog() {
    document.pgconfig.action.value= "add_wd";
    document.pgconfig.submit();
}

function cancelOtherWatchdog() {
    document.pgconfig.action.value= "cancel_wd";
    document.pgconfig.submit();
}
function delOtherWatchdog(num){
    if(window.confirm(msgDeleteConfirm)){
        document.pgconfig.action.value= "delete_wd";
        document.pgconfig.num.value = num;
        document.pgconfig.submit();
    }
}


// -->
</script>
{/literal}
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

  {* --------------------------------------------------------------------- *
   * Succeeed / Failed                                                     *
   * --------------------------------------------------------------------- *}
  {if isset($status)}
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
  {/if}

  <h2>{$message.strPgConfSetting|escape}</h2>
  <div id="submenu">
    <h3>Table of Contents</h3>
    <ul>
      <li><a href="#connections">Connections</a></li>
      <li><a href="#pools">Pools</a></li>
      <li><a href="#backends">Backends</a></li>
      <li><a href="#logs">Logs</a></li>
      <li><a href="#file_locations">File Locations</a></li>
      <li><a href="#connection_pooling">Connection Pooling</a></li>
      <li><a href="#replication_mode">Replication Mode</a></li>
      <li><a href="#load_balancing_mode">Load Balancing Mode</a></li>
      <li><a href="#master_slave_mode">Mater/Slave Mode</a></li>
      <li><a href="#parallel_mode">{if hasMemqcache()}Parallel Mode
      {else}Parallel Mode and Query Cache{/if}</a></li>
      <li><a href="#health-check">Health Check</a></li>
      <li><a href="#failover">Failover and Failback</a></li>
      <li><a href="#recovery">Online Recovery</a></li>
      {if hasWatchdog()}
      <li><a href="#watchdog">Watchdog</a></li>
      {/if}
      {if hasMemqcache()}
      <li><a href="#memqcache">On Memory Query Cache</a></li>
      {/if}
      {if paramExists('relcache_expire')}
      <li><a href="#others">Others</a></li>
      {/if}
    </ul>
  </div>

  <form name="pgconfig" method="post" action="pgconfig.php">
    <input type="hidden" name="action" value="" />
    <input type="hidden" name="num" value="" />

    {* --------------------------------------------------------------------- *
     * Connections                                                           *
     * --------------------------------------------------------------------- *}
    <h3><a name="connections" id="connections">Connections</a></h3>

    <table>
      <thead>
        <tr>
          <th>{$message.strParameter|escape}</th>
          <th>{$message.strValue|escape}</th>
        </tr>
      </thead>
      <tfoot>
        <tr>
          <td colspan="2"></td>
        </tr>
      </tfoot>
      <tbody>

        {* --------------------------------------------------------------------- *}

        <tr><th class="category" colspan="2">pgpool Connection Settings</th></tr>

        <tr>
        <th{if isset($error.listen_addresses)} class="error"{/if}>
        <label>{$message.descListen_addresses|escape}</label>
        <br />listen_addresses (string) *</th>
        <td><input type="text" name="listen_addresses" value="{$params.listen_addresses|escape}"/></td>
        </tr>

        <tr>
        <th{if isset($error.port)} class="error"{/if}>
        <label>{$message.descPort|escape}</label>
        <br />port (integer) *</th>
        <td><input type="text" name="port" value="{$params.port|escape}"/></td>
        </tr>

        <tr>
        <th{if isset($error.socket_dir)} class="error"{/if}>
        <label>{$message.descSocket_dir|escape}</label>
        <br />socket_dir (string) *</th>
        <td><input type="text" name="socket_dir" value="{$params.socket_dir|escape}"/></td>
        </tr>

        {if paramExists('backend_socket_dir')}
            <tr>
            <th{if isset($error.backend_socket_dir)} class="error"{/if}>
            <label>{$message.descBackend_socket_dir|escape}</label>
            <br />backend_socket_dir (string) *</th>
            <td><input type="text" name="backend_socket_dir"
                 value="{$params.backend_socket_dir|escape}"/></td>
            </tr>
        {/if}

        {* --------------------------------------------------------------------- *}

        <tr><th class="category" colspan="2">pgpool Communication Manager Connection Settings</th></tr>

        <tr>
        <th{if isset($error.pcp_port)} class="error"{/if}>
        <label>{$message.descPcp_port|escape}</label>
        <br />pcp_port (integer) *</th>
        <td><input type="text" name="pcp_port" value="{$params.pcp_port|escape}"/></td>
        </tr>

        <tr>
        <th{if isset($error.pcp_socket_dir)} class="error"{/if}>
        <label>{$message.descPcp_socket_dir|escape}</label>
        <br />pcp_socket_dir (string) *</th>
        <td><input type="text" name="pcp_socket_dir" value="{$params.pcp_socket_dir|escape}"/></td>
        </tr>

        {* --------------------------------------------------------------------- *}

        <tr><th class="category" colspan="2">Authentication</th></tr>

        <tr>
        <th{if isset($error.enable_pool_hba)} class="error"{/if}>
        <label>{$message.descEnable_pool_hba|escape}</label>
        <br />enable_pool_hba (bool)</th>
        <td><input type="checkbox" name="enable_pool_hba" id="enable_pool_hba"
            {if $params.enable_pool_hba == 'on'}checked="checked"{/if} /></td>
        </tr>

        {if paramExists('pool_passwd')}
           <tr>
           <th{if isset($error.pool_passwd)} class="error"{/if}>
           <label>{$message.descPool_passwd|escape}</label>
           <br />pool_passwd (string) *</th>
           <td><input type="text" name="pool_passwd" value="{$params.pool_passwd|escape}"/></td>
           </tr>
        {/if}

        <tr>
        <th{if isset($error.authentication_timeout)} class="error"{/if}>
        <label>{$message.descAuthentication_timeout|escape}</label>
        <br />authentication_timeout (integer)</th>
        <td><input type="text" name="authentication_timeout" value="{$params.authentication_timeout|escape}"/></td>
        </tr>

        {* --------------------------------------------------------------------- *}

        {if paramExists('ssl')}
            <tr><th class="category" colspan="2">SSL Connections</th></tr>

            <tr>
            <th{if isset($error.ssl)} class="error"{/if}>
            <label>{$message.descSsl|escape}</label>
            <br />ssl (bool) *</th>
            <td><input type="checkbox" name="ssl" id="ssl" value="true"
                 {if $params.ssl == 'on'} checked="checked"{/if} /></td>
            </tr>

            <tr>
            <th{if isset($error.ssl_key)} class="error"{/if}>
            <label>{$message.descSsl_key|escape}</label>
            <br />ssl_key (string) *</th>
            <td><input type="text" name="ssl_key" id="ssl_key" value="{$params.ssl_key|escape}" /></td>
            </tr>

            <tr>
            <th{if isset($error.ssl_cert)} class="error"{/if}>
            <label>{$message.descSsl_cert|escape}</label>
            <br />ssl_cert (string) *</th>
            <td><input type="text" name="ssl_cert" id="ssl_cert" value="{$params.ssl_cert|escape}" /></td>
            </tr>

            <tr>
            <th{if isset($error.ssl_ca_cert)} class="error"{/if}>
            <label>{$message.descSsl_ca_cert|escape}</label>
            <br />ssl_ca_cert (string) *</th>
            <td><input type="text" name="ssl_ca_cert" id="ssl_ca_cert" value="{$params.ssl_ca_cert|escape}" /></td>
            </tr>

            <tr>
            <th{if isset($error.ssl_ca_cert_dir)} class="error"{/if}>
            <label>{$message.descSsl_ca_cert_dir|escape}</label>
            <br />ssl_ca_cert_dir (string) *</th>
            <td><input type="text" name="ssl_ca_cert_dir" id="ssl_ca_cert_dir"
                 value="{$params.ssl_ca_cert_dir|escape}" /></td>
            </tr>
        {/if}
    </table>


    {* --------------------------------------------------------------------- *
     * Pools                                                                 *
     * --------------------------------------------------------------------- *}
    <h3><a name="pools" id="pools">Pools</a></h3>

    <table>
      <thead>
        <tr>
          <th>{$message.strParameter|escape}</th>
          <th>{$message.strValue|escape}</th>
        </tr>
      </thead>
      <tfoot>
        <tr>
          <td colspan="2"></td>
        </tr>
      </tfoot>
      <tbody>

        {* --------------------------------------------------------------------- *}

        <tr><th class="category" colspan="2">Pool size</th></tr>

        <tr>
        <th{if isset($error.num_init_children)} class="error"{/if}>
        <label>{$message.descNum_init_children|escape}</label>
        <br />num_init_children (integer) *</th>
        <td><input type="text" name="num_init_children" value="{$params.num_init_children|escape}"/></td>
        </tr>

        <tr>
        <th{if isset($error.max_pool)} class="error"{/if}>
        <label>{$message.descMax_pool|escape}</label>
        <br />max_pool (integer) *</th>
        <td><input type="text" name="max_pool" value="{$params.max_pool|escape}"/></td>
        </tr>

        {* --------------------------------------------------------------------- *}

        <tr><th class="category" colspan="2">Life time</th></tr>

        <tr>
        <th{if isset($error.child_life_time)} class="error"{/if}>
        <label>{$message.descChild_life_time|escape}</label>
        <br />child_life_time (integer)</th>
        <td><input type="text" name="child_life_time" value="{$params.child_life_time|escape}"/></td>
        </tr>

        <tr>
        <th{if isset($error.child_max_connections)} class="error"{/if}>
        <label>{$message.descChild_max_connections|escape}</label>
        <br />child_max_connections (integer)</th>
        <td><input type="text" name="child_max_connections" value="{$params.child_max_connections|escape}"/></td>
        </tr>

        <tr>
        <th{if isset($error.connection_life_time)} class="error"{/if}>
        <label>{$message.descConnection_life_time|escape}</label>
        <br />connection_life_time (integer)</th>
        <td><input type="text" name="connection_life_time" value="{$params.connection_life_time|escape}"/></td>
        </tr>

        <tr>
        <th{if isset($error.client_idle_limit)} class="error"{/if}>
        <label>{$message.descClient_idle_limit|escape}</label>
        <br />client_idle_limit (integer)</th>
        <td><input type="text" name="client_idle_limit" value="{$params.client_idle_limit|escape}"/></td>
        </tr>

      </tbody>
    </table>


    {* --------------------------------------------------------------------- *
     * Backends                                                              *
     * --------------------------------------------------------------------- *}
    <h3><a name="backends" id="backends">Backends</a></h3>

    <table>
      <thead>
        <tr>
          <th>{$message.strParameter|escape}</th>
          <th>{$message.strValue|escape}</th>
          <td></td>
        </tr>
      </thead>

      {if isset($isAdd) && $isAdd == true}
          <tfoot>
            <tr>
               <td colspan="3">
               <input type="button" name="cancel" value="{$message.strCancel|escape}" onclick="cancelNode()" /></td>
            </tr>
          </tfoot>
      {else}
          <tfoot>
            <tr>
              <td colspan="3">
              <input type="button" name="add" value="{$message.strAdd|escape}" onclick="addNode()" /></td>
            </tr>
          </tfoot>
      {/if}
          <tbody>

          {section name=num loop=$params.backend_hostname}
          <tr>
          <th{if isset($error.backend_hostname[num])} class="error"{/if}>
          <label>{$message.descBackend_hostname|escape}</label>
          <br />backend_hostname{$smarty.section.num.index} (string)</th>
          <td><input type="text" name="backend_hostname[]" value="{$params.backend_hostname[num]|escape}" /></td>
          <td rowspan="{if paramExists('backend_flag')}5{else}4{/if}">
          <input type="button" name="delete" value="{$message.strDelete|escape}"
          onclick="del({$smarty.section.num.index})" /></td>
          </tr>

          <tr>
          <th{if isset($error.backend_port[num])} class="error"{/if}>
          <label>{$message.descBackend_port|escape}</label>
          <br />backend_port{$smarty.section.num.index|escape} (integer)</th>
          <td><input type="text" name="backend_port[]" value="{$params.backend_port[num]|escape}" /></td>
          </tr>

          <tr>
          <th{if isset($error.backend_weight[num])} class="error"{/if}>
          <label>{$message.descBackend_weight|escape}</label>
          <br />backend_weight{$smarty.section.num.index|escape} (float)</th>
          <td><input type="text" name="backend_weight[]" value="{$params.backend_weight[num]|escape}" /></td>
          </tr>

          <tr>
          <th{if isset($error.backend_data_directory[num])} class="error"{/if}>
          <label>{$message.descBackend_data_directory|escape}</label>
          <br />backend_data_directory{$smarty.section.num.index|escape} (string)</th>
          <td><input type="text" name="backend_data_directory[]"
               value="{$params.backend_data_directory[num]|escape}" /></td>
          </tr>

          {if paramExists('backend_flag')}
              <tr>
              <th{if isset($error.backend_flag[num])} class="error"{/if}>
              <label>{$message.descBackend_flag|escape}</label>
              <br />backend_flag{$smarty.section.num.index|escape} (string) *</th>
              <td><select name="backend_flag[]" id="backend_flag[]">
                  <option value="ALLOW_TO_FAILOVER"
                  {if $params.backend_flag[num] == 'ALLOW_TO_FAILOVER'}selected{/if}>ALLOW_TO_FAILOVER</option>
                  <option value="DISALLOW_TO_FAILOVER"
                  {if $params.backend_flag[num] == 'DISALLOW_TO_FAILOVER'}selected{/if}>DISALLOW_TO_FAILOVER</option>
                  </select></td>
              </tr>
          {/if}
          {/section}

          {if isset($isAdd) && $isAdd == true}
              <tr>
              <th><label>{$message.descBackend_hostname|escape}</label>
              <br />backend_hostname{$smarty.section.num.index} (string)</th>
              <td><input type="text" name="backend_hostname[]" value="" /></td>
              <td rowspan="{if paramExists('backend_flag')}5{else}4{/if}">
              </tr>

              </tr>
              <tr>
              <th><label>{$message.descBackend_port|escape}</label>
              <br />backend_port{$smarty.section.num.index|escape} (integer)</th>
              <td><input type="text" name="backend_port[]" value="" /></td>
              </tr>

              <tr>
              <th><label>{$message.descBackend_weight|escape}</label>
              <br />backend_weight{$smarty.section.num.index|escape} (float)</th>
              <td><input type="text" name="backend_weight[]" value="" /></td>
              </tr>

              <tr>
              <th><label>{$message.descBackend_data_directory|escape}</label>
              <br />backend_data_directory{$smarty.section.num.index|escape} (string)</th>
              <td><input type="text" name="backend_data_directory[]" value="" /></td>
              </tr>

              {if paramExists('backend_flag')}
                  <tr>
                  <th><label>{$message.descBackend_flag|escape}</label>
                  <br />backend_flag{$smarty.section.num.index|escape} *</th>
                  <td><select name="backend_flag[]" id="backend_flag[]">
                      <option value="ALLOW_TO_FAILOVER" selected>ALLOW_TO_FAILOVER</option>
                      <option value="DISALLOW_TO_FAILOVER">DISALLOW_TO_FAILOVER</option>
                      </select></td>
                  </tr>
              {/if}
          {/if}

      </tbody>
    </table>


    {* --------------------------------------------------------------------- *
     * Logs                                                                  *
     * --------------------------------------------------------------------- *}
    <h3><a name="logs" id="logs">Logs</a></h3>

    <table>
      <thead>
        <tr>
          <th>{$message.strParameter|escape}</th>
          <th>{$message.strValue|escape}</th>
        </tr>
      </thead>

      <tfoot>
        <tr>
          <td colspan="2"></td>
        </tr>
      </tfoot>

      <tbody>

        {* --------------------------------------------------------------------- *}

        {if paramExists('log_destination')}
            <tr><th class="category" colspan="2">Where to log</th></tr>

            <tr>
            {if isset($error.log_destination)}<th class="error">{else}<th>{/if}
            <label>{$message.descLog_destination|escape}</label>
            <br />log_destination *</th>
            <td><select name="log_destination" id="log_destination">
                <option value="stderr" {if $params.log_destination == 'stderr'}selected{/if}>stderr</option>
                <option value="syslog" {if $params.log_destination == 'syslog'}selected{/if}>syslog</option>
                </select></td>
            </tr>
        {/if}

        {* --------------------------------------------------------------------- *}

        <tr><th class="category" colspan="2">What to log</th></tr>

        <tr>
        <th{if isset($error.print_timestamp)} class="error"{/if}>
        <label>{$message.descPrint_timestamp|escape}</label>
        <br />print_timestamp (bool) *</th>
        {if $params.print_timestamp == 'on'}
        <td><input type="checkbox" name="print_timestamp"
             id="print_timestamp" value="true"
             {if $params.print_timestamp == 'on'}checked="checked"{/if} /></td>
        {/if}
        </tr>

        <tr>
        <th{if isset($error.log_connections)} class="error"{/if}>
        <label>{$message.descLog_connections|escape}</label>
        <br />log_connections (bool)</th>
        {if $params.log_connections == 'on'}
        <td><input type="checkbox" name="log_connections" id="log_connections" value="true"
             {if $params.log_connections == 'on'}checked="checked"{/if} /></td>
        </tr>

        <tr>
        <th{if isset($error.log_hostname)} class="error"{/if}>
        <label>{$message.descLog_hostname|escape}</label>
        <br />log_hostname (bool)</th>
        {/if}
        <td><input type="checkbox" name="log_hostname" id="log_hostname" value="true"
            {if $params.log_hostname == 'on'}checked="checked"{/if} /></td>
        </tr>

        <tr>
        <th{if isset($error.log_statement)} class="error"{/if}>
        <label>{$message.descLog_statement|escape}</label>
        <br />log_statement (bool)</th>
        <td><input type="checkbox" name="log_statement" id="log_statement" value="true"
            {if $params.log_statement == 'on'}checked="checked"{/if} /></td>
        </tr>

        {if paramExists('log_per_node_statement')}
            <tr>
            {if isset($error.log_per_node_statement)}<th class="error">{else}<th>{/if}
            <label>{$message.descLog_per_node_statement|escape}</label>
            <br />log_per_node_statement (bool)</th>
            <td><input type="checkbox" name="log_per_node_statement"
                id="log_per_node_statement" value="true"
                {if $params.log_per_node_statement == 'on'}checked="checked"{/if} /></td>
            </tr>
        {/if}

        {if paramExists('log_standby_delay')}
            <tr>
            <th{if isset($error.log_standby_delay)} class="error"{/if}>
            <label>{$message.descLog_standby_delay|escape}</label>
            <br />log_standby_delay (string)</th>
            <td><select name="log_standby_delay" id="log_standby_delay">
                <option value="always"
                {if $params.log_standby_delay == 'always'}selected{/if}>always</option>
                <option value="if_over_threshold"
                {if $params.log_standby_delay == 'if_over_threshold'}selected{/if}>if_over_threshold</option>
                <option value="none"
                {if $params.log_standby_delay == 'none'}selected{/if}>none</option>
                </select></td>
            </tr>
        {/if}

        {* --------------------------------------------------------------------- *}

        {if paramExists('syslog_facility')}
            <tr><th class="category" colspan="2">Syslog specific</th></tr>

            <tr>
            {if isset($error.syslog_facility)}<th class="error">{else}<th>{/if}
            <label>{$message.descSyslog_facility|escape}</label>
            <br />syslog_facility (string) *</th>
            <td><input type="text" name="syslog_facility" value="{$params.syslog_facility|escape}"/></td>
            </tr>

            <tr>
            {if isset($error.syslog_ident)}<th class="error">{else}<th>{/if}
            <label>{$message.descSyslog_ident|escape}</label>
            <br />syslog_ident (string) *</th>
            <td><input type="text" name="syslog_ident" value="{$params.syslog_ident|escape}"/></td>
            </tr>
        {/if}

        {* --------------------------------------------------------------------- *}

        {if paramExists('debug_level')}
            <tr><th class="category" colspan="2">Debug</th></tr>

            <tr>
            <th{if isset($error.debug_level)} class="error"{/if}>
            <label>{$message.descDebug_level|escape}</label>
            <br />debug_level (integer)</th>
            <td><input type="text" name="debug_level" value="{$params.debug_level|escape}"/></td>
            </tr>
        {/if}

      </tbody>
    </table>

    {* --------------------------------------------------------------------- *
     * File Locations                                                        *
     * --------------------------------------------------------------------- *}
    <h3><a name="file_locations" id="file_locations">File Locations</a></h3>

    <table>
      <thead>
        <tr>
          <th>{$message.strParameter|escape}</th>
          <th>{$message.strValue|escape}</th>
        </tr>
      </thead>
      <tfoot>
        <tr>
          <td colspan="2"></td>
        </tr>
      </tfoot>
      <tbody>

        <tr>
        <th{if isset($error.logdir)} class="error"{/if}>
        <label>{$message.descLogdir|escape}</label>
        <br />logdir (string) *</th>
        <td><input type="text" name="logdir" value="{$params.logdir|escape}"/></td>
        </tr>

        {if paramExists('pid_file_name')}
            <tr>
            <th{if isset($error.pid_file_name)} class="error"{/if}>
            <label>{$message.descPid_file_name|escape}</label>
            <br />pid_file_name (string) *</th>
            <td><input type="text" name="pid_file_name" value="{$params.pid_file_name|escape}"/></td>
            </tr>
        {/if}

      </tbody>
    </table>

    {* --------------------------------------------------------------------- *
     * Connection Pooling                                                    *
     * --------------------------------------------------------------------- *}
    <h3><a name="connection_pooling" id="connection_pooling">Connection Pooling</a></h3>

    <table>
      <thead>
        <tr>
          <th>{$message.strParameter|escape}</th>
          <th>{$message.strValue|escape}</th>
        </tr>
      </thead>
      <tfoot>
        <tr>
          <td colspan="2"></td>
        </tr>
      </tfoot>

      <tbody>

        <tr>
        <th{if isset($error.connection_cache)} class="error"{/if}>
        <label>{$message.descConnection_cache|escape}</label>
        <br />connection_cache (bool) *</th>
        <td><input type="checkbox" name="connection_cache"
            id="connection_cache" value="true"
            {if $params.connection_cache == 'on'}checked="checked"{/if} /></td>
        </tr>

        <tr>
        <th{if isset($error.reset_query_list)} class="error"{/if}>
        <label>{$message.descReset_query_list|escape}</label>
        <br />reset_query_list (string)</th>
        <td><input type="text" name="reset_query_list" value="{$params.reset_query_list|escape}"/></td>
        </tr>

      </tbody>
    </table>

    {* --------------------------------------------------------------------- *
     * Replication Mode                                                      *
     * --------------------------------------------------------------------- *}
    <h3><a name="replication_mode" id="replication_mode">Replication Mode</a></h3>

    <table>
      <thead>
        <tr>
          <th>{$message.strParameter|escape}</th>
          <th>{$message.strValue|escape}</th>
        </tr>
      </thead>
      <tfoot>
        <tr>
          <td colspan="2"></td>
        </tr>
      </tfoot>
      <tbody>

        <tr>
        <th{if isset($error.replication_mode)} class="error"{/if}>
        <label>{$message.descReplication_mode|escape}</label>
        <br />replication_mode (bool) *</th>
        <td><input type="checkbox" name="replication_mode"
             id="replication_mode" value="true"
             {if $params.replication_mode == 'on'} checked="checked"{/if} /></td>
        </tr>

        <tr>
        <th{if isset($error.replicate_select)} class="error"{/if}>
        <label>{$message.descReplicate_select|escape}</label>
        <br />replicate_select (bool)</th>
        <td><input type="checkbox" name="replicate_select"
             id="replicate_select" value="true"
             {if $params.replicate_select == 'on'}checked="checked"{/if} /></td>
        </tr>

        <tr>
        <th{if isset($error.insert_lock)} class="error"{/if}>
        <label>{$message.descInsert_lock|escape}</label>
        <br />insert_lock (bool)</th>
        <td><input type="checkbox" name="insert_lock" id="insert_lock" value="true"
            {if $params.insert_lock == 'on'}checked="checked"{/if} /></td>
        </tr>

        {if paramExists('lobj_lock_table')}
            <tr>
            <th{if isset($error.lobj_lock_table)} class="error"{/if}>
            <label>{$message.descLobj_lock_table|escape}</label>
            <br />lobj_lock_table (string)</th>
            <td><input type="text" name="lobj_lock_table"
                 id="lobj_lock_table" value="{$params.lobj_lock_table|escape}" /></td>
            </tr>
        {/if}

        {* --------------------------------------------------------------------- *}

        <tr><th class="category" colspan="2">Degenerate handling</th></tr>

        <tr>
        <th{if isset($error.replication_stop_on_mismatch)} class="error"{/if}>
        <label>{$message.descReplication_stop_on_mismatch|escape}</label>
        <br />replication_stop_on_mismatch (bool)</th>
        <td><input type="checkbox" name="replication_stop_on_mismatch"
            id="replication_stop_on_mismatch" value="true"
             {if $params.replication_stop_on_mismatch == 'on'}checked="checked"{/if} /></td>
        </tr>

        {if paramExists('failover_if_affected_tuples_mismatch')}
            <tr>
            <th{if isset($error.failover_if_affected_tuples_mismatch)} class="error"{/if}>
            <label>{$message.descFailover_if_affected_tuples_mismatch|escape}</label>
            <br />failover_if_affected_tuples_mismatch (bool)</th>
            <td><input type="checkbox" name="failover_if_affected_tuples_mismatch"
                id="failover_if_affected_tuples_mismatch" value="true"
                {if $params.failover_if_affected_tuples_mismatch == 'on'}checked="checked"{/if} /></td>
            </tr>
        {/if}

        {if paramExists('replication_timeout')}
            <tr>
            <th{if isset($error.replication_timeout)} class="error"{/if}>
            <label>{$message.descReplication_timeout|escape}</label>
            <br />replication_timeout (integer)</th>
            <td><input type="text" name="replication_timeout" value="{$params.replication_timeout|escape}"/></td>
            </tr>
        {/if}

      </tbody>
    </table>

    {* --------------------------------------------------------------------- *
     * Load Balancing Mode                                                   *
     * --------------------------------------------------------------------- *}
    <h3><a name="load_balancing_mode" id="load_balancing_mode">Load Balancing Mode</a></h3>

    <table>
      <thead>
        <tr>
          <th>{$message.strParameter|escape}</th>
          <th>{$message.strValue|escape}</th>
        </tr>
      </thead>
      <tfoot>
        <tr>
          <td colspan="2"></td>
        </tr>
      </tfoot>

      <tbody>

        <tr>
        <th{if isset($error.load_balance_mode)} class="error"{/if}>
        <label>{$message.descLoad_balance_mode|escape}</label>
        <br />load_balance_mode (bool) *</th>
        <td><input type="checkbox" name="load_balance_mode"
            id="load_balance_mode" value="true"
            {if $params.load_balance_mode == 'on'}checked="checked"{/if} /></td>
        </tr>

        <tr>
        <th{if isset($error.ignore_leading_white_space)} class="error"{/if}>
        <label>{$message.descIgnore_leading_white_space|escape}</label>
        <br />ignore_leading_white_space (bool)</th>
        <td><input type="checkbox" name="ignore_leading_white_space"
             id="ignore_leading_white_space" value="true"
             {if $params.ignore_leading_white_space == 'on'}checked="checked"{/if} /></td>
        </tr>

        {if paramExists('white_function_list')}
            <tr>
            <th{if isset($error.white_function_list)} class="error"{/if}>
            <label>{$message.descWhite_function_list|escape}</label>
            <br />white_function_list (string)</th>
            <td><input type="text" name="white_function_list" value="{$params.white_function_list|escape}"/></td>
            </tr>

            <tr>
            <th{if isset($error.black_function_list)} class="error"{/if}>
            <label>{$message.descBlack_function_list|escape}</label>
            <br />black_function_list (string)</th>
            <td><input type="text" name="black_function_list" value="{$params.black_function_list|escape}"/></td>
            </tr>
        {/if}

      </tbody>
    </table>

    {* --------------------------------------------------------------------- *
     * Master/Slave Mode                                                     *
     * --------------------------------------------------------------------- *}
    <h3><a name="master_slave_mode" id="master_slave_mode">Master/Slave Mode</a></h3>

    <table>
      <thead>
        <tr>
          <th>{$message.strParameter|escape}</th>
          <th>{$message.strValue|escape}</th>
        </tr>
      </thead>
      <tfoot>
        <tr>
          <td colspan="2"></td>
        </tr>
      </tfoot>

      <tbody>

        <tr>
        <th{if isset($error.master_slave_mode)} class="error"{/if}>
        <label>{$message.descMaster_slave_mode|escape}</label>
        <br />master_slave_mode (bool) *</th>
        <td><input type="checkbox" name="master_slave_mode"
            id="master_slave_mode" value="true"
            {if $params.master_slave_mode == 'on'}checked="checked"{/if} /></td>
        </tr>

        {if paramExists('master_slave_sub_mode')}
            <tr>
            <th{if isset($error.master_slave_sub_mode)} class="error"{/if}>
            <label>{$message.descMaster_slave_sub_mode|escape}</label>
            <br />master_slave_sub_mode (string) *</th>
            <td><select name="master_slave_sub_mode" id="master_slave_sub_mode">
                <option value="slony"
                {if $params.master_slave_sub_mode == 'slony'}selected{/if}>slony</option>
                <option value="stream"
                {if $params.master_slave_sub_mode == 'stream'}selected{/if}>stream</option>
                </select></td>
            </tr>
        {/if}

        {* --------------------------------------------------------------------- *}

        {if paramExists('sr_check_period')}
            <tr><th class="category" colspan="2">Streaming</th></tr>

            <tr>
            <th{if isset($error.sr_check_period)} class="error"{/if}>
            <label>{$message.descSr_check_period|escape}</label>
            <br />sr_check_period (integer) *</th>
            <td><input type="text" name="sr_check_period" value="{$params.sr_check_period|escape}"/></td>
            </tr>

            <tr>
            <th{if isset($error.sr_check_user)} class="error"{/if}>
            <label>{$message.descSr_check_user|escape}</label>
            <br />sr_check_user (string) *</th>
            <td><input type="text" name="sr_check_user" value="{$params.sr_check_user|escape}"/></td>
            </tr>

            <tr>
            <th{if isset($error.sr_check_password)} class="error"{/if}>
            <label>{$message.descSr_check_password|escape}</label>
            <br />sr_check_password (string) *</th>
            <td><input type="text" name="sr_check_password" value="{$params.sr_check_password|escape}"/></td>
            </tr>
        {/if}

        {if paramExists('delay_threshold')}
            <tr>
            <th{if isset($error.delay_threshold)} class="error"{/if}>
            <label>{$message.descDelay_threshold|escape}</label>
            <br />delay_threshold (integer)</th>
            <td><input type="text" name="delay_threshold"
                 id="delay_threshold" value="{$params.delay_threshold|escape}" /></td>
            </tr>
        {/if}

        {* --------------------------------------------------------------------- *}

        {if paramExists('follow_master_command')}
            <tr><th class="category" colspan="2">Special commands</th></tr>

            <tr>
            <th{if isset($error.follow_master_command)} class="error"{/if}>
            <label>{$message.descFollow_master_command|escape}</label>
            <br />follow_master_command (string) *</th>
            <td><input type="text" name="follow_master_command"
                 value="{$params.follow_master_command|escape}"/></td>
            </tr>
        {/if}

      </tbody>
    </table>

    {* --------------------------------------------------------------------- *
     * Parallel Mode                                                        *
     * --------------------------------------------------------------------- *}
    <h3><a name="parallel_mode" id="parallel_mode">{if hasMemqcache()}Parallel Mode{else}Parallel Mode and Query Cache{/if}</a></h3>

    <table>
      <thead>
        <tr>
          <th>{$message.strParameter|escape}</th>
          <th>{$message.strValue|escape}</th>
        </tr>
      </thead>
      <tfoot>
        <tr>
          <td colspan="2"></td>
        </tr>
      </tfoot>

      <tbody>

        <tr>
        <th{if isset($error.parallel_mode)} class="error"{/if}>
        <label>{$message.descParallel_mode|escape}</label>
        <br />parallel_mode (bool) *</th>
        <td><input type="checkbox" name="parallel_mode"
             id="parallel_mode" value="true"
             {if $params.parallel_mode == 'on'}checked="checked"{/if} /></td>
        </tr>

        {if hasMemqcache() == false}
            <tr>
            <th{if isset($error.enable_query_cache)} class="error"{/if}>
            <label>{$message.descEnable_query_cache|escape}</label>
            <br />enable_query_cache (bool) *</th>
            <td><input type="checkbox" name="enable_query_cache" id="enable_query_cache"
            {if $params.enable_query_cache == 'on'}checked="checked"{/if} /></td>
            </tr>
        {/if}

        <tr>
        {if isset($error.pgpool2_hostname)}
          <th><label>{$message.descPgpool2_hostname|escape}</label>
          <br />pgpool2_hostname (string) *</th>
          {else}
          <th><label>{$message.descPgpool2_hostname|escape}</label>
          <br />pgpool2_hostname (string) *</th>
          {/if}
          <td><input type="text" name="pgpool2_hostname" value="{$params.pgpool2_hostname|escape}"/></td>
        </tr>

        {* --------------------------------------------------------------------- *}

        <tr><th class="category" colspan="2">System DB info</th></tr>

        <tr>
        <th{if isset($error.system_db_hostname)} class="error"{/if}>
        <label>{$message.descSystem_db_hostname|escape}</label>
        <br />system_db_hostname (string) *</th>
        <td><input type="text" name="system_db_hostname" value="{$params.system_db_hostname|escape}"/></td>
        </tr>

        <tr>
        <th{if isset($error.system_db_port)} class="error"{/if}>
        <label>{$message.descSystem_db_port|escape}</label>
        <br />system_db_port (integer) *</th>
        <td><input type="text" name="system_db_port" value="{$params.system_db_port|escape}"/></td>
        </tr>

        <tr>
        <th{if isset($error.system_db_name)} class="error"{/if}>
        <label>{$message.descSystem_db_dbname|escape}</label>
        <br />system_db_dbname (string) *</th>
        <td><input type="text" name="system_db_dbname" value="{$params.system_db_dbname|escape}"/></td>
        </tr>

        <tr>
        <th{if isset($error.system_db_schema)} class="error"{/if}>
        <label>{$message.descSystem_db_schema|escape}</label>
        <br />system_db_schema (string) *</th>
        <td><input type="text" name="system_db_schema" value="{$params.system_db_schema|escape}"/></td>
        </tr>

        <tr>
        <th{if isset($error.system_db_schema)} class="error"{/if}>
        <label>{$message.descSystem_db_user|escape}</label>
        <br />system_db_user (string) *</th>
        <td><input type="text" name="system_db_user" value="{$params.system_db_user|escape}"/></td>
        </tr>

        <tr>
        <th{if isset($error.system_db_password)} class="error"{/if}>
        <label>{$message.descSystem_db_password|escape}</label>
        <br />system_db_password (string) *</th>
        <td><input type="password" name="system_db_password" value="{$params.system_db_password|escape}"/></td>
        </tr>

      </tbody>
    </table>

    {* --------------------------------------------------------------------- *
     * Health Check                                                          *
     * --------------------------------------------------------------------- *}
    <h3><a name="health-check" id="health-check">Health Check</a></h3>

    <table>
      <thead>
        <tr>
          <th>{$message.strParameter|escape}</th>
          <th>{$message.strValue|escape}</th>
        </tr>
      </thead>
      <tfoot>
        <tr>
          <td colspan="2"></td>
        </tr>
      </tfoot>

      <tbody>
        <tr>
        <th{if isset($error.health_check_timeout)} class="error"{/if}>
        <label>{$message.descHealth_check_timeout|escape}</label>
        <br />health_check_timeout (integer)</th>
        <td><input type="text" name="health_check_timeout" value="{$params.health_check_timeout|escape}"/></td>
        </tr>

        <tr>
        <th{if isset($error.health_check_period)} class="error"{/if}>
        <label>{$message.descHealth_check_period|escape}</label>
        <br />health_check_period (integer)</th>
        <td><input type="text" name="health_check_period" value="{$params.health_check_period|escape}"/></td>
        </tr>

        <tr>
        <th{if isset($error.health_check_user)} class="error"{/if}>
        <label>{$message.descHealth_check_user|escape}</label>
        <br />health_check_user (string)</th>
        <td><input type="text" name="health_check_user" value="{$params.health_check_user|escape}"/></td>
        </tr>

        {if paramExists('health_check_password')}
            <tr>
            <th{if isset($error.health_check_password)} class="error"{/if}>
            <label>{$message.descHealth_check_password|escape}</label>
            <br />health_check_password (string)</th>
            <td><input type="text" name="health_check_password" value="{$params.health_check_password|escape}"/></td>
            </tr>
        {/if}

        {if paramExists('health_check_max_retries')}
            <tr>
            <th{if isset($error.health_check_max_retries)} class="error"{/if}>
            <label>{$message.descHealth_check_max_retries|escape}</label>
            <br />health_check_max_retries (integer)</th>
            <td><input type="text" name="health_check_max_retries" value="{$params.health_check_max_retries|escape}"/></td>
            </tr>

            <tr>
            <th{if isset($error.health_check_retry_delay)} class="error"{/if}>
            <label>{$message.descHealth_check_retry_delay|escape}</label>
            <br />health_check_retry_delay (integer)</th>
            <td><input type="text" name="health_check_retry_delay" value="{$params.health_check_retry_delay|escape}"/></td>
            </tr>
        {/if}
      </tbody>
    </table>

    {* --------------------------------------------------------------------- *
     * Failover and Failback                                                 *
     * --------------------------------------------------------------------- *}
    <h3><a name="failover" id="failover">Failover and Failback</a></h3>

    <table>
      <thead>
        <tr>
          <th>{$message.strParameter|escape}</th>
          <th>{$message.strValue|escape}</th>
        </tr>
      </thead>
      <tfoot>
        <tr>
          <td colspan="2"></td>
        </tr>
      </tfoot>

      <tbody>

        <tr>
        <th{if isset($error.failover_command)} class="error"{/if}>
        <label>{$message.descFailover_command|escape}</label>
        <br />failover_command (string)</th>
        <td><input type="text" name="failover_command" value="{$params.failover_command|escape}"/></td>
        </tr>

        <tr>
        <th{if isset($error.failback_command)} class="error"{/if}>
        <label>{$message.descFailback_command|escape}</label>
        <br />failback_command (string)</th>
        <td><input type="text" name="failback_command" value="{$params.failback_command|escape}"/></td>
        </tr>

        {if paramExists('fail_over_on_backend_error')}
            <tr>
            <th{if isset($error.fail_over_on_backend_error)} class="error"{/if}>
            <label>{$message.descFail_over_on_backend_error|escape}</label>
            <br />fail_over_on_backend_error</th>
            <td><input type="checkbox" name="fail_over_on_backend_error"
                 id="fail_over_on_backend_error" value="true"
                 {if $params.fail_over_on_backend_error == 'on'}checked="checked"{/if} /></td>
            </tr>
        {/if}

      </tbody>
    </table>

    {* --------------------------------------------------------------------- *
     * Online Recovery                                                       *
     * --------------------------------------------------------------------- *}
    <h3><a name="recovery" id="recovery">Online Recovery</a></h3>

    <table>
      <thead>
        <tr>
          <th>{$message.strParameter|escape}</th>
          <th>{$message.strValue|escape}</th>
        </tr>
      </thead>
      <tfoot>
        <tr>
          <td colspan="2"></td>
        </tr>
      </tfoot>

      <tbody>
        <tr>
        <th{if isset($error.recovery_user)} class="error"{/if}>
        <label>{$message.descRecovery_user|escape}</label>
        <br />recovery_user (string)</th>
        <td><input type="text" name="recovery_user" value="{$params.recovery_user|escape}"/></td>
        </tr>

        <tr>
        <th{if isset($error.recovery_password)} class="error"{/if}>
        <label>{$message.descRecovery_password|escape}</label>
        <br />recovery_password (string)</th>
        <td><input type="password" name="recovery_password" value="{$params.recovery_password|escape}"/></td>
        </tr>

        <tr>
        <th{if isset($error.recovery_1st_stage_command)} class="error"{/if}>
        <label>{$message.descRecovery_1st_stage_command|escape}</label>
        <br />recovery_1st_stage_command (string)</th>
        <td><input type="text" name="recovery_1st_stage_command"
             value="{$params.recovery_1st_stage_command|escape}"/></td>
        </tr>

        <tr>
        <th{if isset($error.recovery_2nd_stage_command)} class="error"{/if}>
        <label>{$message.descRecovery_2nd_stage_command|escape}</label>
        <br />recovery_2nd_stage_command (string)</th>
        <td><input type="text" name="recovery_2nd_stage_command"
             value="{$params.recovery_2nd_stage_command|escape}"/></td>
        </tr>

        <tr>
        <th{if isset($error.recovery_timeout)} class="error"{/if}>
        <label>{$message.descRecovery_timeout|escape}</label>
        <br />recovery_timeout (integer)</th>
        <td><input type="text" name="recovery_timeout" value="{$params.recovery_timeout|escape}"/></td>
        </tr>

        {if paramExists('client_idle_limit_in_recovery')}
            <tr>
            <th{if isset($error.client_idle_limit_in_recovery)} class="error"{/if}>
            <label>{$message.descClient_idle_limit_in_recovery|escape}</label>
            <br />client_idle_limit_in_recovery (integer)</th>
            <td><input type="text" name="client_idle_limit_in_recovery"
                 value="{$params.client_idle_limit_in_recovery|escape}"/></td>
            </tr>
        {/if}
      </tbody>
    </table>

    {if hasWatchdog()}
    {* --------------------------------------------------------------------- *
     * Watchdog                                                              *
     * --------------------------------------------------------------------- *}
    <h3><a name="watchdog" id="watchdog">Watchdog</a></h3>

    <table>
      <thead>
        <tr>
          <th>{$message.strParameter|escape}</th>
          <th colspan="2">{$message.strValue|escape}</th>
        </tr>
      </thead>
      <tbody>

        <tr>
        <th{if isset($error.use_watchdog)} class="error"{/if}>
        <label>{$message.descUse_watchdog|escape}</label>
        <br />use_watchdog (bool) *</th>
        <td colspan="2"><input type="checkbox" name="use_watchdog" id="use_watchdog" value="true"
            {if $params.use_watchdog== 'on'}checked="checked"{/if} /></td>
        </tr>

        <tr><th class="category" colspan="3">Connection to up stream servers</th></tr>

        <tr>
        <th{if isset($error.trusted_servers)} class="error"{/if}>
        <label>{$message.descTrusted_servers|escape}</label>
        <br />trusted_servers (string) *</th>
        <td colspan="2"><input type="text" name="trusted_servers" value="{$params.trusted_servers|escape}"/></td>
        </tr>

        <tr>
        <th{if isset($error.ping_path)} class="error"{/if}>
        <label>{$message.descPing_path|escape}</label>
        <br />ping_path (string) *</th>
        <td colspan="2"><input type="text" name="ping_path" value="{$params.ping_path|escape}"/></td>
        </tr>

        <tr><th class="category" colspan="3">Lifecheck of pgpol-II</th></tr>

        <tr>
        <th{if isset($error.wd_interval)} class="error"{/if}>
        <label>{$message.descWd_interval|escape}</label>
        <br />wd_interval (integer) *</th>
        <td colspan="2"><input type="text" name="wd_interval" value="{$params.wd_interval|escape}"/></td>
        </tr>

        <tr>
        <th{if isset($error.wd_life_point)} class="error"{/if}>
        <label>{$message.descWd_life_point|escape}</label>
        <br />wd_life_point(integer) *</th>
        <td colspan="2"><input type="text" name="wd_life_point" value="{$params.wd_life_point|escape}"/></td>
        </tr>

        <tr>
        <th{if isset($error.wd_lifecheck_query)} class="error"{/if}>
        <label>{$message.descWd_lifecheck_query|escape}</label>
        <br />wd_lifecheck_query (string) *</th>
        <td colspan="2"><input type="text" name="wd_lifecheck_query" value="{$params.wd_lifecheck_query|escape}"/></td>
        </tr>

        <tr><th class="category" colspan="3">Virtual IP address</th></tr>

        <tr>
        <th{if isset($error.delegate_IP)} class="error"{/if}>
        <label>{$message.descDelegate_IP|escape}</label>
        <br />delegate_IP (string) *</th>
        <td colspan="2"><input type="text" name="delegate_IP" value="{$params.delegate_IP|escape}"/></td>
        </tr>

        <tr>
        <th{if isset($error.ifconfig_path)} class="error"{/if}>
        <label>{$message.descIfconfig_path|escape}</label>
        <br />ifconfig_path (string) *</th>
        <td colspan="2"><input type="text" name="ifconfig_path" value="{$params.ifconfig_path|escape}"/></td>
        </tr>

        <tr>
        <th{if isset($error.if_up_cmd)} class="error"{/if}>
        <label>{$message.descIf_up_cmd|escape}</label>
        <br />if_up_cmd (string) *</th>
        <td colspan="2"><input type="text" name="if_up_cmd" value="{$params.if_up_cmd|escape}"/></td>
        </tr>

        <tr>
        <th{if isset($error.if_down_cmd)} class="error"{/if}>
        <label>{$message.descIf_down_cmd|escape}</label>
        <br />if_down_cmd (string) *</th>
        <td colspan="2"><input type="text" name="if_down_cmd" value="{$params.if_down_cmd|escape}"/></td>
        </tr>

        <tr>
        <th{if isset($error.arping_path)} class="error"{/if}>
        <label>{$message.descArping_path|escape}</label>
        <br />arping_path (string) *</th>
        <td colspan="2"><input type="text" name="arping_path" value="{$params.arping_path|escape}"/></td>
        </tr>

        <tr>
        <th{if isset($error.arping_cmd)} class="error"{/if}>
        <label>{$message.descArping_cmd|escape}</label>
        <br />arping_cmd (string) *</th>
        <td colspan="2"><input type="text" name="arping_cmd" value="{$params.arping_cmd|escape}"/></td>
        </tr>

        <tr><th class="category" colspan="3">Server itself to be monitored</th></tr>

        <tr>
        <th{if isset($error.wd_hostname)} class="error"{/if}>
        <label>{$message.descWd_hostname|escape}</label>
        <br />wd_hostname (string) *</th>
        <td colspan="2"><input type="text" name="wd_hostname" value="{$params.wd_hostname|escape}"/></td>
        </tr>

        <tr>
        <th{if isset($error.wd_port)} class="error"{/if}>
        <label>{$message.descWd_port|escape}</label>
        <br />wd_port (integer) *</th>
        <td colspan="2"><input type="text" name="wd_port" value="{$params.wd_port|escape}"/></td>
        </tr>

        <tr><th class="category" colspan="3">Servers to monitor</th></tr>

          {section name=num loop=$params.other_pgpool_hostname}
          <tr>
          <th{if isset($error.other_pgpool_hostname[num])} class="error"{/if}>
          <label>{$message.descOther_pgpool_hostname|escape}</label>
          <br />other_pgpool_hostname{$smarty.section.num.index} (string)</th>
          <td><input type="text" name="other_pgpool_hostname[]" value="{$params.other_pgpool_hostname[num]|escape}" /></td>
          <td rowspan="3">
          <input type="button" name="delete" value="{$message.strDelete|escape}"
          onclick="delOtherWatchdog({$smarty.section.num.index})" /></td>
          </tr>

          <tr>
          <th{if isset($error.other_pgpool_port[num])} class="error"{/if}>
          <label>{$message.descOther_pgpool_port|escape}</label>
          <br />other_pgpool_port{$smarty.section.num.index|escape} (integer)</th>
          <td><input type="text" name="other_pgpool_port[]" value="{$params.other_pgpool_port[num]|escape}" /></td>
          </tr>

          <tr>
          <th{if isset($error.other_wd_port[num])} class="error"{/if}>
          <label>{$message.descOther_wd_port|escape}</label>
          <br />other_wd_port{$smarty.section.num.index|escape} (integer)</th>
          <td><input type="text" name="other_wd_port[]" value="{$params.other_wd_port[num]|escape}" /></td>
          </tr>
          {/section}

          {if isset($isAddWd) && $isAddWd == true}
              <tr>
              <th><label>{$message.descOther_pgpool_hostname|escape}</label>
              <br />other_pgpool_hostname{$smarty.section.num.index} (string)</th>
              <td><input type="text" name="other_pgpool_hostname[]" value="" /></td>
              </tr>

              <tr>
              <th><label>{$message.descOther_pgpool_port|escape}</label>
              <br />other_pgpool_port{$smarty.section.num.index|escape} (integer)</th>
              <td><input type="text" name="other_pgpool_port[]" value="" /></td>
              </tr>

              <tr>
              <th><label>{$message.descOther_wd_port|escape}</label>
              <br />other_wd_port{$smarty.section.num.index|escape} (integer)</th>
              <td><input type="text" name="other_wd_port[]" value="" /></td>
              </tr>
          {/if}

      </tbody>
      {if isset($isAddWd) && $isAddWd == true}
          <tfoot>
            <tr>
               <td colspan="3">
               <input type="button" name="cancel" value="{$message.strCancel|escape}" onclick="cancelOtherWatchdog()" /></td>
            </tr>
          </tfoot>
      {else}
          <tfoot>
            <tr>
              <td colspan="3">
              <input type="button" name="add" value="{$message.strAdd|escape}" onclick="addOtherWatchdog()" /></td>
            </tr>
          </tfoot>
      {/if}
    </table>
    {/if}

    {if hasMemqcache()}
    {* --------------------------------------------------------------------- *
     * On Memory Query Cache                                                 *
     * --------------------------------------------------------------------- *}
    <h3><a name="memqcache" id="memqcache">On Memory Query Cache</a></h3>

    <table>
      <thead>
        <tr>
          <th>{$message.strParameter|escape}</th>
          <th>{$message.strValue|escape}</th>
        </tr>
      </thead>
      <tfoot>
        <tr>
          <td colspan="2"></td>
        </tr>
      </tfoot>
      <tbody>

        <tr>
        <th{if isset($error.memory_cache_enabled)} class="error"{/if}>
        <label>{$message.descMemory_cache_enabled|escape}</label>
        <br />memory_cache_enabled (bool)</th>
        <td><input type="checkbox" name="memory_cache_enabled" id="memory_cache_enabled" value="true"
            {if $params.memory_cache_enabled == 'on'}checked="checked"{/if} /></td>
        </tr>

        <tr>
        <th{if isset($error.memqcache_method)} class="error"{/if}>
        <label>{$message.descMemqcache_method|escape}</label>
        <br />memqcache_method (string) *</th>
        <td><select name="memqcache_method" id="memqcache_method">
            <option value="shmem" {if $params.memqcache_method == 'shmem'}selected{/if}>shmem</option>
            <option value="memcached" {if $params.memqcache_method == 'memcached'}selected{/if}>memcached</option>
            </select></td>
        </tr>

        <tr><th class="category" colspan="2">Memcached specific</th></tr>

        <tr>
        <th{if isset($error.memqcache_memcached_host)} class="error"{/if}>
        <label>{$message.descMemqcache_memcached_host|escape}</label>
        <br />memqcache_memcached_host (string) *</th>
        <td><input type="text" name="memqcache_memcached_host" value="{$params.memqcache_memcached_host|escape}"/></td>
        </tr>

        <tr>
        <th{if isset($error.memqcache_memcached_port)} class="error"{/if}>
        <label>{$message.descMemqcache_memcached_port|escape}</label>
        <br />memqcache_memcached_port (integer) *</th>
        <td><input type="text" name="memqcache_memcached_port" value="{$params.memqcache_memcached_port|escape}"/></td>
        </tr>

        <tr><th class="category" colspan="2">Shared memory specific</th></tr>

        <tr>
        <th{if isset($error.memqcache_total_size)} class="error"{/if}>
        <label>{$message.descMemqcache_total_size|escape}</label>
        <br />memqcache_total_size (integer) *</th>
        <td><input type="text" name="memqcache_total_size" value="{$params.memqcache_total_size|escape}"/></td>
        </tr>

        <tr>
        <th{if isset($error.memqcache_max_num_cache)} class="error"{/if}>
        <label>{$message.descMemqcache_max_num_cache|escape}</label>
        <br />memqcache_max_num_cache (integer) *</th>
        <td><input type="text" name="memqcache_max_num_cache" value="{$params.memqcache_max_num_cache|escape}"/></td>
        </tr>

        <tr>
        <th{if isset($error.memqcache_cache_block_size)} class="error"{/if}>
        <label>{$message.descMemqcache_cache_block_size|escape}</label>
        <br />memqcache_cache_block_size (integer) *</th>
        <td><input type="text" name="memqcache_cache_block_size" value="{$params.memqcache_cache_block_size|escape}"/></td>
        </tr>

        <tr><th class="category" colspan="2">Common</th></tr>

        <tr>
        <th{if isset($error.memqcache_expire)} class="error"{/if}>
        <label>{$message.descMemqcache_expire|escape}</label>
        <br />memqcache_expire (integer) *</th>
        <td><input type="text" name="memqcache_expire" value="{$params.memqcache_expire|escape}"/></td>
        </tr>

        <tr>
        <th{if isset($error.memqcache_auto_cache_invalidation)} class="error"{/if}>
        <label>{$message.descMemqcache_auto_cache_invalidation|escape}</label>
        <br />memqcache_auto_cache_invalidation *</th>
        <td><input type="checkbox" name="memqcache_auto_cache_invalidation" id="memqcache_auto_cache_invalidation"
             value="true"{if $params.memqcache_auto_cache_invalidation == 'on'} checked="checked"{/if} /></td>
        </tr>

        <tr>
        <th{if isset($error.memqcache_maxcache)} class="error"{/if}>
        <label>{$message.descMemqcache_maxcache|escape}</label>
        <br />memqcache_maxcache (integer) *</th>
        <td><input type="text" name="memqcache_maxcache" value="{$params.memqcache_maxcache|escape}"/></td>
        </tr>

        <tr>
        <th{if isset($error.memqcache_oiddir)} class="error"{/if}>
        <label>{$message.descMemqcache_oiddir|escape}</label>
        <br />memqcache_oiddir (string) *</th>
        <td><input type="text" name="memqcache_oiddir" value="{$params.memqcache_oiddir|escape}"/></td>
        </tr>

        <tr>
        <th{if isset($error.white_memqcache_table_list)} class="error"{/if}>
        <label>{$message.descWhite_memqcache_table_list|escape}</label>
        <br />white_memqcache_table_list (string)</th>
        <td><input type="text" name="white_memqcache_table_list" value="{$params.white_memqcache_table_list|escape}"/></td>
        </tr>

        <tr>
        <th{if isset($error.black_memqcache_table_list)} class="error"{/if}>
        <label>{$message.descBlack_memqcache_table_list|escape}</label>
        <br />black_memqcache_table_list (string)</th>
        <td><input type="text" name="black_memqcache_table_list" value="{$params.black_memqcache_table_list|escape}"/></td>
        </tr>

      </tbody>
    </table>
    {/if}

    {if paramExists('relcache_expire')}
        {* --------------------------------------------------------------------- *
         * Others                                                                *
         * --------------------------------------------------------------------- *}
        <h3><a name="others" id="others">Others</a></h3>

        <table>
          <thead>
            <tr>
              <th>{$message.strParameter|escape}</th>
              <th>{$message.strValue|escape}</th>
            </tr>
          </thead>
          <tfoot>
            <tr>
              <td colspan="2"></td>
            </tr>
          </tfoot>
          <tbody>

            <tr>
            <th{if isset($error.relcache_expire)} class="error"{/if}>
            <label>{$message.descRelcache_expire|escape}</label>
            <br />relcache_expire (integer)</th>
            <td><input type="text" name="relcache_expire" value="{$params.relcache_expire|escape}"/></td>
            </tr>

            {if paramExists('relcache_size')}
                <tr>
                <th{if isset($error.relcache_size)} class="error"{/if}>
                <label>{$message.descRelcache_size|escape}</label>
                <br />relcache_size (integer)</th>
                <td><input type="text" name="relcache_size" value="{$params.relcache_size|escape}"/></td>
                </tr>
            {/if}

            {if paramExists('check_temp_table')}
                <tr>
                <th{if isset($error.check_temp_table)} class="error"{/if}>
                <label>{$message.descCheck_temp_table|escape}</label>
                <br />check_temp_table (bool)</th>
                <td><input type="checkbox" name="check_temp_table" id="check_temp_table" value="true"
                    {if $params.check_temp_table == 'on'}checked="checked"{/if} /></td>
                </tr>
            {/if}

          </tbody>
        </table>
    {/if}

    {* --------------------------------------------------------------------- *
     * Form End                                                              *
     * --------------------------------------------------------------------- *}
    <p>
      <input type="button" name="btnSubmit" value="{$message.strUpdate|escape}" onclick="update()"/>
      <input type="button" name="btnReset" value="{$message.strReset|escape}" onclick="resetData()"/>
    </p>
  </form>

  <p>{$message.cautionaryNote|escape}</p>
</div>

<hr class="hidden" />
<div id="footer">
{include file='footer.tpl'}
</div>
</body>
</html>
