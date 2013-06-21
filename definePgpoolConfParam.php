<?php

/* vim: set expandtab tabstop=4 shiftwidth=4 softtabstop=4: */

/**
 * Definition of pgpool variable
 *
 * PHP versions 4 and 5
 *
 * LICENSE: Permission to use, copy, modify, and distribute this software and
 * its documentation for any purpose and without fee is hereby
 * granted, provided that the above copyright notice appear in all
 * copies and that both that copyright notice and this permission
 * notice appear in supporting documentation, and that the name of the
 * author not be used in advertising or publicity pertaining to
 * distribution of the software without specific, written prior
 * permission. The author makes no representations about the
 * suitability of this software for any purpose.  It is provided "as
 * is" without express or implied warranty.
 *
 * @author     Ryuma Ando <ando@ecomas.co.jp>
 * @copyright  2003-2013 PgPool Global Development Group
 * @version    CVS: $Id$
 */

$pgpoolConfigParam = array();
$pgpoolConfigBackendParam = array();
$pgpoolConfigWdOtherParam = array();
$pgpoolConfigHbDestinationParam = array();

define('NUM_MAX', 65535);

// regex kinds
$strreg     = '^[0-9a-zA-Z_\-]+$';
$dirreg     = '^\/[0-9a-zA-Z\._\/\-]+$';
$hostreg    = '^[0-9a-zA-Z\._\-]*$';
$sslreg     = '^(|\/[0-9a-zA-Z_\/\.\-]*)$';
$commandreg = '^[0-9a-zA-Z_\/\.\-]*$';
$addressreg = '^([0-9a-zA-Z\._\-]+|[\*]{1})$';
$listreg    = '^[0-9a-zA-Z_,]*$';
$queryreg   = '^[0-9a-zA-Z; ]+$';
$userreg    = "^[0-9a-zA-Z_\.\-]+$";
$anyelse    = '.*';

function selectreg($lists)
{
    return '^['. implode('|', $lists). ']+$';
}

#------------------------------------------------------------------------------
# CONNECTIONS
#------------------------------------------------------------------------------

# - pgpool Connection Settings -

$key = 'listen_addresses';
$pgpoolConfigParam[$key]['type'] = 'C';
$pgpoolConfigParam[$key]['default'] = 'localhost';
$pgpoolConfigParam[$key]['regexp'] = $addressreg;

$key = 'port';
$pgpoolConfigParam[$key]['type'] = 'N';
$pgpoolConfigParam[$key]['default'] = 9999;
$pgpoolConfigParam[$key]['max'] = NUM_MAX;
$pgpoolConfigParam[$key]['min'] = 1024;

$key = 'socket_dir';
$pgpoolConfigParam[$key]['type'] = 'C';
$pgpoolConfigParam[$key]['default'] = '/tmp';
$pgpoolConfigParam[$key]['regexp'] = $dirreg;

# - pgpool Communication Manager Connection Settings -

$key = 'pcp_port';
$pgpoolConfigParam[$key]['type'] = 'N';
$pgpoolConfigParam[$key]['default'] = 9898;
$pgpoolConfigParam[$key]['min'] = 1024;
$pgpoolConfigParam[$key]['max'] = NUM_MAX;

$key = 'pcp_socket_dir';
$pgpoolConfigParam[$key]['type'] = 'C';
$pgpoolConfigParam[$key]['default'] = '/tmp';
$pgpoolConfigParam[$key]['regexp'] = $dirreg;

# - Backend Connection Settings -

$key = 'backend_hostname';
$pgpoolConfigBackendParam[$key]['type'] = 'C';
$pgpoolConfigBackendParam[$key]['default'] = '';
$pgpoolConfigBackendParam[$key]['regexp'] = $hostreg;

$key = 'backend_port';
$pgpoolConfigBackendParam[$key]['type'] = 'N';
$pgpoolConfigBackendParam[$key]['default'] = 5432;
$pgpoolConfigBackendParam[$key]['min'] = 1024;
$pgpoolConfigBackendParam[$key]['max'] = NUM_MAX;

$key = 'backend_weight';
$pgpoolConfigBackendParam[$key]['type'] = 'F';
$pgpoolConfigBackendParam[$key]['default'] = 1;
$pgpoolConfigBackendParam[$key]['min'] = 0.0;
$pgpoolConfigBackendParam[$key]['max'] = 100.0;

