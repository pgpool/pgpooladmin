<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>{$message.strPgConfSetting|escape}</title>
<link href="screen.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/pgconfig.js"></script>
</head>

<body>
<div id="header">
  <h1><img src="images/logo.gif" alt="pgpoolAdmin" /></h1>
</div>

<div id="menu">
{include file="menu.tpl"}
{include file="elements/pgconfig_submenu.tpl"}
</div>

<div id="content">

<div id="help"><a href="help.php?help={$help|escape}">
<img src="images/question.gif" alt="help"/>{$message.strHelp|escape}</a>
</div>

<h2>{$message.strPgConfSetting|escape}</h2>

  {* --------------------------------------------------------------------- *
   * Succeeed / Failed                                                     *
   * --------------------------------------------------------------------- *}
  {if isset($status)}
    {if $status == 'success'}
    <table>
      <tr>
      <td class="pgconfig_msg">
      <p>{$message.msgUpdateComplete|escape}</p>
      <p><img src="images/warning.png"> {$message.msgUpdateCompleteInfo|escape}</p>
      </td>
      </tr>
    </table>
    {elseif $status == 'fail'}
    <table>
      <tr>
      <td class="pgconfig_msg"><p><img src="images/error.png"> {$message.msgUpdateFailed|escape}</p></td>
      </tr>
    </table>
    {/if}
  {/if}

  <form id="form_pgconfig" name="pgconfig" method="post" action="pgconfig.php" class="pgconfig">
    <input type="hidden" id="pgconfig_action" name="action" value="" />
    <input type="hidden" id="pgconfig_num" name="num" value="" />

    {* ===================================================================== *}
    <h3 id="connections">Connections</h3>
    {* ===================================================================== *}

    <table>
      {custom_table_pgconfig}
      <tbody id="tb_connection">
        {* --------------------------------------------------------------------- *}
        <tr><th class="category" colspan="2">pgpool Connection Settings</th></tr>
        {* --------------------------------------------------------------------- *}

        {custom_tr_pgconfig param='listen_addresses'}
        {custom_tr_pgconfig param='port'}
        {custom_tr_pgconfig param='socket_dir'}
        {if paramExists('listen_backlog_multiplier')}
            {custom_tr_pgconfig param='listen_backlog_multiplier'}
        {/if}
        {if paramExists('serialize_accept')}
           {custom_tr_pgconfig param='serialize_accept'}
        {/if}
        {if paramExists('backend_socket_dir')}
            {custom_tr_pgconfig param='backend_socket_dir'}
        {/if}
      </tbody>

      <tbody id="tb_connection_pcp">
        {* --------------------------------------------------------------------- *}
        <tr><th class="category" colspan="2">pgpool Communication Manager Connection Settings</th></tr>
        {* --------------------------------------------------------------------- *}

        {custom_tr_pgconfig param='pcp_listen_addresses'}
        {custom_tr_pgconfig param='pcp_port'}
        {custom_tr_pgconfig param='pcp_socket_dir'}
      </tbody>

      <tbody id="tb_connection_auth">
        {* --------------------------------------------------------------------- *}
        <tr><th class="category" colspan="2">Authentication</th></tr>
        {* --------------------------------------------------------------------- *}

        {custom_tr_pgconfig param='enable_pool_hba'}
      </tbody>
      <tbody id="tb_enable_pool_hba_on">
        {if paramExists('pool_passwd')}
            {custom_tr_pgconfig param='pool_passwd'}
        {/if}
        {custom_tr_pgconfig param='authentication_timeout'}
      </tbody>

        {if paramExists('ssl')}
          <tbody id="tb_connection_ssl">
            {* --------------------------------------------------------------------- *}
            <tr><th class="category" colspan="2">SSL Connections</th></tr>
            {* --------------------------------------------------------------------- *}

            {custom_tr_pgconfig param='ssl'}
          </tbody>

          <tbody id="tb_ssl_on">
            {custom_tr_pgconfig param='ssl_key'}
            {custom_tr_pgconfig param='ssl_cert'}
            {custom_tr_pgconfig param='ssl_ca_cert'}
            {custom_tr_pgconfig param='ssl_ca_cert_dir'}
          </tbody>
        {/if}
    </table>

    {* ===================================================================== *}
    <h3 id="pools">Pools</h3>
    {* ===================================================================== *}

    <table>
      {custom_table_pgconfig}

      <tbody id="tb_pools_size">
        {* --------------------------------------------------------------------- *}
        <tr><th class="category" colspan="2">Pool size</th></tr>
        {* --------------------------------------------------------------------- *}

        {custom_tr_pgconfig param='num_init_children'}
        {custom_tr_pgconfig param='max_pool'}
      </tbody>

      <tbody id="tb_pools_lifetime">
        {* --------------------------------------------------------------------- *}
        <tr><th class="category" colspan="2">Life time</th></tr>
        {* --------------------------------------------------------------------- *}

        {custom_tr_pgconfig param='child_life_time'}
        {custom_tr_pgconfig param='child_max_connections'}
        {custom_tr_pgconfig param='connection_life_time'}
        {custom_tr_pgconfig param='client_idle_limit'}
      </tbody>
    </table>

    {* ===================================================================== *}
    <h3 id="backends">Backends</h3>
    {* ===================================================================== *}

    <table id="t_backends">
        {custom_table_pgconfig}

        {* --------------------------------------------------------------------- *}
        <tr><th class="category" colspan="2">Backend node
        <input id="add_backends_node" type="button" name="add" value="{$message.strAdd|escape}" />
        </th></tr>
        {* --------------------------------------------------------------------- *}

        {foreach from=$params.backend_hostname key=node_num item=v}
            <tbody id="tb_backends_node_{$node_num}">
              <tr id="tr_ba_node_num_{$node_num}" name="tr_ba_node_num"><th colspan="2">
                  <span class="param_group">Backend node {$node_num}</span>
                  <input id="delete_backends_node_{$node_num}" type="button" name="delete" value="{$message.strDelete|escape}" />
              </th></tr>
              {custom_tr_pgconfig param='backend_hostname' num=$node_num}
              {custom_tr_pgconfig param='backend_port' num=$node_num}
              {custom_tr_pgconfig param='backend_weight' num=$node_num}
              {custom_tr_pgconfig param='backend_data_directory' num=$node_num}
              {if paramExists('backend_flag')}
                  {custom_tr_pgconfig param='backend_flag' num=$node_num}
              {/if}
            </tbody>
        {/foreach}

    </table>

    {* ===================================================================== *}
    <h3 id="logs">Logs</h3>
    {* ===================================================================== *}

    <table>
      {custom_table_pgconfig}

        {if paramExists('log_destination')}
          <tbody id="tb_logs_where">
            {* --------------------------------------------------------------------- *}
            <tr><th class="category" colspan="2">Where to log</th></tr>
            {* --------------------------------------------------------------------- *}

            {custom_tr_pgconfig param='log_destination'}
          </tbody>

          <tbody id="tb_logs_what">
            {* --------------------------------------------------------------------- *}
            <tr><th class="category" colspan="2">What to log</th></tr>
            {* --------------------------------------------------------------------- *}

            {if paramExists('log_line_prefix')}
                {custom_tr_pgconfig param='log_line_prefix'}
            {/if}
            {if paramExists('print_timestamp')}
                {custom_tr_pgconfig param='print_timestamp'}
            {/if}
            {custom_tr_pgconfig param='log_connections'}
            {custom_tr_pgconfig param='log_hostname'}
            {custom_tr_pgconfig param='log_statement'}
            {if paramExists('log_per_node_statement')}
                {custom_tr_pgconfig param='log_per_node_statement'}
            {/if}
            {if paramExists('log_standby_delay')}
                {custom_tr_pgconfig param='log_standby_delay'}
            {/if}
          </tbody>

          <tbody id="tb_logs_debug">
            {* --------------------------------------------------------------------- *}
            <tr><th class="category" colspan="2">Debug</th></tr>
            {* --------------------------------------------------------------------- *}

            {if paramExists('debug_level')}
                {custom_tr_pgconfig param='debug_level'}
            {/if}
            {if paramExists('log_error_verbosity')}
                {custom_tr_pgconfig param='log_error_verbosity'}
            {/if}
            {if paramExists('client_min_messages')}
                {custom_tr_pgconfig param='client_min_messages'}
            {/if}
            {if paramExists('log_min_messages')}
                {custom_tr_pgconfig param='log_min_messages'}
            {/if}
          </tbody>
        {/if}

        {if paramExists('syslog_facility')}
          <tbody id="tb_logs_log_destination_syslog">
            {* --------------------------------------------------------------------- *}
            <tr><th class="category" colspan="2">Syslog specific</th></tr>
            {* --------------------------------------------------------------------- *}

            {custom_tr_pgconfig param='syslog_facility'}
            {custom_tr_pgconfig param='syslog_ident'}
          </tbody>
        {/if}
    </table>

    {* ===================================================================== *}
    <h3 id="file_locations">File Locations</h3>
    {* ===================================================================== *}

    <table>
      {custom_table_pgconfig}

      <tbody id="tb_file_locations">
        {custom_tr_pgconfig param='logdir'}
        {if paramExists('pid_file_name')}
            {custom_tr_pgconfig param='pid_file_name'}
        {/if}
      </tbody>
    </table>

    {* ===================================================================== *}
    <h3 id="connection_pooling">Connection Pooling</h3>
    {* ===================================================================== *}

    <table>
      {custom_table_pgconfig}

      <tbody id="tb_connection_pooling">
        {custom_tr_pgconfig param='connection_cache'}
        {custom_tr_pgconfig param='reset_query_list'}
      </tbody>
    </table>

    {* ===================================================================== *}
    <h3 id="replication_mode">Replication Mode</h3>
    {* ===================================================================== *}

    <table>
      {custom_table_pgconfig}

      <tbody id="tb_replication_mode">
        {custom_tr_pgconfig param='replication_mode'}
      </tbody>

      <tbody id="tb_replication_mode_on">
        {custom_tr_pgconfig param='replicate_select'}
        {custom_tr_pgconfig param='insert_lock'}
        {if paramExists('lobj_lock_table')}
            {custom_tr_pgconfig param='lobj_lock_table'}
        {/if}
      </tbody>

      <tbody id="tb_replication_mode_degnerate">
        {* --------------------------------------------------------------------- *}
        <tr><th class="category" colspan="2">Degenerate handling</th></tr>
        {* --------------------------------------------------------------------- *}

        {custom_tr_pgconfig param='replication_stop_on_mismatch'}
        {if paramExists('failover_if_affected_tuples_mismatch')}
            {custom_tr_pgconfig param='failover_if_affected_tuples_mismatch'}
        {/if}
        {if paramExists('replication_timeout')}
            {custom_tr_pgconfig param='replication_timeout'}
        {/if}
      </tbody>
    </table>

    {* ===================================================================== *}
    <h3 id="load_balancing_mode">Load Balancing Mode</h3>
    {* ===================================================================== *}

    <table>
      {custom_table_pgconfig}

      <tbody id="tb_load_balance_mode">
        {custom_tr_pgconfig param='load_balance_mode'}
      </tbody>

      <tbody id="tb_load_balance_mode_on">
        {custom_tr_pgconfig param='ignore_leading_white_space'}
        {if paramExists('white_function_list')}
            {custom_tr_pgconfig param='white_function_list'}
        {/if}
        {if paramExists('black_function_list')}
            {custom_tr_pgconfig param='black_function_list'}
        {/if}
        {if paramExists('database_redirect_preference_list')}
            {custom_tr_pgconfig param='database_redirect_preference_list'}
        {/if}
        {if paramExists('app_name_redirect_preference_list')}
            {custom_tr_pgconfig param='app_name_redirect_preference_list'}
        {/if}
        {if paramExists('allow_sql_comments')}
            {custom_tr_pgconfig param='allow_sql_comments'}
        {/if}
      </tbody>
    </table>

    {* ===================================================================== *}
    <h3 id="master_slave_mode">Master/Slave Mode</h3>
    {* ===================================================================== *}

    <table>
      {custom_table_pgconfig}

      <tbody id="tb_master_slave_mode">
        {custom_tr_pgconfig param='master_slave_mode'}
      </tbody>

      {if paramExists('master_slave_sub_mode')}
        <tbody id="tb_master_slave_mode_on_submode">
          {custom_tr_pgconfig param='master_slave_sub_mode'}
        </tbody>

        {if paramExists('follow_master_command')}
          <tbody id="tb_master_slave_mode_on_special_command">
            {* --------------------------------------------------------------------- *}
            <tr><th class="category" colspan="2">Special commands</th></tr>
            {* --------------------------------------------------------------------- *}

            {custom_tr_pgconfig param='follow_master_command'}
          </tbody>
        {/if}
      {/if}

      <tbody id="tb_master_slave_sub_mode_stream">
        {if paramExists('sr_check_period')}
            {* --------------------------------------------------------------------- *}
            <tr><th class="category" colspan="2">Streaming</th></tr>
            {* --------------------------------------------------------------------- *}

            {custom_tr_pgconfig param='sr_check_period'}
            {custom_tr_pgconfig param='sr_check_user'}
            {custom_tr_pgconfig param='sr_check_password'}
            {if paramExists('sr_check_database')}
                {custom_tr_pgconfig param='sr_check_database'}
            {/if}
        {/if}

        {if paramExists('delay_threshold')}
            {custom_tr_pgconfig param='delay_threshold'}
        {/if}
      </tbody>
    </table>

    {if paramExists('parallel_mode')}
        {* ===================================================================== *}
        <h3 id="parallel_mode">
        {if hasMemqcache()}
            Parallel Mode
        {else}
            Parallel Mode and Query Cache
        {/if}</a></h3>
        {* ===================================================================== *}

        <table>
          {custom_table_pgconfig}

          <tbody id="tb_parallel_mode">
            {custom_tr_pgconfig param='parallel_mode'}
          </tbody>

          <tbody id="tb_parallel_mode_on_host">
            {custom_tr_pgconfig param='pgpool2_hostname'}
            {if hasMemqcache() == false}
                {custom_tr_pgconfig param='enable_query_cache'}
            {/if}
          </tbody>

          <tbody id="tb_parallel_mode_on_system_db">
            {* --------------------------------------------------------------------- *}
            <tr><th class="category" colspan="2">System DB info</th></tr>
            {* --------------------------------------------------------------------- *}

            {custom_tr_pgconfig param='system_db_hostname'}
            {custom_tr_pgconfig param='system_db_port'}
            {custom_tr_pgconfig param='system_db_dbname'}
            {custom_tr_pgconfig param='system_db_schema'}
            {custom_tr_pgconfig param='system_db_user'}
            {custom_tr_pgconfig param='system_db_password'}
          </tbody>
        </table>
    {/if}

    {* ===================================================================== *}
    <h3 id="health-check">Health Check GLOBAL PARAMETERS</h3>
    {* ===================================================================== *}

    <table id="t_healthcheck">
      {custom_table_pgconfig}

      <tbody id="tb_global_healthcheck">

        {custom_tr_pgconfig param='health_check_period'}
        {custom_tr_pgconfig param='health_check_timeout'}
        {custom_tr_pgconfig param='health_check_user'}
        {if paramExists('health_check_password')}
            {custom_tr_pgconfig param='health_check_password'}
        {/if}
        {if paramExists('health_check_database')}
            {custom_tr_pgconfig param='health_check_database'}
        {/if}
        {if paramExists('health_check_max_retries')}
            {custom_tr_pgconfig param='health_check_max_retries'}
        {/if}
        {if paramExists('health_check_retry_delay')}
            {custom_tr_pgconfig param='health_check_retry_delay'}
        {/if}
        {if paramExists('connect_timeout')}
            {custom_tr_pgconfig param='connect_timeout'}
        {/if}

      </tbody>

      <tr><th class="category" colspan="2">Per Node Parameters</th></tr>

      {foreach from=$params.backend_hostname key=node_num item=v}
        <tbody id="tb_per_node_healthcheck_{$node_num}">
          <tr id="tr_hc_node_num_{$node_num}"><th colspan="2">
            <span class="param_group">Backend node {$node_num}</span>
            {if definedHealthCheckParam($params, 'health_check_period', $node_num)}
              <input id="delete_per_node_health_check_{$node_num}" type="button" name="delete" value="{$message.strDelete|escape}" />
            {/if}
            {if ! definedHealthCheckParam($params, 'health_check_period', $node_num)}
              <input id="add_per_node_health_check_{$node_num}" type="button" name="add" value="{$message.strAdd|escape}" />
            {/if}
          </tr>

          {custom_tr_pgconfig param='health_check_period' num=$node_num}
          {custom_tr_pgconfig param='health_check_timeout' num=$node_num}
          {custom_tr_pgconfig param='health_check_user' num=$node_num}
          {if paramExists('health_check_password')}
            {custom_tr_pgconfig param='health_check_password' num=$node_num}
          {/if}
          {if paramExists('health_check_database')}
            {custom_tr_pgconfig param='health_check_database' num=$node_num}
          {/if}
          {if paramExists('health_check_max_retries')}
            {custom_tr_pgconfig param='health_check_max_retries' num=$node_num}
          {/if}
          {if paramExists('health_check_retry_delay')}
            {custom_tr_pgconfig param='health_check_retry_delay' num=$node_num}
          {/if}
          {if paramExists('connect_timeout')}
            {custom_tr_pgconfig param='connect_timeout' num=$node_num}
          {/if}

        </tbody>
      {/foreach}
    </table>

    {* ===================================================================== *}
    <h3 id="failover">Failover and Failback</h3>
    {* ===================================================================== *}

    <table>
      {custom_table_pgconfig}

      <tbody id="tb_failover">
        {custom_tr_pgconfig param='failover_command'}
        {custom_tr_pgconfig param='failback_command'}
        {if paramExists('fail_over_on_backend_error')}
            {custom_tr_pgconfig param='fail_over_on_backend_error'}
        {/if}
        {if paramExists('search_primary_node_timeout')}
            {custom_tr_pgconfig param='search_primary_node_timeout'}
        {/if}
      </tbody>
    </table>

    {* ===================================================================== *}
    <h3 id="recovery">Online Recovery</h3>
    {* ===================================================================== *}

    <table>
      {custom_table_pgconfig}

      <tbody id="tb_recovery">
        {custom_tr_pgconfig param='recovery_user'}
        {custom_tr_pgconfig param='recovery_password'}
        {custom_tr_pgconfig param='recovery_1st_stage_command'}
        {custom_tr_pgconfig param='recovery_2nd_stage_command'}
        {custom_tr_pgconfig param='recovery_timeout'}
        {if paramExists('client_idle_limit_in_recovery')}
            {custom_tr_pgconfig param='client_idle_limit_in_recovery'}
        {/if}
      </tbody>
    </table>

    {if hasWatchdog()}
        {* ===================================================================== *}
        <h3 id="watchdog">Watchdog</h3>
        {* ===================================================================== *}

        <table>
          {custom_table_pgconfig}

          <tbody id="tb_watchdog">
            {custom_tr_pgconfig param='use_watchdog'}
          </tbody>

          <tbody id="tb_watchdog_use_watchdog_on_connection">
            {* --------------------------------------------------------------------- *}
            <tr><th class="category" colspan="4">Connection to up stream servers</th></tr>
            {* --------------------------------------------------------------------- *}

            {custom_tr_pgconfig param='trusted_servers'}
            {custom_tr_pgconfig param='ping_path'}
          </tbody>

          <tbody id="tb_watchdog_use_watchdog_on_communication">
            {* --------------------------------------------------------------------- *}
            <tr><th class="category" colspan="4">Watchdog communication Settings</th></tr>
            {* --------------------------------------------------------------------- *}

            {custom_tr_pgconfig param='wd_hostname'}
            {custom_tr_pgconfig param='wd_port'}
            {if paramExists('wd_priority')}
                {custom_tr_pgconfig param='wd_priority'}
            {/if}
            {custom_tr_pgconfig param='wd_authkey'}
            {if paramExists('wd_ipc_socket_dir')}
                {custom_tr_pgconfig param='wd_ipc_socket_dir'}
            {/if}
          </tbody>

          <tbody id="tb_watchdog_use_watchdog_on_vip">
            {* --------------------------------------------------------------------- *}
            <tr><th class="category" colspan="4">Virtual IP control Setting</th></tr>
            {* --------------------------------------------------------------------- *}

            {custom_tr_pgconfig param='delegate_IP'}
            {if paramExists('ifconfig_path')}
                {custom_tr_pgconfig param='ifconfig_path'}
            {/if}
            {if paramExists('if_cmd_path')}
                {custom_tr_pgconfig param='if_cmd_path'}
            {/if}
            {custom_tr_pgconfig param='if_up_cmd'}
            {custom_tr_pgconfig param='if_down_cmd'}
            {custom_tr_pgconfig param='arping_path'}
            {custom_tr_pgconfig param='arping_cmd'}
          </tbody>

          <tbody id="tb_watchdog_use_watchdog_on_escalation">

            {* --------------------------------------------------------------------- *}
            <tr><th class="category" colspan="4">Behavior on escalation Setting</th></tr>
            {* --------------------------------------------------------------------- *}

            {custom_tr_pgconfig param='clear_memqcache_on_escalation'}
            {custom_tr_pgconfig param='wd_escalation_command'}
            {if paramExists('wd_de_escalation_command')}
                {custom_tr_pgconfig param='wd_de_escalation_command'}
            {/if}
            {if paramExists('wd_monitoring_interfaces_list')}
                {custom_tr_pgconfig param='wd_monitoring_interfaces_list'}
            {/if}
          </tbody>

          <tbody id="tb_watchdog_use_watchdog_on_failover">

            {* --------------------------------------------------------------------- *}
            <tr><th class="category" colspan="4">Quorum failover behavior Setting</th></tr>
            {* --------------------------------------------------------------------- *}

            {custom_tr_pgconfig param='failover_when_quorum_exists'}
            {custom_tr_pgconfig param='failover_require_consensus'}
            {custom_tr_pgconfig param='allow_multiple_failover_requests_from_node'}
          </tbody>

          <tbody id="tb_watchdog_use_watchdog_on_lifecheck_common">
            {* --------------------------------------------------------------------- *}
            <tr><th class="category" colspan="4">Lifecheck Setting (common)</th></tr>
            {* --------------------------------------------------------------------- *}

            {if paramExists('wd_lifecheck_method')}
                {custom_tr_pgconfig param='wd_lifecheck_method'}
            {/if}
            {custom_tr_pgconfig param='wd_interval'}
          </tbody>

            {if paramExists('wd_heartbeat_port')}
              <tbody id="tb_watchdog_wd_lifecheck_method_heartbeat">
                {* --------------------------------------------------------------------- *}
                <tr><th class="category" colspan="4">Lifecheck Setting (heartbeat mode)</th></tr>
                {* --------------------------------------------------------------------- *}

                {custom_tr_pgconfig param='wd_heartbeat_port'}
                {custom_tr_pgconfig param='wd_heartbeat_keepalive'}
                {custom_tr_pgconfig param='wd_heartbeat_deadtime'}
              </tbody>

              <tbody id="tb_watchdog_wd_lifecheck_method_heartbeat_destinations">
                {* --------------------------------------------------------------------- *}
                <tr><th class="category" colspan="4">Heartbeat destinations
                    <input type="button" name="add" value="{$message.strAdd|escape}"
                           onclick="sendForm('add_heartbeat_destination')" />
                </th></tr>
                {* --------------------------------------------------------------------- *}

                {if paramExists('heartbeat_destination')}
                    {foreach from=$params.heartbeat_destination key=dest_num item=v}
                        <tr><th colspan="4"><span class="param_group">
                            Heartbeat destination {$dest_num}</span>
                        </th></tr>
                        {custom_tr_pgconfig param='heartbeat_destination' num=$dest_num}
                        {custom_tr_pgconfig param='heartbeat_destination_port' num=$dest_num}
                        {custom_tr_pgconfig param='heartbeat_device' num=$dest_num}
                    {/foreach}

                    {if isset($isAddHeartbeatDestination) && $isAddHeartbeatDestination == true}
                        <tr><th colspan="4"><span class="param_group">
                            Heartbeat destination {$dest_num+1}</span>
                            <input type="button" name="delete" value="{$message.strDelete|escape}"
                                   onclick="sendForm('delete_heartbeat_destination', {$dest_num+1})" />
                        </th></tr>
                        {custom_tr_pgconfig param='heartbeat_destination' num=$dest_num+1}
                        {custom_tr_pgconfig param='heartbeat_destination_port' num=$dest_num+1}
                        {custom_tr_pgconfig param='heartbeat_device' num=$dest_num+1}
                    {/if}
                {/if}
              </tbody>
            {/if}

          <tbody id="tb_watchdog_wd_lifecheck_method_query">
            {* --------------------------------------------------------------------- *}
            <tr><th class="category" colspan="4">Lifecheck Setting (query mode)</th></tr>
            {* --------------------------------------------------------------------- *}

            {custom_tr_pgconfig param='wd_life_point'}
            {custom_tr_pgconfig param='wd_lifecheck_query'}
            {if paramExists('wd_lifecheck_dbname')}
                {custom_tr_pgconfig param='wd_lifecheck_dbname'}
                {custom_tr_pgconfig param='wd_lifecheck_user'}
                {custom_tr_pgconfig param='wd_lifecheck_password'}
            {/if}
          </tbody>

          <tbody id="tb_watchdog_use_watchdog_on_other">
            {* --------------------------------------------------------------------- *}
            <tr><th class="category" colspan="4">Other pgpool Connection Settings
            <input type="button" name="add" value="{$message.strAdd|escape}"
                   onclick="sendForm('add_wd')" />
            </th></tr>
            {* --------------------------------------------------------------------- *}

              {foreach from=$params.other_pgpool_hostname key=host_num item=v}
                  <tr>
                  <th colspan="2"><span class="param_group">other pgpool {$host_num}</span></th>
                  </tr>
                  {custom_tr_pgconfig param='other_pgpool_hostname' num=$host_num}
                  {custom_tr_pgconfig param='other_pgpool_port' num=$host_num}
                  {custom_tr_pgconfig param='other_wd_port' num=$host_num}

              {/foreach}

              {if isset($isAddWd) && $isAddWd == true}
                  <tr>
                  <th colspan="2"><span class="param_group">other pgpool {$host_num+1}</span></th>
                  </tr>
                  {custom_tr_pgconfig param='other_pgpool_hostname' num=$host_num+1}
                  {custom_tr_pgconfig param='other_pgpool_port' num=$host_num+1}
                  {custom_tr_pgconfig param='other_wd_port' num=$host_num+1}
              {/if}
          </tbody>
        </table>
    {/if}

    {if hasMemqcache()}
    {* ===================================================================== *}
    <h3 id="memqcache">In Memory Query Cache</h3>
    {* ===================================================================== *}

    <table>
      {custom_table_pgconfig}

      <tbody id="tb_memqcache">
        {custom_tr_pgconfig param='memory_cache_enabled'}
      </tbody>

      <tbody id="tb_tb_memqcache_memory_cache_enabled_on">
        {custom_tr_pgconfig param='memqcache_method'}

        {* --------------------------------------------------------------------- *}
        <tr><th class="category" colspan="2">Common</th></tr>
        {* --------------------------------------------------------------------- *}

        {custom_tr_pgconfig param='memqcache_expire'}
        {custom_tr_pgconfig param='memqcache_auto_cache_invalidation'}
        {custom_tr_pgconfig param='memqcache_maxcache'}
        {custom_tr_pgconfig param='memqcache_oiddir'}
        {custom_tr_pgconfig param='white_memqcache_table_list'}
        {custom_tr_pgconfig param='black_memqcache_table_list'}
     </tbody>

      <tbody id="tb_memqcache_memqcache_method_memcached">
        {* --------------------------------------------------------------------- *}
        <tr><th class="category" colspan="2">Memcached specific</th></tr>
        {* --------------------------------------------------------------------- *}

        {custom_tr_pgconfig param='memqcache_memcached_host'}
        {custom_tr_pgconfig param='memqcache_memcached_port'}
     </tbody>

      <tbody id="tb_memqcache_memqcache_method_shmem">
        {* --------------------------------------------------------------------- *}
        <tr><th class="category" colspan="2">Shared memory specific</th></tr>
        {* --------------------------------------------------------------------- *}

        {custom_tr_pgconfig param='memqcache_total_size'}
        {custom_tr_pgconfig param='memqcache_max_num_cache'}
        {custom_tr_pgconfig param='memqcache_cache_block_size'}
     </tbody>
    </table>
    {/if}

    {if paramExists('relcache_expire')}
        {* ===================================================================== *}
        <h3 id="others">Others</h3>
        {* ===================================================================== *}

        <table>
          {custom_table_pgconfig}

          <tbody id="tb_other">
            {custom_tr_pgconfig param='relcache_expire'}
            {if paramExists('relcache_size')}
                {custom_tr_pgconfig param='relcache_size'}
            {/if}
            {if paramExists('check_temp_table')}
                {custom_tr_pgconfig param='check_temp_table'}
            {/if}
            {if paramExists('check_unlogged_table')}
                {custom_tr_pgconfig param='check_unlogged_table'}
            {/if}
          </tbody>
        </table>
    {/if}

    {* --------------------------------------------------------------------- *
     * Form End                                                              *
     * --------------------------------------------------------------------- *}
    <hr style="margin: 30px auto">
    <p align="center">
      <input type="button" name="btnSubmit" value="  {$message.strUpdate|escape}  " onclick="sendForm('update')"/>
      <input type="button" name="btnReset" value="  {$message.strReset|escape}  " onclick="test('reset')"/>
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
