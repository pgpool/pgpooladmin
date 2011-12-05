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
      <li><a href="#parallel_mode">Parallel Mode and Query Cache</a></li>
      <li><a href="#health-check">Health Check</a></li>
      <li><a href="#failover">Failover and Failback</a></li>
      <li><a href="#recovery">Online Recovery</a></li>
      <li><a href="#others">Others</a></li>
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

        <tr> {if $error.listen_addresses != null}
          <th class="error"><label>{$message.descListen_addresses|escape}</label>
          <br />listen_addresses (string) *</th>
          {else}
          <th><label>{$message.descListen_addresses|escape}</label>
          <br />listen_addresses (string) *</th>
          {/if}
          <td><input type="text" name="listen_addresses" value="{$params.listen_addresses|escape}"/></td>
        </tr>

        <tr> {if $error.port != null}
          <th class="error"><label>{$message.descPort|escape}</label>
          <br />port (integer) *</th>
          {else}
          <th><label>{$message.descPort|escape}</label>
          <br />port (integer) *</th>
          {/if}
          <td><input type="text" name="port" value="{$params.port|escape}"/></td>
        </tr>

        <tr> {if $error.socket_dir != null}
          <th class="error"><label>{$message.descSocket_dir|escape}</label>
          <br />socket_dir (string) *</th>
          {else}
          <th><label>{$message.descSocket_dir|escape}</label>
          <br />socket_dir (string) *</th>
          {/if}
          <td><input type="text" name="socket_dir" value="{$params.socket_dir|escape}"/></td>
        </tr>

        {* --------------------------------------------------------------------- *}

        <tr><th class="category" colspan="2">pgpool Communication Manager Connection Settings</th></tr>

        <tr> {if $error.pcp_port != null}
          <th class="error"><label>{$message.descPcp_port|escape}</label>
          <br />pcp_port (integer) *</th>
          {else}
          <th><label>{$message.descPcp_port|escape}</label>
          <br />pcp_port (integer) *</th>
          {/if}
          <td><input type="text" name="pcp_port" value="{$params.pcp_port|escape}"/></td>
        </tr>

        <tr> {if $error.pcp_socket_dir != null}
          <th class="error"><label>{$message.descPcp_socket_dir|escape}</label>
          <br />pcp_socket_dir (string) *</th>
          {else}
          <th><label>{$message.descPcp_socket_dir|escape}</label>
          <br />pcp_socket_dir (string) *</th>
          {/if}
          <td><input type="text" name="pcp_socket_dir" value="{$params.pcp_socket_dir|escape}"/></td>
        </tr>

        {* --------------------------------------------------------------------- *}

        <tr><th class="category" colspan="2">Authentication</th></tr>

        <tr> {if $error.enable_pool_hba != null}
          <th class="error"><label>{$message.descEnable_pool_hba|escape}</label>
                    <br />enable_pool_hba</th>
          {else}
          <th><label>{$message.descEnable_pool_hba|escape}</label>
                    <br />enable_pool_hba</th>
          {/if}
          {if $params.enable_pool_hba == 'on'}
          <td><input type="checkbox" name="enable_pool_hba" id="enable_pool_hba" checked="checked" /></td>
          {else}
          <td><input type="checkbox" name="enable_pool_hba" id="enable_pool_hba" /></td>
          {/if}
        </tr>

        <tr> {if $error.authentication_timeout != null}
          <th class="error"><label>{$message.descAuthentication_timeout|escape}</label>
          <br />authentication_timeout (integer)</th>
          {else}
          <th><label>{$message.descAuthentication_timeout|escape}</label>
          <br />authentication_timeout (integer)</th>
          {/if}
          <td><input type="text" name="authentication_timeout" value="{$params.authentication_timeout|escape}"/></td>
        </tr>

        {* --------------------------------------------------------------------- *}

        <tr><th class="category" colspan="2">SSL Connections</th></tr>

        <tr> {if $error.ssl != null}
          <th class="error"><label>{$message.descSsl|escape}</label>
                    <br />ssl</th>
          {else}
          <th><label>{$message.descSsl|escape}</label>
                    <br />ssl</th>
          {/if}
          {if $params.ssl == 'on'}
          <td><input type="checkbox" name="ssl" id="ssl" value="true" checked="checked" /></td>
          {else}
          <td><input type="checkbox" name="ssl" id="ssl" value="false" /></td>
          {/if} </tr>
        </tr>

        <tr> {if $error.ssl_key != null}
          <th class="error"><label>{$message.descSsl_key|escape}</label>
                    <br />ssl_key</th>
          {else}
          <th><label>{$message.descSsl_key|escape}</label>
                    <br />ssl_key</th>
          {/if}
          <td><input type="text" name="ssl_key" id="ssl_key" value="{$params.ssl_key|escape}" /></td>
        </tr>

        <tr> {if $error.ssl_cert != null}
          <th class="error"><label>{$message.descSsl_cert|escape}</label>
                    <br />ssl_cert</th>
          {else}
          <th><label>{$message.descSsl_cert|escape}</label>
                    <br />ssl_cert</th>
          {/if}
          <td><input type="text" name="ssl_cert" id="ssl_cert" value="{$params.ssl_cert|escape}" /></td>
        </tr>

        <tr> {if $error.ssl_ca_cert != null}
          <th class="error"><label>{$message.descSsl_ca_cert|escape}</label>
                    <br />ssl_ca_cert</th>
          {else}
          <th><label>{$message.descSsl_ca_cert|escape}</label>
                    <br />ssl_ca_cert</th>
          {/if}
          <td><input type="text" name="ssl_ca_cert" id="ssl_ca_cert" value="{$params.ssl_ca_cert|escape}" /></td>
        </tr>

        <tr> {if $error.ssl_ca_cert_dir != null}
          <th class="error"><label>{$message.descSsl_ca_cert_dir|escape}</label>
                    <br />ssl_ca_cert_dir</th>
          {else}
          <th><label>{$message.descSsl_ca_cert_dir|escape}</label>
                    <br />ssl_ca_cert_dir</th>
          {/if}
          <td><input type="text" name="ssl_ca_cert_dir" id="ssl_ca_cert_dir"
               value="{$params.ssl_ca_cert_dir|escape}" /></td>
        </tr>
    </table>


    {* --------------------------------------------------------------------- *
     * Connections                                                           *
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

        <tr> {if $error.num_init_children != null}
          <th class="error"><label>{$message.descNum_init_children|escape}</label>
          <br />num_init_children (integer) *</th>
          {else}
          <th><label>{$message.descNum_init_children|escape}</label>
          <br />num_init_children (integer) *</th>
          {/if}
          <td><input type="text" name="num_init_children" value="{$params.num_init_children|escape}"/></td>
        </tr>

        <tr> {if $error.max_pool != null}
          <th class="error"><label>{$message.descMax_pool|escape}</label>
          <br />max_pool (integer) *</th>
          {else}
          <th><label>{$message.descMax_pool|escape}</label>
          <br />max_pool (integer) *</th>
          {/if}
          <td><input type="text" name="max_pool" value="{$params.max_pool|escape}"/></td>
        </tr>

        {* --------------------------------------------------------------------- *}

        <tr><th class="category" colspan="2">Life time</th></tr>

        <tr> {if $error.child_life_time != null}
          <th class="error"><label>{$message.descChild_life_time|escape}</label>
          <br />child_life_time (integer)</th>
          {else}
          <th><label>{$message.descChild_life_time|escape}</label>
          <br />child_life_time (integer)</th>
          {/if}
          <td><input type="text" name="child_life_time" value="{$params.child_life_time|escape}"/></td>
        </tr>

        <tr> {if $error.child_max_connections != null}
          <th class="error"><label>{$message.descChild_max_connections|escape}</label>
          <br />child_max_connections (integer)</th>
          {else}
          <th><label>{$message.descChild_max_connections|escape}</label>
          <br />child_max_connections (integer)</th>
          {/if}
          <td><input type="text" name="child_max_connections" value="{$params.child_max_connections|escape}"/></td>
        </tr>

        <tr> {if $error.connection_life_time != null}
          <th class="error"><label>{$message.descConnection_life_time|escape}</label>
          <br />connection_life_time (integer)</th>
          {else}
          <th><label>{$message.descConnection_life_time|escape}</label>
          <br />connection_life_time (integer)</th>
          {/if}
          <td><input type="text" name="connection_life_time" value="{$params.connection_life_time|escape}"/></td>
        </tr>

        <tr> {if $error.client_idle_limit != null}
          <th class="error"><label>{$message.descClient_idle_limit|escape}</label>
          <br />client_idle_limit (integer)</th>
          {else}
          <th><label>{$message.descClient_idle_limit|escape}</label>
          <br />client_idle_limit (integer)</th>
          {/if}
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

      {if $isAdd == true}
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
      <tr> {if $error.backend_hostname[num] != null}
        <th class="error"><label>{$message.descBackend_hostname|escape}</label>
        <br />backend_hostname{$smarty.section.num.index} (string)</th>
        {else}
        <th><label>{$message.descBackend_hostname|escape}</label>
        <br />backend_hostname{$smarty.section.num.index} (string)</th>
        {/if}
        <td><input type="text" name="backend_hostname[]" value="{$params.backend_hostname[num]|escape}" /></td>
        <td rowspan="5">
        <input type="button" name="delete" value="{$message.strDelete|escape}" onclick="del({$smarty.section.num.index})" /></td>
      </tr>

      <tr> {if $error.backend_port[num] != null}
        <th class="error"><label>{$message.descBackend_port|escape}</label>
        <br />backend_port{$smarty.section.num.index|escape} (integer)</th>
        {else}
        <th><label>{$message.descBackend_port|escape}</label>
        <br />backend_port{$smarty.section.num.index|escape} (integer)</th>
        {/if}
        <td><input type="text" name="backend_port[]" value="{$params.backend_port[num]|escape}" /></td>
      </tr>

      <tr> {if $error.backend_weight[num] != null}
        <th class="error"><label>{$message.descBackend_weight|escape}</label>
        <br />backend_weight{$smarty.section.num.index|escape} (float)</th>
        {else}
        <th><label>{$message.descBackend_weight|escape}</label>
        <br />backend_weight{$smarty.section.num.index|escape} (float)</th>
        {/if}
        <td><input type="text" name="backend_weight[]" value="{$params.backend_weight[num]|escape}" /></td>
      </tr>

      <tr> {if $error.backend_data_directory[num] != null}
        <th class="error"><label>{$message.descBackend_data_directory|escape}</label>
        <br />backend_data_directory{$smarty.section.num.index|escape} (string)</th>
        {else}
        <th><label>{$message.descBackend_data_directory|escape}</label>
        <br />backend_data_directory{$smarty.section.num.index|escape} (string)</th>
        {/if}
        <td><input type="text" name="backend_data_directory[]"
             value="{$params.backend_data_directory[num]|escape}" /></td>
      </tr>

      <tr> {if $error.backend_flag[num] != null}
        <th class="error"><label>{$message.descBackend_flag|escape}</label>
        <br />backend_flag{$smarty.section.num.index|escape} *</th>
        {else}
        <th><label>{$message.descBackend_flag|escape}</label>
        <br />backend_flag{$smarty.section.num.index|escape} *</th>
        {/if}
        <td><select name="backend_flag[]" id="backend_flag[]">
            <option value="ALLOW_TO_FAILOVER"
            {if $params.backend_flag[num] == 'ALLOW_TO_FAILOVER'}selected{/if}>ALLOW_TO_FAILOVER</option>
            <option value="DISALLOW_TO_FAILOVER"
            {if $params.backend_flag[num] == 'DISALLOW_TO_FAILOVER'}selected{/if}>DISALLOW_TO_FAILOVER</option>
            </select></td>
      </tr>
      {/section}

      {if $isAdd == true}
      <tr>
        <th><label>{$message.descBackend_hostname|escape}</label>
        <br />backend_hostname{$smarty.section.num.index} (string)</th>
        <td><input type="text" name="backend_hostname[]" value="" /></td>
        <td rowspan="5"></td>
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

      <tr>
        <th><label>{$message.descBackend_flag|escape}</label>
        <br />backend_flag{$smarty.section.num.index|escape} *</th>
        <td><select name="backend_flag[]" id="backend_flag[]">
            <option value="ALLOW_TO_FAILOVER" selected>ALLOW_TO_FAILOVER</option>
            <option value="DISALLOW_TO_FAILOVER">DISALLOW_TO_FAILOVER</option>
            </select></td>
      </tr>
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

        <tr><th class="category" colspan="2">Where to log</th></tr>

        <tr> {if $error.log_destination != null}
        <th class="error"><label>{$message.descLog_destination|escape}</label>
        <br />master_slave_sub_mode *</th>
        {else}
        <th><label>{$message.descLog_destination|escape}</label><br />log_destination *</th>
        {/if}
        <td><select name="log_destination" id="log_destination">
            <option value="stderr" {if $params.log_destination == 'stderr'}selected{/if}>stderr</option>
            <option value="syslog" {if $params.log_destination == 'syslog'}selected{/if}>syslog</option>
            </select></td>
        </tr>

        {* --------------------------------------------------------------------- *}

        <tr><th class="category" colspan="2">What to log</th></tr>

        <tr> {if $error.print_timestamp != null}
          <th><label>{$message.descPrint_timestamp|escape}</label>
          <br />print_timestamp *</th>
          {else}
          <th><label>{$message.descPrint_timestamp|escape}</label>
          <br />print_timestamp *</th>
          {/if}
          {if $params.print_timestamp == 'on'}
          <td><input type="checkbox" name="print_timestamp"
               id="print_timestamp" value="true" checked="checked" /></td>
          {else}
          <td><input type="checkbox" name="print_timestamp"
               id="print_timestamp" value="false" /></td>
          {/if}
        </tr>

        <tr> {if $error.log_connections != null}
          <th class="error"><label>{$message.descLog_connections|escape}</label>
          <br />log_connections</th>
          {else}
          <th><label>{$message.descLog_connections|escape}</label>
          <br />log_connections</th>
          {/if}
          {if $params.log_connections == 'on'}
          <td><input type="checkbox" name="log_connections"
               id="log_connections" value="true" checked="checked" /></td>
          {else}
          <td><input type="checkbox" name="log_connections"
               id="log_connections" value="false" /></td>
          {/if}
        </tr>

        <tr> {if $error.log_hostname != null}
          <th class="error"><label>{$message.descLog_hostname|escape}</label>
          <br />log_hostname</th>
          {else}
          <th><label>{$message.descLog_hostname|escape}</label>
                    <br />log_hostname</th>
          {/if}
          {if $params.log_hostname == 'on'}
          <td><input type="checkbox" name="log_hostname" id="log_hostname" value="true" checked="checked" /></td>
          {else}
          <td><input type="checkbox" name="log_hostname" id="log_hostname" value="false" /></td>
          {/if}
        </tr>

        <tr> {if $error.log_statement != null}
          <th class="error"><label>{$message.descLog_statement|escape}</label>
                    <br />log_statement</th>
          {else}
          <th><label>{$message.descLog_statement|escape}</label>
          <br />log_statement</th>
          {/if}
          {if $params.log_statement == 'on'}
          <td><input type="checkbox" name="log_statement" id="log_statement" value="true" checked="checked" /></td>
          {else}
          <td><input type="checkbox" name="log_statement" id="log_statement" value="false" /></td>
          {/if}
        </tr>

        <tr> {if $error.log_per_node_statement != null}
          <th class="error"><label>{$message.descLog_per_node_statement|escape}</label>
          <br />log_per_node_statement</th>
          {else}
          <th><label>{$message.descLog_per_node_statement|escape}</label>
          <br />log_per_node_statement</th>
          {/if}
          {if $params.log_per_node_statement == 'on'}
          <td><input type="checkbox" name="log_per_node_statement"
               id="log_per_node_statement" value="true" checked="checked" /></td>
          {else}
          <td><input type="checkbox" name="log_per_node_statement"
               id="log_per_node_statement" value="false" /></td>
          {/if}
        </tr>

        <tr> {if $error.log_standby_delay != null}
          <th class="error"><label>{$message.descLog_standby_delay|escape}</label><br />log_standby_delay</th>
          {else}
          <th><label>{$message.descLog_standby_delay|escape}</label><br />log_standby_delay</th>
          {/if}
          <td><select name="log_standby_delay" id="log_standby_delay">
              <option value="always"
               {if $params.log_standby_delay == 'always'}selected{/if}>always</option>
              <option value="if_over_threshold"
               {if $params.log_standby_delay == 'if_over_threshold'}selected{/if}>if_over_threshold</option>
              <option value="none"
               {if $params.log_standby_delay == 'none'}selected{/if}>none</option>
              </select></td>
        </tr>

        {* --------------------------------------------------------------------- *}

        <tr><th class="category" colspan="2">Syslog specific</th></tr>

        <tr> {if $error.syslog_facility != null}
          <th class="error"><label>{$message.descSyslog_facility|escape}</label>
          <br />syslog_facility (string) *</th>
          {else}
          <th><label>{$message.descSyslog_facility|escape}</label>
          <br />syslog_facility (string) *</th>
          {/if}
          <td><input type="text" name="syslog_facility" value="{$params.syslog_facility|escape}"/></td>
        </tr>

        <tr> {if $error.syslog_ident != null}
          <th class="error"><label>{$message.descSyslog_ident|escape}</label>
          <br />syslog_ident (string) *</th>
          {else}
          <th><label>{$message.descSyslog_ident|escape}</label>
          <br />syslog_ident (string) *</th>
          {/if}
          <td><input type="text" name="syslog_ident" value="{$params.syslog_ident|escape}"/></td>
        </tr>

        {* --------------------------------------------------------------------- *}

        <tr><th class="category" colspan="2">Debug</th></tr>

        <tr> {if $error.debug_level != null}
          <th class="error"><label>{$message.descDebug_level|escape}</label>
          <br />debug_level (integer)</th>
          {else}
          <th><label>{$message.descDebug_level|escape}</label>
          <br />debug_level (integer)</th>
          {/if}
          <td><input type="text" name="debug_level" value="{$params.debug_level|escape}"/></td>
        </tr>

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

        <tr> {if $error.logdir != null}
          <th class="error"><label>{$message.descLogdir|escape}</label>
          <br />logdir (string) *</th>
          {else}
          <th><label>{$message.descLogdir|escape}</label>
          <br />logdir (string) *</th>
          {/if}
          <td><input type="text" name="logdir" value="{$params.logdir|escape}"/></td>
        </tr>

        <tr> {if $error.pid_file_name != null}
          <th class="error"><label>{$message.descPid_file_name|escape}</label>
          <br />pid_file_name (string) *</th>
          {else}
          <th><label>{$message.descPid_file_name|escape}</label>
          <br />pid_file_name (string) *</th>
          {/if}
          <td><input type="text" name="pid_file_name" value="{$params.pid_file_name|escape}"/></td>
        </tr>

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

        <tr> {if $error.connection_cache != null}
          <th class="error"><label>{$message.descConnection_cache|escape}</label>
          <br />connection_cache *</th>
          {else}
          <th><label>{$message.descConnection_cache|escape}</label>
          <br />connection_cache *</th>
          {/if}
          {if $params.connection_cache == 'on'}
          <td><input type="checkbox" name="connection_cache"
              id="connection_cache" value="true" checked="checked" /></td>
          {else}
          <td><input type="checkbox" name="connection_cache"
               id="connection_cache" value="false" /></td>
          {/if}
        </tr>

        <tr> {if $error.reset_query_list != null}
          <th class="error"><label>{$message.descReset_query_list|escape}</label>
          <br />reset_query_list (string)</th>
          {else}
          <th><label>{$message.descReset_query_list|escape}</label>
          <br />reset_query_list (string)</th>
          {/if}
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

        <tr> {if $error.replication_mode != null}
          <th class="error"><label>{$message.descReplication_mode|escape}</label>
          <br />replication_mode *</th>
          {else}
          <th><label>{$message.descReplication_mode|escape}</label>
          <br />replication_mode *</th>
          {/if}
          {if $params.replication_mode == 'on'}
          <td><input type="checkbox" name="replication_mode"
               id="replication_mode" value="true" checked="checked" /></td>
          {else}
          <td><input type="checkbox" name="replication_mode"
               id="replication_mode" value="false" /></td>
          {/if}
        </tr>

        <tr> {if $error.replicate_select != null}
          <th class="error"><label>{$message.descReplicate_select|escape}</label>
          <br />replicate_select</th>
          {else}
          <th><label>{$message.descReplicate_select|escape}</label>
          <br />replicate_select</th>
          {/if}
          {if $params.replicate_select == 'on'}
          <td><input type="checkbox" name="replicate_select"
               id="replicate_select" value="true" checked="checked" /></td>
          {else}
          <td><input type="checkbox" name="replicate_select"
              id="replicate_select" value="false" /></td>
          {/if}
        </tr>

        <tr> {if $error.portinsert_lock!= null}
          <th class="error"><label>{$message.descInsert_lock|escape}</label>
          <br />insert_lock</th>
          {else}
          <th><label>{$message.descInsert_lock|escape}</label>
          <br />insert_lock</th>
          {/if}
          {if $params.insert_lock == 'on'}
          <td><input type="checkbox" name="insert_lock" id="insert_lock" value="true" checked="checked" /></td>
          {else}
          <td><input type="checkbox" name="insert_lock" id="insert_lock" value="false" /></td>
          {/if}
        </tr>

        <tr> {if $error.lobj_lock_table != null}
          <th class="error"><label>{$message.descLobj_lock_table|escape}</label>
          <br />lobj_lock_table</th>
          {else}
          <th><label>{$message.descLobj_lock_table|escape}</label>
          <br />lobj_lock_table</th>
          {/if}
          <td><input type="text" name="lobj_lock_table"
               id="lobj_lock_table" value="{$params.lobj_lock_table|escape}" /></td>
        </tr>

        {* --------------------------------------------------------------------- *}

        <tr><th class="category" colspan="2">Degenerate handling</th></tr>

        <tr> {if $error.replication_stop_on_mismatch != null}
          <th class="error"><label>{$message.descReplication_stop_on_mismatch|escape}</label>
          <br />replication_stop_on_mismatch</th>
          {else}
          <th><label>{$message.descReplication_stop_on_mismatch|escape}</label>
          <br />replication_stop_on_mismatch</th>
          {/if}
          {if $params.replication_stop_on_mismatch == 'on'}
          <td><input type="checkbox" name="replication_stop_on_mismatch"
               id="replication_stop_on_mismatch" value="true" checked="checked" /></td>
          {else}
          <td><input type="checkbox" name="replication_stop_on_mismatch"
              id="replication_stop_on_mismatch" value="false" /></td>
          {/if} </tr>

        <tr> {if $error.replication_stop_on_mismatch != null}
          <th class="error"><label>{$message.descFailover_if_affected_tuples_mismatch|escape}</label>
          <br />failover_if_affected_tuples_mismatch</th>
          {else}
          <th><label>{$message.descFailover_if_affected_tuples_mismatch|escape}</label>
          <br />failover_if_affected_tuples_mismatch</th>
          {/if}
          {if $params.failover_if_affected_tuples_mismatch == 'on'}
          <td><input type="checkbox" name="failover_if_affected_tuples_mismatch"
               id="failover_if_affected_tuples_mismatch" value="true" checked="checked" /></td>
          {else}
          <td><input type="checkbox" name="failover_if_affected_tuples_mismatch"
               id="failover_if_affected_tuples_mismatch" value="false" /></td>
          {/if}
        </tr>

        <tr> {if $error.replication_timeout != null}
          <th class="error"><label>{$message.descReplication_timeout|escape}</label>
          <br />replication_timeout (integer)</th>
          {else}
          <th><label>{$message.descReplication_timeout|escape}</label>
          <br />replication_timeout (integer)</th>
          {/if}
          <td><input type="text" name="replication_timeout" value="{$params.replication_timeout|escape}"/></td>
        </tr>

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

        <tr> {if $error.load_balance_mode != null}
          <th class="error"><label>{$message.descLoad_balance_mode|escape}</label>
          <br />load_balance_mode *</th>
          {else}
          <th><label>{$message.descLoad_balance_mode|escape}</label>
          <br />load_balance_mode *</th>
          {/if}
          {if $params.load_balance_mode == 'on'}
          <td><input type="checkbox" name="load_balance_mode"
               id="load_balance_mode" value="true" checked="checked" /></td>
          {else}
          <td><input type="checkbox" name="load_balance_mode"
               id="load_balance_mode" value="false" /></td>
          {/if}
        </tr>

        <tr> {if $error.ignore_leading_white_space != null}
          <th class="error"><label>{$message.descIgnore_leading_white_space|escape}</label>
          <br />ignore_leading_white_space</th>
          {else}
          <th><label>{$message.descIgnore_leading_white_space|escape}</label>
          <br />ignore_leading_white_space</th>
          {/if}
          {if $params.ignore_leading_white_space == 'on'}
          <td><input type="checkbox" name="ignore_leading_white_space"
               id="ignore_leading_white_space" value="true" checked="checked" /></td>
          {else}
          <td><input type="checkbox" name="ignore_leading_white_space"
               id="ignore_leading_white_space" value="false" /></td>
          {/if}
        </tr>

        <tr> {if $error.white_function_list != null}
          <th class="error"><label>{$message.descWhite_function_list|escape}</label>
          <br />white_function_list (string)</th>
          {else}
          <th><label>{$message.descWhite_function_list|escape}</label>
          <br />white_function_list (string)</th>
          {/if}
          <td><input type="text" name="white_function_list" value="{$params.white_function_list|escape}"/></td>
        </tr>

        <tr> {if $error.black_function_list != null}
          <th class="error"><label>{$message.descBlack_function_list|escape}</label>
          <br />black_function_list (string)</th>
          {else}
          <th><label>{$message.descBlack_function_list|escape}</label>
          <br />black_function_list (string)</th>
          {/if}
          <td><input type="text" name="black_function_list" value="{$params.black_function_list|escape}"/></td>
        </tr>

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

        <tr> {if $error.master_slave_mode != null}
          <th class="error"><label>{$message.descMaster_slave_mode|escape}</label>
          <br />master_slave_mode *</th>
          {else}
          <th><label>{$message.descMaster_slave_mode|escape}</label>
          <br />master_slave_mode *</th>
          {/if}
          {if $params.master_slave_mode == 'on'}
          <td><input type="checkbox" name="master_slave_mode"
               id="master_slave_mode" value="true" checked="checked" /></td>
          {else}
          <td><input type="checkbox" name="master_slave_mode"
               id="master_slave_mode" value="false" /></td>
          {/if}
        </tr>

        <tr> {if $error.master_slave_sub_mode != null}
          <th class="error"><label>{$message.descMaster_slave_sub_mode|escape}</label>
          <br />master_slave_sub_mode *</th>
          {else}
          <th><label>{$message.descMaster_slave_sub_mode|escape}</label>
          <br />master_slave_sub_mode *</th>
          {/if}
          <td><select name="master_slave_sub_mode" id="master_slave_sub_mode">
              <option value="slony"
               {if $params.master_slave_sub_mode == 'slony'}selected{/if}>slony</option>
              <option value="stream"
               {if $params.master_slave_sub_mode == 'stream'}selected{/if}>stream</option>
              </select></td>
        </tr>

        {* --------------------------------------------------------------------- *}

        <tr><th class="category" colspan="2">Streaming</th></tr>

        <tr> {if $error.sr_check_period!= null}
          <th class="error"><label>{$message.descSr_check_period|escape}</label>
          <br />sr_check_period (integer) *</th>
          {else}
          <th><label>{$message.descSr_check_period|escape}</label>
          <br />sr_check_period (integer) *</th>
          {/if}
          <td><input type="text" name="sr_check_period" value="{$params.sr_check_period|escape}"/></td>
        </tr>

        <tr> {if $error.sr_check_user != null}
          <th class="error"><label>{$message.descSr_check_user|escape}</label>
          <br />sr_check_user (string) *</th>
          {else}
          <th><label>{$message.descSr_check_user|escape}</label>
          <br />sr_check_user (string) *</th>
          {/if}
          <td><input type="text" name="sr_check_user" value="{$params.sr_check_user|escape}"/></td>
        </tr>

        <tr> {if $error.sr_check_password != null}
          <th class="error"><label>{$message.descSr_check_password|escape}</label>
          <br />sr_check_password (string) *</th>
          {else}
          <th><label>{$message.descSr_check_password|escape}</label>
          <br />sr_check_password (string) *</th>
          {/if}
          <td><input type="text" name="sr_check_password" value="{$params.sr_check_password|escape}"/></td>
        </tr>

        <tr> {if $error.delay_threshold != null}
          <th class="error"><label>{$message.descDelay_threshold|escape}</label><br />delay_threshold</th>
          {else}
          <th><label>{$message.descDelay_threshold|escape}</label><br />delay_threshold</th>
          {/if}
          <td><input type="text" name="delay_threshold"
               id="delay_threshold" value="{$params.delay_threshold|escape}" /></td>
        </tr>

        {* --------------------------------------------------------------------- *}

        <tr><th class="category" colspan="2">Special commands</th></tr>

        <tr> {if $error.follow_master_command != null}
          <th class="error"><label>{$message.descFollow_master_command|escape}</label>
          <br />follow_master_command (string) *</th>
          {else}
          <th><label>{$message.descFollow_master_command|escape}</label>
          <br />follow_master_command (string) *</th>
          {/if}
          <td><input type="text" name="follow_master_command"
               value="{$params.follow_master_command|escape}"/></td>
        </tr>

      </tbody>
    </table>

    {* --------------------------------------------------------------------- *
     * Parallel Mode                                                        *
     * --------------------------------------------------------------------- *}
    <h3><a name="parallel_mode" id="parallel_mode">Parallel Mode and Query Cache</a></h3>

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

        <tr> {if $error.parallel_mode != null}
          <th class="error"><label>{$message.descParallel_mode|escape}</label>
          <br />parallel_mode *</th>
          {else}
          <th><label>{$message.descParallel_mode|escape}</label>
          <br />parallel_mode *</th>
          {/if}
          {if $params.parallel_mode == 'on'}
          <td><input type="checkbox" name="parallel_mode"
               id="parallel_mode" value="true" checked="checked" /></td>
          {else}
          <td><input type="checkbox" name="parallel_mode"
               id="parallel_mode" value="false" /></td>
          {/if}
        </tr>

        <tr> {if $error.enable_query_cache != null}
          <th class="error"><label>{$message.descEnable_query_cache|escape}</label>
          <br />enable_query_cache *</th>
          {else}
          <th><label>{$message.descEnable_query_cache|escape}</label>
          <br />enable_query_cache *</th>
          {/if}
          {if $params.enable_query_cache == 'on'}
          <td><input type="checkbox" name="enable_query_cache" id="enable_query_cache" checked="checked" /></td>
          {else}
          <td><input type="checkbox" name="enable_query_cache" id="enable_query_cache" /></td>
          {/if}
        </tr>

        <tr> {if $error.pgpool2_hostname != null}
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

        <tr> {if $error.system_db_hostname != null}
          <th class="error"><label>{$message.descSystem_db_hostname|escape}</label>
          <br />system_db_hostname (string) *</th>
          {else}
          <th><label>{$message.descSystem_db_hostname|escape}</label>
          <br />system_db_hostname (string) *</th>
          {/if}
          <td><input type="text" name="system_db_hostname" value="{$params.system_db_hostname|escape}"/></td>
        </tr>

        <tr> {if $error.system_db_port != null}
          <th class="error"><label>{$message.descSystem_db_port|escape}</label>
          <br />system_db_port (integer) *</th>
          {else}
          <th><label>{$message.descSystem_db_port|escape}</label>
          <br />system_db_port (integer) *</th>
          {/if}
          <td><input type="text" name="system_db_port" value="{$params.system_db_port|escape}"/></td>
        </tr>

        <tr> {if $error.system_db_dbname != null}
          <th class="error"><label>{$message.descSystem_db_dbname|escape}</label>
          <br />system_db_dbname (string) *</th>
          {else}
          <th><label>{$message.descSystem_db_dbname|escape}</label>
          <br />system_db_dbname (string) *</th>
          {/if}
          <td><input type="text" name="system_db_dbname" value="{$params.system_db_dbname|escape}"/></td>
        </tr>

        <tr> {if $error.system_db_schema != null}
          <th class="error"><label>{$message.descSystem_db_schema|escape}</label>
          <br />system_db_schema (string) *</th>
          {else}
          <th><label>{$message.descSystem_db_schema|escape}</label>
          <br />system_db_schema (string) *</th>
          {/if}
          <td><input type="text" name="system_db_schema" value="{$params.system_db_schema|escape}"/></td>
        </tr>

        <tr> {if $error.system_db_user != null}
          <th class="error"><label>{$message.descSystem_db_user|escape}</label>
          <br />system_db_user (string) *</th>
          {else}
          <th><label>{$message.descSystem_db_user|escape}</label>
          <br />system_db_user (string) *</th>
          {/if}
          <td><input type="text" name="system_db_user" value="{$params.system_db_user|escape}"/></td>
        </tr>

        <tr> {if $error.system_db_password != null}
          <th class="error"><label>{$message.descSystem_db_password|escape}</label>
          <br />system_db_password (string) *</th>
          {else}
          <th><label>{$message.descSystem_db_password|escape}</label>
          <br />system_db_password (string) *</th>
          {/if}
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
        <tr> {if $error.health_check_timeout != null}
          <th class="error"><label>{$message.descHealth_check_timeout|escape}</label>
          <br />health_check_timeout (integer)</th>
          {else}
          <th><label>{$message.descHealth_check_timeout|escape}</label>
          <br />health_check_timeout (integer)</th>
          {/if}
          <td><input type="text" name="health_check_timeout" value="{$params.health_check_timeout|escape}"/></td>
        </tr>

        <tr> {if $error.health_check_period != null}
          <th class="error"><label>{$message.descHealth_check_period|escape}</label>
          <br />health_check_period (integer)</th>
          {else}
          <th><label>{$message.descHealth_check_period|escape}</label>
          <br />health_check_period (integer)</th>
          {/if}
          <td><input type="text" name="health_check_period" value="{$params.health_check_period|escape}"/></td>
        </tr>

        <tr> {if $error.health_check_user != null}
          <th class="error"><label>{$message.descHealth_check_user|escape}</label>
          <br />health_check_user (string)</th>
          {else}
          <th><label>{$message.descHealth_check_user|escape}</label>
          <br />health_check_user (string)</th>
          {/if}
          <td><input type="text" name="health_check_user" value="{$params.health_check_user|escape}"/></td>
        </tr>
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

        <tr> {if $error.failover_command != null}
          <th class="error"><label>{$message.descFailover_command|escape}</label>
          <br />failover_command (string)</th>
          {else}
          <th><label>{$message.descFailover_command|escape}</label>
          <br />failover_command (string)</th>
          {/if}
          <td><input type="text" name="failover_command" value="{$params.failover_command|escape}"/></td>
        </tr>

        <tr> {if $error.failback_command != null}
          <th class="error"><label>{$message.descFailback_command|escape}</label>
          <br />failback_command (string)</th>
          {else}
          <th><label>{$message.descFailback_command|escape}</label>
          <br />failback_command (string)</th>
          {/if}
          <td><input type="text" name="failback_command" value="{$params.failback_command|escape}"/></td>
        </tr>

        <tr> {if $error.fail_over_on_backend_error != null}
          <th class="error"><label>{$message.descFail_over_on_backend_error|escape}</label>
                    <br />fail_over_on_backend_error</th>
          {else}
          <th><label>{$message.descFail_over_on_backend_error|escape}</label>
                    <br />fail_over_on_backend_error</th>
          {/if}
          {if $params.fail_over_on_backend_error == 'on'}
          <td><input type="checkbox" name="fail_over_on_backend_error"
               id="fail_over_on_backend_error" value="true" checked="checked" /></td>
          {else}
          <td><input type="checkbox" name="fail_over_on_backend_error"
               id="fail_over_on_backend_error" value="false" /></td>
          {/if} </tr>

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
        <tr> {if $error.recovery_user != null}
          <th class="error"><label>{$message.descRecovery_user|escape}</label>
          <br />recovery_user (string)</th>
          {else}
          <th><label>{$message.descRecovery_user|escape}</label>
          <br />recovery_user (string)</th>
          {/if}
          <td><input type="text" name="recovery_user" value="{$params.recovery_user|escape}"/></td>
        </tr>

        <tr> {if $error.recovery_password != null}
          <th class="error"><label>{$message.descRecovery_password|escape}</label>
          <br />recovery_password (string)</th>
          {else}
          <th><label>{$message.descRecovery_password|escape}</label>
          <br />recovery_password (string)</th>
          {/if}
          <td><input type="password" name="recovery_password" value="{$params.recovery_password|escape}"/></td>
        </tr>

        <tr> {if $error.recovery_1st_stage_command != null}
          <th class="error"><label>{$message.descRecovery_1st_stage_command|escape}</label>
          <br />recovery_1st_stage_command (string)</th>
          {else}
          <th><label>{$message.descRecovery_1st_stage_command|escape}</label>
          <br />recovery_1st_stage_command (string)</th>
          {/if}
          <td><input type="text" name="recovery_1st_stage_command"
               value="{$params.recovery_1st_stage_command|escape}"/></td>
        </tr>

        <tr> {if $error.recovery_2nd_stage_command != null}
          <th class="error"><label>{$message.descRecovery_2nd_stage_command|escape}</label>
          <br />recovery_2nd_stage_command (string)</th>
          {else}
          <th><label>{$message.descRecovery_2nd_stage_command|escape}</label>
          <br />recovery_2nd_stage_command (string)</th>
          {/if}
          <td><input type="text" name="recovery_2nd_stage_command"
               value="{$params.recovery_2nd_stage_command|escape}"/></td>
        </tr>

        <tr> {if $error.recovery_timeout != null}
          <th class="error"><label>{$message.descRecovery_timeout|escape}</label>
          <br />recovery_timeout (integer)</th>
          {else}
          <th><label>{$message.descRecovery_timeout|escape}</label>
          <br />recovery_timeout (integer)</th>
          {/if}
          <td><input type="text" name="recovery_timeout" value="{$params.recovery_timeout|escape}"/></td>
        </tr>

        <tr> {if $error.client_idle_limit_in_recovery != null}
          <th class="error"><label>{$message.descClient_idle_limit_in_recovery|escape}</label>
          <br />client_idle_limit_in_recovery (integer)</th>
          {else}
          <th><label>{$message.descClient_idle_limit_in_recovery|escape}</label>
          <br />client_idle_limit_in_recovery (integer)</th>
          {/if}
          <td><input type="text" name="client_idle_limit_in_recovery"
               value="{$params.client_idle_limit_in_recovery|escape}"/></td>
        </tr>
      </tbody>
    </table>

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

        <tr> {if $error.relcache_expire != null}
          <th class="error"><label>{$message.descRelcache_expire|escape}</label>
          <br />relcache_expire (integer)</th>
          {else}
          <th><label>{$message.descRelcache_expire|escape}</label>
          <br />relcache_expire (integer)</th>
          {/if}
          <td><input type="text" name="relcache_expire" value="{$params.relcache_expire|escape}"/></td>
        </tr>

      </tbody>
    </table>

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