$key = 'backend_data_directory';
$pgpoolConfigBackendParam[$key]['type'] = 'C';
$pgpoolConfigBackendParam[$key]['default'] = '';
$pgpoolConfigBackendParam[$key]['regexp'] = $anyelse;

$key = 'backend_flag';
$pgpoolConfigBackendParam[$key]['type'] = 'C';
$pgpoolConfigBackendParam[$key]['default'] = 'ALLOW_TO_FAILOVER';
$pgpoolConfigBackendParam[$key]['regexp'] = selectreg(array('ALLOW_TO_FAILOVER', 'DISALLOW_TO_FAILOVER'));

# - Authentication -

$key = 'enable_pool_hba';
$pgpoolConfigParam[$key]['type'] = 'B';
$pgpoolConfigParam[$key]['default'] = 'off';

$key = 'pool_passwd';
$pgpoolConfigParam[$key]['type'] = 'C';
$pgpoolConfigParam[$key]['default'] = 'pool_passwd';
$pgpoolConfigParam[$key]['regexp'] = $anyelse;

$key = 'authentication_timeout';
$pgpoolConfigParam[$key]['type'] = 'N';
$pgpoolConfigParam[$key]['default'] = 60;
$pgpoolConfigParam[$key]['min'] = 0;
$pgpoolConfigParam[$key]['max'] = 10000;

# - SSL Connections -

$key = 'ssl';
$pgpoolConfigParam[$key]['type'] = 'B';
$pgpoolConfigParam[$key]['default'] = 'off';

$key = 'ssl_key';
$pgpoolConfigParam[$key]['type'] = 'C';
$pgpoolConfigParam[$key]['default'] = '';
$pgpoolConfigParam[$key]['regexp'] = $sslreg;

$key = 'ssl_cert';
$pgpoolConfigParam[$key]['type'] = 'C';
$pgpoolConfigParam[$key]['default'] = '';
$pgpoolConfigParam[$key]['regexp'] = $sslreg;

$key = 'ssl_ca_cert';
$pgpoolConfigParam[$key]['type'] = 'C';
$pgpoolConfigParam[$key]['default'] = '';
$pgpoolConfigParam[$key]['regexp'] = $sslreg;

$key = 'ssl_ca_cert_dir';
$pgpoolConfigParam[$key]['type'] = 'C';
$pgpoolConfigParam[$key]['default'] = '';
$pgpoolConfigParam[$key]['regexp'] = $sslreg;

#------------------------------------------------------------------------------
# POOLS
#------------------------------------------------------------------------------

# - Pool size -

$key = 'num_init_children';
$pgpoolConfigParam[$key]['type'] = 'N';
$pgpoolConfigParam[$key]['default'] = '32';
$pgpoolConfigParam[$key]['min'] = 1;
$pgpoolConfigParam[$key]['max'] = NUM_MAX;

$key = 'max_pool';
$pgpoolConfigParam[$key]['type'] = 'N';
$pgpoolConfigParam[$key]['default'] = 4;
$pgpoolConfigParam[$key]['min'] = 1;
$pgpoolConfigParam[$key]['max'] = NUM_MAX;

# - Life time -

$key = 'child_life_time';
$pgpoolConfigParam[$key]['type'] = 'N';
$pgpoolConfigParam[$key]['default'] = 300;
$pgpoolConfigParam[$key]['min'] = 0;
$pgpoolConfigParam[$key]['max'] = NUM_MAX;

$key = 'child_max_connections';
$pgpoolConfigParam[$key]['type'] = 'N';
$pgpoolConfigParam[$key]['default'] = 0;
$pgpoolConfigParam[$key]['min'] = 0;
$pgpoolConfigParam[$key]['max'] = NUM_MAX;

$key = 'connection_life_time';
$pgpoolConfigParam[$key]['type'] = 'N';
$pgpoolConfigParam[$key]['default'] = 0;
$pgpoolConfigParam[$key]['min'] = 0;
$pgpoolConfigParam[$key]['max'] = NUM_MAX;

$key = 'client_idle_limit';
$pgpoolConfigParam[$key]['type'] = 'N';
$pgpoolConfigParam[$key]['default'] = 0;
$pgpoolConfigParam[$key]['min'] = 0;
$pgpoolConfigParam[$key]['max'] = NUM_MAX;

#------------------------------------------------------------------------------
# LOGS
#------------------------------------------------------------------------------

# - Where to log -

