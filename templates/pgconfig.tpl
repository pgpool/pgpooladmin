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
      <li><a href="#backends">Backends</a></li>
      <li><a href="#pcp">PCP</a></li>
      <li><a href="#logging">Logging</a></li>
      <li><a href="#replication">Replication</a></li>
      <li><a href="#health-check">Health Check</a></li>
      <li><a href="#recovery">Online Recovery</a></li>
      <li><a href="#system-database">System Database</a></li>
      <li><a href="#others">Others</a></li>
    </ul>
  </div>
  <form name="pgconfig" method="post" action="pgconfig.php">
    <input type="hidden" name="action" value="" />
    <input type="hidden" name="num" value="" />
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
        <tr> {if $error.child_life_time != null}
          <th class="error"><label>{$message.descChild_life_time|escape}</label>
          <br />child_life_time (integer)</th>
          {else}
          <th><label>{$message.descChild_life_time|escape}</label>
          <br />child_life_time (integer)</th>
          {/if}
          <td><input type="text" name="child_life_time" value="{$params.child_life_time|escape}"/></td>
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
	<tr> {if $error.child_max_connections != null}
          <th class="error"><label>{$message.descChild_max_connections|escape}</label>
          <br />child_max_connections (integer)</th>
          {else}
          <th><label>{$message.descChild_max_connections|escape}</label>
          <br />child_max_connections (integer)</th>
          {/if}
          <td><input type="text" name="child_max_connections" value="{$params.child_max_connections|escape}"/></td>
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
	<tr> {if $error.authentication_timeout != null}
          <th class="error"><label>{$message.descAuthentication_timeout|escape}</label>
          <br />authentication_timeout (integer)</th>
          {else}
          <th><label>{$message.descAuthentication_timeout|escape}</label>
          <br />authentication_timeout (integer)</th>
          {/if}
          <td><input type="text" name="authentication_timeout" value="{$params.authentication_timeout|escape}"/></td>
        </tr>
        <tr> {if $error.connection_cache != null}
          <th class="error"><label>{$message.descConnection_cache|escape}</label>
					<br />connection_cache *</th>
          {else}
          <th><label>{$message.descConnection_cache|escape}</label>
					<br />connection_cache *</th>
          {/if}
          {if $params.connection_cache == 'true'}
          <td><input type="checkbox" name="connection_cache" id="connection_cache" value="true" checked="checked" /></td>
          {else}
          <td><input type="checkbox" name="connection_cache" id="connection_cache" value="false" /></td>
          {/if} </tr>
        <tr> {if $error.pgpool2_hostname != null}
          <th><label>{$message.descPgpool2_hostname|escape}</label>
          <br />pgpool2_hostname (string) *</th>
          {else}
          <th><label>{$message.descPgpool2_hostname|escape}</label>
          <br />pgpool2_hostname (string) *</th>
          {/if}
          <td><input type="text" name="pgpool2_hostname" value="{$params.pgpool2_hostname|escape}"/></td>
        </tr>
      </tbody>
    </table>
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
           <td colspan="3"><input type="button" name="cancel" value="{$message.strCancel|escape}" onclick="cancelNode()" /></td>
        </tr>
      </tfoot>
      {else}
      <tfoot>
        <tr>
          <td colspan="3"><input type="button" name="add" value="{$message.strAdd|escape}" onclick="addNode()" /></td>
        </tr>
      </tfoot>
      {/if}
      <tbody>
        <tr> {if $error.backend_socket_dir != null}
          <th class="error"><label>{$message.descBackend_socket_dir|escape}</label>
          <br />backend_socket_dir (string)</th>
          {else}
          <th><label>{$message.descBackend_socket_dir|escape}</label>
          <br />backend_socket_dir (string) *</th>
          {/if}
          <td><input type="text" name="backend_socket_dir" value="{$params.backend_socket_dir|escape}"/></td>
          <td></td>
        </tr>
      {section name=num loop=$params.backend_hostname}
      <tr> {if $error.backend_hostname[num] != null}
        <th class="error"><label>{$message.descBackend_hostname|escape}</label>
        <br />backend_hostname{$smarty.section.num.index} (string)</th>
        {else}
        <th><label>{$message.descBackend_hostname|escape}</label>
        <br />backend_hostname{$smarty.section.num.index} (string)</th>
        {/if}
        <td><input type="text" name="backend_hostname[]" value="{$params.backend_hostname[num]|escape}" /></td>
        <td rowspan="4"><input type="button" name="delete" value="{$message.strDelete|escape}" onclick="del({$smarty.section.num.index})" /></td>
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
        <td><input type="text" name="backend_data_directory[]" value="{$params.backend_data_directory[num]|escape}" /></td>
      </tr>
      {/section}
      {if $isAdd == true}
      <tr>
        <th><label>new backend_hostname</label>
          (string)</th>
        <td><input type="text" name="backend_hostname[]" value="" /></td>
        <td rowspan="4"></td>
      </tr>
      <tr><th><label>new backend_port</label>
          (integer)</th>
        <td><input type="text" name="backend_port[]" value="" /></td>
      </tr>
      <tr>
        <th><label>new backend_weight</label>
          (float)</th>
        <td><input type="text" name="backend_weight[]" value="" /></td>
      </tr>
      <tr>
        <th><label>new backend_data_directory</label>
          (string)</th>
        <td><input type="text" name="backend_data_directory[]" value="" /></td>
      </tr>
      {/if}
      </tbody>      
    </table>
    <h3><a name="pcp" id="pcp">PCP (pgpool Control Port)</a></h3>
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
        <tr> {if $error.pcp_timeout != null}
          <th class="error"><label>{$message.descPcp_timeout|escape}</label>
          <br />pcp_timeout (integer)</th>
          {else}
          <th><label>{$message.descPcp_timeout|escape}</label>
          <br />pcp_timeout (integer)</th>
          {/if}
          <td><input type="text" name="pcp_timeout" value="{$params.pcp_timeout|escape}"/></td>
        </tr>
      </tbody>
    </table>
    <h3><a name="logging" id="logging">Logging</a></h3>
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
        <tr> {if $error.print_timestamp != null}
          <th><label>{$message.descPrint_timestamp|escape}</label>
					<br />print_timestamp *</th>
          {else}
          <th><label>{$message.descPrint_timestamp|escape}</label>
					<br />print_timestamp *</th>
          {/if}
          {if $params.print_timestamp == 'true'}
          <td><input type="checkbox" name="print_timestamp" id="print_timestamp" value="true" checked="checked" /></td>
          {else}
          <td><input type="checkbox" name="print_timestamp" id="print_timestamp" value="false" /></td>
          {/if}
		</tr>
        <tr> {if $error.log_statement != null}
          <th class="error"><label>{$message.descLog_statement|escape}</label>
					<br />log_statement</th>
          {else}
          <th><label>{$message.descLog_statement|escape}</label>
					<br />log_statement</th>
          {/if}
          {if $params.log_statement == 'true'}
          <td><input type="checkbox" name="log_statement" id="log_statement" value="true" checked="checked" /></td>
          {else}
          <td><input type="checkbox" name="log_statement" id="log_statement" value="false" /></td>
          {/if}
		</tr>
        <tr> {if $error.log_connections != null}
          <th class="error"><label>{$message.descLog_connections|escape}</label>
					<br />log_connections</th>
          {else}
          <th><label>{$message.descLog_connections|escape}</label>
					<br />log_connections</th>
          {/if}
          {if $params.log_connections == 'true'}
          <td><input type="checkbox" name="log_connections" id="log_connections" value="true" checked="checked" /></td>
          {else}
          <td><input type="checkbox" name="log_connections" id="log_connections" value="false" /></td>
          {/if}
		</tr>
        <tr> {if $error.log_hostname != null}
          <th class="error"><label>{$message.descLog_hostname|escape}</label>
					<br />log_hostname</th>
          {else}
          <th><label>{$message.descLog_hostname|escape}</label>
					<br />log_hostname</th>
          {/if}
          {if $params.log_hostname == 'true'}
          <td><input type="checkbox" name="log_hostname" id="log_hostname" value="true" checked="checked" /></td>
          {else}
          <td><input type="checkbox" name="log_hostname" id="log_hostname" value="false" /></td>
          {/if}
		</tr>
      </tbody>
    </table>
    <h3><a name="replication" id="replication">Replication</a></h3>
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
          {if $params.replication_mode == 'true'}
          <td><input type="checkbox" name="replication_mode" id="replication_mode" value="true" checked="checked" /></td>
          {else}
          <td><input type="checkbox" name="replication_mode" id="replication_mode" value="false" /></td>
          {/if} </tr>
        <tr> {if $error.replication_timeout != null}
          <th class="error"><label>{$message.descReplication_timeout|escape}</label>
          <br />replication_timeout (integer)</th>
          {else}
          <th><label>{$message.descReplication_timeout|escape}</label>
          <br />replication_timeout (integer)</th>
          {/if}
          <td><input type="text" name="replication_timeout" value="{$params.replication_timeout|escape}"/></td>
        </tr>
        <tr> {if $error.replication_stop_on_mismatch != null}
          <th class="error"><label>{$message.descReplication_stop_on_mismatch|escape}</label>
					<br />replication_stop_on_mismatch</th>
          {else}
          <th><label>{$message.descReplication_stop_on_mismatch|escape}</label>
					<br />replication_stop_on_mismatch</th>
          {/if}
          {if $params.replication_stop_on_mismatch == 'true'}
          <td><input type="checkbox" name="replication_stop_on_mismatch" id="replication_stop_on_mismatch" value="true" checked="checked" /></td>
          {else}
          <td><input type="checkbox" name="replication_stop_on_mismatch" id="replication_stop_on_mismatch" value="false" /></td>
          {/if} </tr>
        <tr> {if $error.replicate_select != null}
          <th class="error"><label>{$message.descReplicate_select|escape}</label>
					<br />replicate_select</th>
          {else}
          <th><label>{$message.descReplicate_select|escape}</label>
					<br />replicate_select</th>
          {/if}
          {if $params.replicate_select == 'true'}
          <td><input type="checkbox" name="replicate_select" id="replicate_select" value="true" checked="checked" /></td>
          {else}
          <td><input type="checkbox" name="replicate_select" id="replicate_select" value="false" /></td>
          {/if} </tr>
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
          <td><input type="text" name="recovery_1st_stage_command" value="{$params.recovery_1st_stage_command|escape}"/></td>
        </tr>
        <tr> {if $error.recovery_2nd_stage_command != null}
          <th class="error"><label>{$message.descRecovery_2nd_stage_command|escape}</label>
          <br />recovery_2nd_stage_command (string)</th>
          {else}
          <th><label>{$message.descRecovery_2nd_stage_command|escape}</label>
          <br />recovery_2nd_stage_command (string)</th>
          {/if}
          <td><input type="text" name="recovery_2nd_stage_command" value="{$params.recovery_2nd_stage_command|escape}"/></td>
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
      </tbody>
    </table>
    <h3><a name="system-database" id="system-database">System Database</a></h3>
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
        <tr> {if $error.load_balance_mode != null}
          <th class="error"><label>{$message.descLoad_balance_mode|escape}</label>
					<br />load_balance_mode *</th>
          {else}
          <th><label>{$message.descLoad_balance_mode|escape}</label>
					<br />load_balance_mode *</th>
          {/if}
          {if $params.load_balance_mode == 'true'}
          <td><input type="checkbox" name="load_balance_mode" id="load_balance_mode" value="true" checked="checked" /></td>
          {else}
          <td><input type="checkbox" name="load_balance_mode" id="load_balance_mode" value="false" /></td>
          {/if} </tr>
        <tr> {if $error.master_slave_mode != null}
          <th class="error"><label>{$message.descMaster_slave_mode|escape}</label>
					<br />master_slave_mode *</th>
          {else}
          <th><label>{$message.descMaster_slave_mode|escape}</label>
					<br />master_slave_mode *</th>
          {/if}
          {if $params.master_slave_mode == 'true'}
          <td><input type="checkbox" name="master_slave_mode" id="master_slave_mode" value="true" checked="checked" /></td>
          {else}
          <td><input type="checkbox" name="master_slave_mode" id="master_slave_mode" value="false" /></td>
          {/if} </tr>
        <tr> {if $error.portinsert_lock!= null}
          <th class="error"><label>{$message.descInsert_lock|escape}</label>
					<br />insert_lock</th>
          {else}
          <th><label>{$message.descInsert_lock|escape}</label>
					<br />insert_lock</th>
          {/if}
          {if $params.insert_lock == 'true'}
          <td><input type="checkbox" name="insert_lock" id="insert_lock" value="true" checked="checked" /></td>
          {else}
          <td><input type="checkbox" name="insert_lock" id="insert_lock" value="false" /></td>
          {/if} </tr>
        <tr> {if $error.ignore_leading_white_space != null}
          <th class="error"><label>{$message.descIgnore_leading_white_space|escape}</label>
					<br />ignore_leading_white_space</th>
          {else}
          <th><label>{$message.descIgnore_leading_white_space|escape}</label>
					<br />ignore_leading_white_space</th>
          {/if}
          {if $params.ignore_leading_white_space == 'true'}
          <td><input type="checkbox" name="ignore_leading_white_space" id="ignore_leading_white_space" value="true" checked="checked" /></td>
          {else}
          <td><input type="checkbox" name="ignore_leading_white_space" id="ignore_leading_white_space" value="false" /></td>
          {/if} </tr>
        <tr> {if $error.parallel_mode != null}
          <th class="error"><label>{$message.descParallel_mode|escape}</label>
					<br />parallel_mode *</th>
          {else}
          <th><label>{$message.descParallel_mode|escape}</label>
					<br />parallel_mode *</th>
          {/if}
          {if $params.parallel_mode == 'true'}
          <td><input type="checkbox" name="parallel_mode" id="parallel_mode" value="true" checked="checked" /></td>
          {else}
          <td><input type="checkbox" name="parallel_mode" id="parallel_mode" value="false" /></td>
          {/if} </tr>
        <tr> {if $error.enable_query_cache != null}
          <th class="error"><label>{$message.descEnable_query_cache|escape}</label>
					<br />enable_query_cache *</th>
          {else}
          <th><label>{$message.descEnable_query_cache|escape}</label>
					<br />enable_query_cache *</th>
          {/if}
          {if $params.enable_query_cache == 'true'}
          <td><input type="checkbox" name="enable_query_cache" id="enable_query_cache" checked="checked" /></td>
          {else}
          <td><input type="checkbox" name="enable_query_cache" id="enable_query_cache" /></td>
          {/if} </tr>
        <tr> {if $error.enable_pool_hba != null}
          <th class="error"><label>{$message.descEnable_pool_hba|escape}</label>
					<br />enable_pool_hba</th>
          {else}
          <th><label>{$message.descEnable_pool_hba|escape}</label>
					<br />enable_pool_hba</th>
          {/if}
          {if $params.enable_pool_hba == 'true'}
          <td><input type="checkbox" name="enable_pool_hba" id="enable_pool_hba" checked="checked" /></td>
          {else}
          <td><input type="checkbox" name="enable_pool_hba" id="enable_pool_hba" /></td>
          {/if} </tr>
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
      </tbody>
    </table>
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