$key = 'log_destination';
$pgpoolConfigParam[$key]['type'] = 'C';
$pgpoolConfigParam[$key]['default'] = 'stderr';
$pgpoolConfigParam[$key]['regexp'] = selectreg(array('stderr', 'syslog'));

# - What to log -

$key = 'print_timestamp';
$pgpoolConfigParam[$key]['type'] = 'B';
$pgpoolConfigParam[$key]['default'] = 'on';

$key = 'log_connections';
$pgpoolConfigParam[$key]['type'] = 'B';
$pgpoolConfigParam[$key]['default'] = 'off';

$key = 'log_hostname';
$pgpoolConfigParam[$key]['type'] = 'B';
$pgpoolConfigParam[$key]['default'] = 'off';

$key = 'log_statement';
$pgpoolConfigParam[$key]['type'] = 'B';
$pgpoolConfigParam[$key]['default'] = 'off';

$key = 'log_per_node_statement';
$pgpoolConfigParam[$key]['type'] = 'B';
$pgpoolConfigParam[$key]['default'] = 'off';

$key = 'log_standby_delay';
$pgpoolConfigParam[$key]['type'] = 'C';
$pgpoolConfigParam[$key]['default'] = 'none';
$pgpoolConfigParam[$key]['regexp'] = selectreg(array('always', 'if_over_threshold', 'none'));

# - Syslog specific -

$key = 'syslog_facility';
$pgpoolConfigParam[$key]['type'] = 'C';
$pgpoolConfigParam[$key]['default'] = 'LOCAL0';
$pgpoolConfigParam[$key]['regexp'] = $strreg;

$key = 'syslog_ident';
$pgpoolConfigParam[$key]['type'] = 'C';
$pgpoolConfigParam[$key]['default'] = 'pgpool';
$pgpoolConfigParam[$key]['regexp'] = $strreg;

# - Debug -

$key = 'debug_level';
$pgpoolConfigParam[$key]['type'] = 'N';
$pgpoolConfigParam[$key]['default'] = '0';
$pgpoolConfigParam[$key]['min'] = 0;
$pgpoolConfigParam[$key]['max'] = NUM_MAX;

#------------------------------------------------------------------------------
# FILE LOCATIONS
#------------------------------------------------------------------------------

$key = 'pid_file_name';
$pgpoolConfigParam[$key]['type'] = 'C';
$pgpoolConfigParam[$key]['default'] = '/var/run/pgpool/pgpool.pid';
$pgpoolConfigParam[$key]['regexp'] = $dirreg;

$key = 'logdir';
$pgpoolConfigParam[$key]['type'] = 'C';
$pgpoolConfigParam[$key]['default'] = '/tmp';
$pgpoolConfigParam[$key]['regexp'] = $dirreg;

#------------------------------------------------------------------------------
# CONNECTION POOLING
#------------------------------------------------------------------------------

$key = 'connection_cache';
$pgpoolConfigParam[$key]['type'] = 'B';
$pgpoolConfigParam[$key]['default'] =true;

$key = 'reset_query_list';
$pgpoolConfigParam[$key]['type'] = 'C';
$pgpoolConfigParam[$key]['default'] = 'ABORT; DISCARD ALL';
$pgpoolConfigParam[$key]['regexp'] = $queryreg;

#------------------------------------------------------------------------------
# REPLICATION MODE
#------------------------------------------------------------------------------

$key = 'replication_mode';
$pgpoolConfigParam[$key]['type'] = 'B';
$pgpoolConfigParam[$key]['default'] = 'off';

$key = 'replicate_select';
$pgpoolConfigParam[$key]['type'] = 'B';
$pgpoolConfigParam[$key]['default'] = 'off';

$key = 'insert_lock';
$pgpoolConfigParam[$key]['type'] = 'B';
$pgpoolConfigParam[$key]['default'] = 'off';

$key = 'lobj_lock_table';
$pgpoolConfigParam[$key]['type'] = 'C';
$pgpoolConfigParam[$key]['default'] = '';
$pgpoolConfigParam[$key]['regexp'] = $anyelse;

# - Degenerate handling -

$key = 'replication_stop_on_mismatch';
$pgpoolConfigParam[$key]['type'] = 'B';
$pgpoolConfigParam[$key]['default'] = 'off';

$key = 'failover_if_affected_tuples_mismatch';
$pgpoolConfigParam[$key]['type'] = 'B';
$pgpoolConfigParam[$key]['default'] = 'off';

#------------------------------------------------------------------------------
# LOAD BALANCING MODE
#------------------------------------------------------------------------------

$key = 'load_balance_mode';
$pgpoolConfigParam[$key]['type'] = 'B';
$pgpoolConfigParam[$key]['default'] = 'off';

$key = 'ignore_leading_white_space';
$pgpoolConfigParam[$key]['type'] = 'B';
$pgpoolConfigParam[$key]['default'] = true;

$key = 'white_function_list';
$pgpoolConfigParam[$key]['type'] = 'C';
$pgpoolConfigParam[$key]['default'] = '';
$pgpoolConfigParam[$key]['regexp'] = $anyelse;

$key = 'black_function_list';
$pgpoolConfigParam[$key]['type'] = 'C';
$pgpoolConfigParam[$key]['default'] = '';
$pgpoolConfigParam[$key]['regexp'] = $anyelse;

#------------------------------------------------------------------------------
# MASTER/SLAVE MODE
#------------------------------------------------------------------------------

$key = 'master_slave_mode';
$pgpoolConfigParam[$key]['type'] = 'B';
$pgpoolConfigParam[$key]['default'] = 'off';

$key = 'master_slave_sub_mode';
$pgpoolConfigParam[$key]['type'] = 'C';
$pgpoolConfigParam[$key]['default'] = 'slony';
$pgpoolConfigParam[$key]['regexp'] = selectreg(array('slony', 'stream'));

# - Streaming -

$key = 'sr_check_period';
$pgpoolConfigParam[$key]['type'] = 'N';
$pgpoolConfigParam[$key]['default'] = 0;
$pgpoolConfigParam[$key]['min'] = 0;
$pgpoolConfigParam[$key]['max'] = NUM_MAX;

$key = 'sr_check_user';
$pgpoolConfigParam[$key]['type'] = 'C';
$pgpoolConfigParam[$key]['default'] = '';
$pgpoolConfigParam[$key]['regexp'] = $listreg;

$key = 'sr_check_password';
$pgpoolConfigParam[$key]['type'] = 'C';
$pgpoolConfigParam[$key]['default'] = '';
$pgpoolConfigParam[$key]['regexp'] = $listreg;

$key = 'delay_threshold';
$pgpoolConfigParam[$key]['type'] = 'N';
$pgpoolConfigParam[$key]['default'] = 0;
$pgpoolConfigParam[$key]['min'] = 0;
$pgpoolConfigParam[$key]['max'] = NUM_MAX;

# - Special commands -
$key = 'follow_master_command';
$pgpoolConfigParam[$key]['type'] = 'C';
$pgpoolConfigParam[$key]['default'] = '';
$pgpoolConfigParam[$key]['regexp'] = $anyelse;

#------------------------------------------------------------------------------
# PARALLEL MODE AND QUERY CACHE
#------------------------------------------------------------------------------

$key = 'parallel_mode';
$pgpoolConfigParam[$key]['type'] = 'B';
$pgpoolConfigParam[$key]['default'] = 'off';

$key = 'enable_query_cache';
$pgpoolConfigParam[$key]['type'] = 'B';
$pgpoolConfigParam[$key]['default'] = 'off';

$key = 'pgpool2_hostname';
$pgpoolConfigParam[$key]['type'] = 'C';
$pgpoolConfigParam[$key]['default'] = 'localhost';
$pgpoolConfigParam[$key]['regexp'] = $hostreg;

# - System DB info -

$key = 'system_db_hostname';
$pgpoolConfigParam[$key]['type'] = 'C';
$pgpoolConfigParam[$key]['default'] = 'system_db_hostname';
$pgpoolConfigParam[$key]['regexp'] = $hostreg;

$key = 'system_db_port';
$pgpoolConfigParam[$key]['type'] = 'N';
$pgpoolConfigParam[$key]['default'] = 5432;
$pgpoolConfigParam[$key]['min'] = 1024;
$pgpoolConfigParam[$key]['max'] = NUM_MAX;

$key = 'system_db_dbname';
$pgpoolConfigParam[$key]['type'] = 'C';
$pgpoolConfigParam[$key]['default'] = 'pgpool';
$pgpoolConfigParam[$key]['regexp'] = $strreg;

$key = 'system_db_schema';
$pgpoolConfigParam[$key]['type'] = 'C';
$pgpoolConfigParam[$key]['default'] = 'pgpool_catalog';
$pgpoolConfigParam[$key]['regexp'] = $strreg;

$key = 'system_db_user';
$pgpoolConfigParam[$key]['type'] = 'C';
$pgpoolConfigParam[$key]['default'] = 'pgpool';
$pgpoolConfigParam[$key]['regexp'] = $userreg;

$key = 'system_db_password';
$pgpoolConfigParam[$key]['type'] = 'C';
$pgpoolConfigParam[$key]['default'] = '';
$pgpoolConfigParam[$key]['regexp'] = $anyelse;

#------------------------------------------------------------------------------
# HEALTH CHECK
#------------------------------------------------------------------------------

$key = 'health_check_period';
$pgpoolConfigParam[$key]['type'] = 'N';
$pgpoolConfigParam[$key]['default'] =0;
$pgpoolConfigParam[$key]['min'] = 0;
$pgpoolConfigParam[$key]['max'] = NUM_MAX;

$key = 'health_check_timeout';
$pgpoolConfigParam[$key]['type'] = 'N';
$pgpoolConfigParam[$key]['default'] =20;
$pgpoolConfigParam[$key]['min'] = 0;
$pgpoolConfigParam[$key]['max'] = NUM_MAX;

$key = 'health_check_user';
$pgpoolConfigParam[$key]['type'] = 'C';
$pgpoolConfigParam[$key]['default'] = 'nodoby';
$pgpoolConfigParam[$key]['regexp'] = $userreg;

$key = 'health_check_password';
$pgpoolConfigParam[$key]['type'] = 'C';
$pgpoolConfigParam[$key]['default'] = '';
$pgpoolConfigParam[$key]['regexp'] = $anyelse;

$key = 'health_check_max_retries';
$pgpoolConfigParam[$key]['type'] = 'N';
$pgpoolConfigParam[$key]['default'] = 0;
$pgpoolConfigParam[$key]['min'] = 0;
$pgpoolConfigParam[$key]['max'] = NUM_MAX;

$key = 'health_check_retry_delay';
$pgpoolConfigParam[$key]['type'] = 'N';
$pgpoolConfigParam[$key]['default'] = 1;
$pgpoolConfigParam[$key]['min'] = 0;
$pgpoolConfigParam[$key]['max'] = NUM_MAX;

#------------------------------------------------------------------------------
# FAILOVER AND FAILBACK
#-----------------------------------------------------------------------------

$key = 'failover_command';
$pgpoolConfigParam[$key]['type'] = 'C';
$pgpoolConfigParam[$key]['default'] = '';
$pgpoolConfigParam[$key]['regexp'] = $anyelse;

$key = 'failback_command';
$pgpoolConfigParam[$key]['type'] = 'C';
$pgpoolConfigParam[$key]['default'] = '';
$pgpoolConfigParam[$key]['regexp'] = $anyelse;

$key = 'fail_over_on_backend_error';
$pgpoolConfigParam[$key]['type'] = 'B';
$pgpoolConfigParam[$key]['default'] = 'on';

#------------------------------------------------------------------------------
# ONLINE RECOVERY
#------------------------------------------------------------------------------

$key = 'recovery_user';
$pgpoolConfigParam[$key]['type'] = 'C';
$pgpoolConfigParam[$key]['default'] = 'nodoby';
$pgpoolConfigParam[$key]['regexp'] = $anyelse;

$key = 'recovery_password';
$pgpoolConfigParam[$key]['type'] = 'C';
$pgpoolConfigParam[$key]['default'] = '';
$pgpoolConfigParam[$key]['regexp'] = $anyelse;

$key = 'recovery_1st_stage_command';
$pgpoolConfigParam[$key]['type'] = 'C';
$pgpoolConfigParam[$key]['default'] = '';
$pgpoolConfigParam[$key]['regexp'] = $commandreg;

$key = 'recovery_2nd_stage_command';
$pgpoolConfigParam[$key]['type'] = 'C';
$pgpoolConfigParam[$key]['default'] = '';
$pgpoolConfigParam[$key]['regexp'] = $commandreg;

$key = 'recovery_timeout';
$pgpoolConfigParam[$key]['type'] = 'N';
$pgpoolConfigParam[$key]['default'] = 90;
$pgpoolConfigParam[$key]['min'] = 0;
$pgpoolConfigParam[$key]['max'] = NUM_MAX;

$key = 'client_idle_limit_in_recovery';
$pgpoolConfigParam[$key]['type'] = 'N';
$pgpoolConfigParam[$key]['default'] = 0;
$pgpoolConfigParam[$key]['min'] = (3.0 <= _PGPOOL2_VERSION) ? -1 : 0;
$pgpoolConfigParam[$key]['max'] = NUM_MAX;

#------------------------------------------------------------------------------
# WATCHDOG
#------------------------------------------------------------------------------

# Enabling

$key = 'use_watchdog';
$pgpoolConfigParam[$key]['type'] = 'B';
$pgpoolConfigParam[$key]['default'] = 'off';

# Watchdog communication

$key = 'wd_hostname';
$pgpoolConfigParam[$key]['type'] = 'C';
$pgpoolConfigParam[$key]['default'] = '';
$pgpoolConfigParam[$key]['regexp'] = $hostreg;
$pgpoolConfigParam[$key]['null_ok'] = TRUE;

$key = 'wd_port';
$pgpoolConfigParam[$key]['type'] = 'N';
$pgpoolConfigParam[$key]['default'] = 9000;
$pgpoolConfigParam[$key]['max'] = NUM_MAX;
$pgpoolConfigParam[$key]['min'] = 1024;

$key = 'wd_authkey';
$pgpoolConfigParam[$key]['type'] = 'C';
$pgpoolConfigParam[$key]['default'] = '';
$pgpoolConfigParam[$key]['regexp'] = $anyelse;
$pgpoolConfigParam[$key]['null_ok'] = TRUE;

# Connection to up stream servers

$key = 'trusted_servers';
$pgpoolConfigParam[$key]['type'] = 'C';
$pgpoolConfigParam[$key]['default'] = '';
$pgpoolConfigParam[$key]['regexp'] = $anyelse;

$key = 'ping_path';
$pgpoolConfigParam[$key]['type'] = 'C';
$pgpoolConfigParam[$key]['default'] = '';
$pgpoolConfigParam[$key]['regexp'] = $anyelse;

# Virtual IP control

$key = 'delegate_IP';
$pgpoolConfigParam[$key]['type'] = 'C';
$pgpoolConfigParam[$key]['default'] = '';
$pgpoolConfigParam[$key]['regexp'] = $hostreg;
$pgpoolConfigParam[$key]['null_ok'] = TRUE;

$key = 'ifconfig_path';
$pgpoolConfigParam[$key]['type'] = 'C';
$pgpoolConfigParam[$key]['default'] = '';
$pgpoolConfigParam[$key]['regexp'] = $anyelse;

$key = 'if_up_cmd';
$pgpoolConfigParam[$key]['type'] = 'C';
$pgpoolConfigParam[$key]['default'] = '';
$pgpoolConfigParam[$key]['regexp'] = $anyelse;

$key = 'if_down_cmd';
$pgpoolConfigParam[$key]['type'] = 'C';
$pgpoolConfigParam[$key]['default'] = '';
$pgpoolConfigParam[$key]['regexp'] = $anyelse;

$key = 'arping_path';
$pgpoolConfigParam[$key]['type'] = 'C';
$pgpoolConfigParam[$key]['default'] = '';
$pgpoolConfigParam[$key]['regexp'] = $anyelse;

$key = 'arping_cmd';
$pgpoolConfigParam[$key]['type'] = 'C';
$pgpoolConfigParam[$key]['default'] = '';
$pgpoolConfigParam[$key]['regexp'] = $anyelse;

# Behaivor on escalation

$key = 'clear_memqcache_on_escalation';
$pgpoolConfigParam[$key]['type'] = 'B';
$pgpoolConfigParam[$key]['default'] = 'on';

$key = 'wd_escalation_command';
$pgpoolConfigParam[$key]['type'] = 'C';
$pgpoolConfigParam[$key]['default'] = '';
$pgpoolConfigParam[$key]['regexp'] = $anyelse;

# Life checking pgpool-II

# (Common)

$key = 'wd_lifecheck_method';
$pgpoolConfigParam[$key]['type'] = 'C';
$pgpoolConfigParam[$key]['default'] = 'heartbeat';
$pgpoolConfigParam[$key]['regexp'] = selectreg(array('heartbeat', 'query'));

$key = 'wd_interval';
$pgpoolConfigParam[$key]['type'] = 'N';
$pgpoolConfigParam[$key]['default'] = 10;
$pgpoolConfigParam[$key]['max'] = NUM_MAX;
$pgpoolConfigParam[$key]['min'] = 0;

# (Configuration of heartbeat mode)

$key = 'wd_heartbeat_port';
$pgpoolConfigParam[$key]['type'] = 'N';
$pgpoolConfigParam[$key]['default'] = 9694;
$pgpoolConfigParam[$key]['max'] = NUM_MAX;
$pgpoolConfigParam[$key]['min'] = 0;

$key = 'wd_heartbeat_keepalive';
$pgpoolConfigParam[$key]['type'] = 'N';
$pgpoolConfigParam[$key]['default'] = 2;
$pgpoolConfigParam[$key]['max'] = NUM_MAX;
$pgpoolConfigParam[$key]['min'] = 0;

$key = 'wd_heartbeat_deadtime';
$pgpoolConfigParam[$key]['type'] = 'N';
$pgpoolConfigParam[$key]['default'] = 30;
$pgpoolConfigParam[$key]['max'] = NUM_MAX;
$pgpoolConfigParam[$key]['min'] = 0;

$key = 'heartbeat_destination';
$pgpoolConfigHbDestinationParam[$key]['type'] = 'C';
$pgpoolConfigHbDestinationParam[$key]['default'] = '';
$pgpoolConfigHbDestinationParam[$key]['regexp'] = $hostreg;

$key = 'heartbeat_destination_port';
$pgpoolConfigHbDestinationParam[$key]['type'] = 'N';
$pgpoolConfigHbDestinationParam[$key]['default'] = 9694;
$pgpoolConfigHbDestinationParam[$key]['min'] = 1024;
$pgpoolConfigHbDestinationParam[$key]['max'] = NUM_MAX;

$key = 'heartbeat_device';
$pgpoolConfigHbDestinationParam[$key]['type'] = 'C';
$pgpoolConfigHbDestinationParam[$key]['default'] = 'eth0';
$pgpoolConfigHbDestinationParam[$key]['regexp'] = $anyelse;

# (Configuration of query mode)

$key = 'wd_life_point';
$pgpoolConfigParam[$key]['type'] = 'N';
$pgpoolConfigParam[$key]['default'] = 3;
$pgpoolConfigParam[$key]['max'] = NUM_MAX;
$pgpoolConfigParam[$key]['min'] = 0;

$key = 'wd_lifecheck_query';
$pgpoolConfigParam[$key]['type'] = 'C';
$pgpoolConfigParam[$key]['default'] = 'SELECT 1';
$pgpoolConfigParam[$key]['regexp'] = $anyelse;

$key = 'wd_lifecheck_dbname';
$pgpoolConfigParam[$key]['type'] = 'C';
$pgpoolConfigParam[$key]['default'] = 'template1';
$pgpoolConfigParam[$key]['regexp'] = $anyelse;

$key = 'wd_lifecheck_user';
$pgpoolConfigParam[$key]['type'] = 'C';
$pgpoolConfigParam[$key]['default'] = 'nobody';
$pgpoolConfigParam[$key]['regexp'] = $anyelse;

$key = 'wd_lifecheck_password';
$pgpoolConfigParam[$key]['type'] = 'C';
$pgpoolConfigParam[$key]['default'] = '';
$pgpoolConfigParam[$key]['regexp'] = $anyelse;

# Servers to monitor

$key = 'other_pgpool_hostname';
$pgpoolConfigWdOtherParam[$key]['type'] = 'C';
$pgpoolConfigWdOtherParam[$key]['default'] = '';
$pgpoolConfigWdOtherParam[$key]['regexp'] = $hostreg;

$key = 'other_pgpool_port';
$pgpoolConfigWdOtherParam[$key]['type'] = 'N';
$pgpoolConfigWdOtherParam[$key]['default'] = 9999;
$pgpoolConfigWdOtherParam[$key]['min'] = 1024;
$pgpoolConfigWdOtherParam[$key]['max'] = NUM_MAX;

$key = 'other_wd_port';
$pgpoolConfigWdOtherParam[$key]['type'] = 'N';
$pgpoolConfigWdOtherParam[$key]['default'] = 9000;
$pgpoolConfigWdOtherParam[$key]['min'] = 1024;
$pgpoolConfigWdOtherParam[$key]['max'] = NUM_MAX;

#------------------------------------------------------------------------------
# ON MEMORY QUERY CACHE
#------------------------------------------------------------------------------

$key = 'memory_cache_enabled';
$pgpoolConfigParam[$key]['type'] = 'B';
$pgpoolConfigParam[$key]['default'] = 'off';

$key = 'memqcache_method';
$pgpoolConfigParam[$key]['type'] = 'C';
$pgpoolConfigParam[$key]['default'] = 'shmem';
$pgpoolConfigParam[$key]['regexp'] = selectreg(array('shmem', 'memcached'));

$key = 'memqcache_memcached_host';
$pgpoolConfigParam[$key]['type'] = 'C';
$pgpoolConfigParam[$key]['default'] = 'localhost';
$pgpoolConfigParam[$key]['regexp'] = $hostreg;

$key = 'memqcache_memcached_port';
$pgpoolConfigParam[$key]['type'] = 'N';
$pgpoolConfigParam[$key]['default'] = 11211;
$pgpoolConfigParam[$key]['max'] = NUM_MAX;
$pgpoolConfigParam[$key]['min'] = 1024;

$key = 'memqcache_total_size';
$pgpoolConfigParam[$key]['type'] = 'N';
$pgpoolConfigParam[$key]['default'] = 67108864;
$pgpoolConfigParam[$key]['max'] = PHP_INT_MAX;
$pgpoolConfigParam[$key]['min'] = 0;

$key = 'memqcache_max_num_cache';
$pgpoolConfigParam[$key]['type'] = 'N';
$pgpoolConfigParam[$key]['default'] = 1000000;
$pgpoolConfigParam[$key]['max'] = PHP_INT_MAX;
$pgpoolConfigParam[$key]['min'] = 0;

$key = 'memqcache_expire';
$pgpoolConfigParam[$key]['type'] = 'N';
$pgpoolConfigParam[$key]['default'] = 0;
$pgpoolConfigParam[$key]['max'] = NUM_MAX;
$pgpoolConfigParam[$key]['min'] = 0;

$key = 'memqcache_auto_cache_invalidation';
$pgpoolConfigParam[$key]['type'] = 'B';
$pgpoolConfigParam[$key]['default'] = 'on';

$key = 'memqcache_maxcache';
$pgpoolConfigParam[$key]['type'] = 'N';
$pgpoolConfigParam[$key]['default'] = 409600;
$pgpoolConfigParam[$key]['max'] = PHP_INT_MAX;
$pgpoolConfigParam[$key]['min'] = 0;

$key = 'memqcache_cache_block_size';
$pgpoolConfigParam[$key]['type'] = 'N';
$pgpoolConfigParam[$key]['default'] = 1048576;
$pgpoolConfigParam[$key]['max'] = PHP_INT_MAX;
$pgpoolConfigParam[$key]['min'] = 512;

$key = 'memqcache_oiddir';
$pgpoolConfigParam[$key]['type'] = 'C';
$pgpoolConfigParam[$key]['default'] = '/var/log/pgpool/oiddir';
$pgpoolConfigParam[$key]['regexp'] = $dirreg;

$key = 'white_memqcache_table_list';
$pgpoolConfigParam[$key]['type'] = 'C';
$pgpoolConfigParam[$key]['default'] = '';
$pgpoolConfigParam[$key]['regexp'] = $anyelse;

$key = 'black_memqcache_table_list';
$pgpoolConfigParam[$key]['type'] = 'C';
$pgpoolConfigParam[$key]['default'] = '';
$pgpoolConfigParam[$key]['regexp'] = $anyelse;

#------------------------------------------------------------------------------
# OTHERS
#------------------------------------------------------------------------------

$key = 'relcache_expire';
$pgpoolConfigParam[$key]['type'] = 'N';
$pgpoolConfigParam[$key]['default'] = 0;
$pgpoolConfigParam[$key]['min'] = 0;
$pgpoolConfigParam[$key]['max'] = NUM_MAX;

$key = 'relcache_size';
$pgpoolConfigParam[$key]['type'] = 'N';
$pgpoolConfigParam[$key]['default'] = 256;
$pgpoolConfigParam[$key]['min'] = 0;
$pgpoolConfigParam[$key]['max'] = NUM_MAX;

$key = 'check_temp_table';
$pgpoolConfigParam[$key]['type'] = 'B';
$pgpoolConfigParam[$key]['default'] = 'on';

#------------------------------------------------------------------------------
# Deleted
#------------------------------------------------------------------------------

$key = 'backend_socket_dir';
$pgpoolConfigParam[$key]['type'] ='C';
$pgpoolConfigParam[$key]['default'] ='/tmp';
$pgpoolConfigParam[$key]['regexp'] = "$dirreg";

?>
