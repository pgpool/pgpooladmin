<?php

/* vim: set expandtab tabstop=4 shiftwidth=4 softtabstop=4: */

/**
 * Common file of PgpoolAdmin
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
 * @copyright  2003-2016 PgPool Global Development Group
 * @version    SVN: $Id$
 */

require_once('version.php');
require_once('libs/Smarty.class.php');
require_once('conf/pgmgt.conf.php');
require_once('bootstrap.php');
require_once('definePgpoolConfParam.php');
error_reporting(E_ALL);

session_start();

/**
 * Initialize Smartry
 */
$tpl = new Smarty();
$tpl->error_reporting = E_ALL & ~E_NOTICE;
$tpl->assign('version', $version);

if (! file_exists('conf/pgmgt.conf.php')) {
    include('lang/en.lang.php');
    $tpl->assign('message', $message);
    $tpl->display('pgmgtNotFound.tpl');
    exit();
}

/**
 * Check login
 */
$tpl->assign('isLogin', isset($_SESSION[SESSION_LOGIN_USER]));
$tpl->assign('isHelp', FALSE);

// If old pgmgt.conf is used, _PGPOOL2_VERSION doen't exist.
// This defined var exists from pgpoolAdmin 3.2.
if (! defined('_PGPOOL2_VERSION')) {
    $versions = versions();
    define('_PGPOOL2_VERSION', $versions[0]);
}

/**
 * Check pgmgt.conf.php Parameter
 */
$errors = array();
if (! defined('_PGPOOL2_LANG') ||
    ! defined('_PGPOOL2_VERSION') ||
    ! defined('_PGPOOL2_CONFIG_FILE') ||
    ! defined('_PGPOOL2_PASSWORD_FILE') ||
    ! defined('_PGPOOL2_COMMAND') ||
    ! defined('_PGPOOL2_PCP_DIR') ||
    ! defined('_PGPOOL2_PCP_HOSTNAME') ||
    ! defined('_PGPOOL2_STATUS_REFRESH_TIME'))
{
    include('lang/en.lang.php');
    errorPage('e7');
}

/**
 * Create message catalog list
 */
$messageList = array();

$res_dir = opendir('lang/');
while ($file_name = readdir( $res_dir )) {
    if (preg_match('/.*\.lang\.php$/', $file_name)) {
        if (@is_file('lang/' . $file_name)) {
            include('lang/' . $file_name);
            $messageList[$message['lang']] = $message['strLang'];

        } else {
            errorPage('e2');
        }
    }
}
$tpl->assign('messageList', $messageList);

/**
 * Load message catalog
 */

$lang = selectLanguage(_PGPOOL2_LANG, $messageList);
include('lang/' . $lang . '.lang.php');
$tpl->assign('message', $message);
$_SESSION[SESSION_MESSAGE] = $message;

/* --------------------------------------------------------------------- */
/* function (DB)                                                         */
/* --------------------------------------------------------------------- */

/**
 * Open databse connection
 */
function openDBConnection($arr)
{
    $conStr = generateConstr($arr);
    $conn = @pg_connect($conStr);
    return $conn;
}

/**
 * Close database connection
 */
function closeDBConnection($connection)
{
    return pg_close($connection);
}

/**
 * Execute query
 */
function execQuery($conn, $sql)
{
    $rs = @pg_query($conn, $sql);
    if (!pg_result_status($rs) == PGSQL_TUPLES_OK) {
        return FALSE;
    }

    return $rs;
}

/**
 * Confirmation whether node is active or is not.
 */
function NodeActive($nodeNum)
{
    $params = readConfigParams(array(
        'backend_hostname', 'backend_port', 'backend_weight',
        'health_check_user', 'health_check_password', 'health_check_database'
    ));

    $conn = openDBConnection(array(
        'host'     => $params['backend_hostname'][$nodeNum],
        'port'     => $params['backend_port'][$nodeNum],
        'dbname'   => (paramExists('health_check_database')) ?
                       $params['health_check_database'] : 'template1',
        'user'     => $params['health_check_user'],
        'password' => $params['health_check_password'],
    ));

    if ($conn == FALSE) {
        return FALSE;
    } else {
        closeDBConnection($conn);
        return TRUE;
    }
}

/**
 * Confirmation whether node is act as a standby server
 */
function NodeStandby($nodeNum)
{
    if (isMasterSlaveMode() == FALSE || useStreaming() == FALSE) {
        return -1;
    }

    $params = readConfigParams(array(
        'backend_hostname', 'backend_port',
        'sr_check_user','sr_check_password'
    ));

    $conn = openDBConnection(array(
        'host'     => $params['backend_hostname'][$nodeNum],
        'port'     => $params['backend_port'][$nodeNum],
        'dbname'   => 'template1',
        'user'     => $params['sr_check_user'],
        'password' => $params['sr_check_password'],
    ));

    if ($conn == FALSE) {
        return -1;
    }

    $result = pg_query($conn, 'SELECT pg_is_in_recovery()');
    if (! pg_result_status($result) == PGSQL_TUPLES_OK) {
        closeDBConnection($conn);
        return -1;
    }

    $rr = pg_fetch_array($result);
    if ($rr[0][0] == 't') {
        $r = 1;
    } else {
        $r = 0;
    }

    @pg_free_result($result);
    closeDBConnection($conn);
    return $r;
}

/**
 * Get if loginUser is super user
 */
function isSuperUser($user_name)
{
    $params = readConfigParams(array('port'));

    // Try to connect the backend by login user
    $conn = openDBConnection(array(
        'port'     => $params['port'],
        'dbname'   => 'template1',
        'user'     => $_SESSION[SESSION_LOGIN_USER],
        'password' => $_SESSION[SESSION_LOGIN_USER_PASSWORD],
    ));

    // Try to connect health check user
    if ($conn === FALSE) {
        $params = readConfigParams(array('port', 'health_check_user', 'health_check_password'));
        $conn = openDBConnection(array(
            'port'     => $params['port'],
            'dbname'   => 'template1',
            'user'     => $params['health_check_user'],
            'password' => $params['health_check_password']
        ));
    }
    if ($conn === FALSE) { return NULL; }

    $result = pg_query($conn, "SELECT usesuper FROM pg_user WHERE usename = '{$user_name}'");
    if (! pg_result_status($result) == PGSQL_TUPLES_OK) {
        closeDBConnection($conn);
        return NULL;
    }

    $rr = pg_fetch_array($result);
    $rtn = (isset($rr['usesuper']) && $rr['usesuper'] == 't') ? 'yes' : 'no';

    @pg_free_result($result);
    closeDBConnection($conn);

    $_SESSION[SESSION_IS_SUPER_USER] = $rtn;

    return $rtn;
}

/**
 * Create connection str for pg_connect()
 */

function generateConstr($params)
{
    $arr = array();
    foreach ($params as $param => $value) {
        if ($value == '') { continue; }
        switch ($param) {
        case 'host':
        case 'port':
        case 'dbname':
        case 'user':
        case 'password':
            $arr[] = "{$param}='{$value}'";
        }
    }
    $conStr = implode(' ', $arr);

    return $conStr;
}

/* --------------------------------------------------------------------- */
/* function (pgpool)                                                     */
/* --------------------------------------------------------------------- */

/**
 * Check if pgpool.pid exists
 */
function DoesPgpoolPidExist()
{
    $params = readConfigParams(array('pid_file_name'));
    $pidFile = $params['pid_file_name'];
    if (file_exists($pidFile) ) {
        return TRUE;
    }
    return FALSE;
}

/* --------------------------------------------------------------------- */
/* function (parameters)                                                 */
/* --------------------------------------------------------------------- */

/**
 * Get the value of "logdir"
 */
function readLogDir()
{
    $params = readConfigParams(array('logdir'));
    return $params['logdir'];
}

/**
 * Read parameters specified in $paramList from pgpool.conf.
 * If $paramList is not specified, all item is read from pgpool.conf.
 */
function readConfigParams($paramList = array())
{
    $rtn = array();
    global $pgpoolConfigParam, $pgpoolConfigBackendParam ,
           $pgpoolConfigWdOtherParam, $pgpoolConfigHbDestinationParam;

    // Try to read pgpool.conf
    $configFile = @file(_PGPOOL2_CONFIG_FILE);
    if ($configFile == FALSE) {
        $errTpl = new Smarty();
        $errTpl->assign('message', $_SESSION[SESSION_MESSAGE]);
        errorPage('e4');
    }

    // Defined array in definePgpoolConfParam.php
    $defines_arr = $pgpoolConfigParam + $pgpoolConfigBackendParam +
                   $pgpoolConfigWdOtherParam + $pgpoolConfigHbDestinationParam;

    $arr = array();
    // Convert lines in files to array
    foreach ($configFile as $line_num => $line) {
        $line = trim($line);
        if (substr($line, 0, 1) == '#' || strpos($line, '=') === FALSE) {
            continue;
        }

        list($key, $value) = explode('=', $line);
        $key = trim($key);

        switch ($key) {
        case 'recovery_1st_stage_command':
        case 'recovery_2nd_stage_command':
            $key_wo_num = $key;
            break;

        default:
            $num = preg_replace('/[^0-9]/', NULL, $key);
            $key_wo_num = str_replace($num, NULL, $key);
            break;
        }

        // Ignore params not specified to read
        if ($paramList && is_array($paramList) && ! in_array($key_wo_num, $paramList)) {
            continue;
        }

        // Remove quotes and comments
        $value = trimValue($value);

        if (! isset($defines_arr[$key_wo_num])) {
            continue;

        // Params with multiple values
        // (backend_*, other_pgpool_*, heartbeat_destination_*, heartbeat_device*)
        } elseif (isset($defines_arr[$key_wo_num]['multiple']) &&
                  $defines_arr[$key_wo_num]['multiple'] == TRUE)
        {
            $rtn[$key_wo_num][$num] = $value;

        } else {
            // Ignore param not defined definePgpoolConfParam.php
            $rtn[$key_wo_num] = $value;
        }
    }

    // Set default value if there is no line about the param
    if ($paramList && is_array($paramList)) {
        foreach ($paramList as $key) {
            if (! isset($rtn[$key]) || $rtn[$key] == NULL) {
                $default_value = $defines_arr[$key]['default'];

                if (isset($defines_arr[$key]['multiple']) &&
                    $defines_arr[$key]['multiple'])
                {
                    $rtn[$key][0] = $default_value;
                } else {
                    $rtn[$key] = $default_value;
                }
            }
        }

    } elseif ($defines_arr) {
        foreach ($defines_arr as $key => $param_info) {
            if (! isset($rtn[$key])) {
                $default_value = (isset($defines_arr[$key]['default'])) ?
                    $defines_arr[$key]['default'] : NULL;

                if (isset($defines_arr[$key]['multiple']) &&
                    $defines_arr[$key]['multiple'])
                {
                    $rtn[$key][0] = $default_value;
                } else {
                    $rtn[$key] = $default_value;
                }
            }
        }
    }

    return $rtn;
}

function trimValue($text)
{
    // Remove spaces
    $text = trim($text);

    $rtn = '';
    $in_quotes = FALSE;
    for ($i = 0; $i < strlen($text); $i++) {
        $c = substr($text, $i, 1);

        switch ($c) {
        // Ignore "'"
        case  "'":
            if ($in_quotes) {
                break 2;
            } else {
                $in_quotes = TRUE;
            }
            break;

        // Ignore "#" comment
        case '#':
            if (! $in_quotes) {
                break;
            }
        break;
        }

        $rtn .= $c;
    }

    $rtn = trim($rtn, "'");
    return $rtn;
}

/**
 * Select language registred in conf directory
 */
function selectLanguage($selectLang, $messageList)
{
    if ($selectLang == NULL || $selectLang == 'auto') {
        if(isset($_SERVER['HTTP_ACCEPT_LANGUAGE'])) {
            $acceptLanguages = $_SERVER['HTTP_ACCEPT_LANGUAGE'];
        } else {
            $acceptLanguages = FALSE;
        }

        $lang = NULL;

        if ($acceptLanguages == FALSE) {
            $lang = 'en';

        } else {
            $langList = explode(',|;', $acceptLanguages);
            foreach ($langList as $acceptLanguage) {
                foreach (array_keys($messageList) as $messageLanguage) {
                    if ($acceptLanguage == $messageLanguage ) {
                        $lang = $messageLanguage;
                        break;
                    }
                }
                if ($lang != NULL) { break; }
            }
        }
    } else {
        $lang = $selectLang;
    }

    $_SESSION[SESSION_LANG] = $lang;
    return $lang;
}

/**
 * Check if the parameter is used in the specified version
 */
function paramExists($param)
{
    $add_version = $del_version = 0;

    /* Add */
    switch ($param) {
        // params added in 3.5
        case 'if_cmd_path':
        case 'health_check_database':
        case 'pcp_listen_addresses':
        case 'search_primary_node_timeout':
        case 'serialize_accept':
        case 'sr_check_database':
        case 'wd_de_escalation_command':
        case 'wd_ipc_socket_dir':
        case 'wd_monitoring_interfaces_list':
        case 'wd_priority':
            $add_version = 3.5;
            break;

        // params added in 3.4
        case 'listen_backlog_multiplier':
        case 'app_name_redirect_preference_list':
        case 'database_redirect_preference_list':
        case 'allow_sql_comments':
        case 'log_error_verbosity':
        case 'client_min_messages':
        case 'log_min_messages':
        case 'log_line_prefix':
        case 'connect_timeout':
        case 'check_unlogged_table':
            $add_version = 3.4;
            break;

        // params added in 3.3
        case 'clear_memqcache_on_escalation':
        case 'heartbeat_destination':
        case 'heartbeat_destination_port':
        case 'heartbeat_device':
        case 'wd_authkey':
        case 'wd_escalation_command':
        case 'wd_lifecheck_method':
        case 'wd_heartbeat_port':
        case 'wd_heartbeat_keepalive':
        case 'wd_heartbeat_deadtime':
        case 'wd_lifecheck_dbname':
        case 'wd_lifecheck_user':
        case 'wd_lifecheck_password':
            $add_version = 3.3;
            break;

        // params added in 3.2
        case 'health_check_max_retries':
        case 'health_check_retry_delay':
        case 'use_watchdog':
        case 'trusted_servers':
        case 'delegate_IP':
        case 'wd_hostname':
        case 'wd_port':
        case 'wd_interval':
        case 'ping_path':
        case 'ifconfig_path':
        case 'if_up_cmd':
        case 'if_down_cmd':
        case 'arping_path':
        case 'arping_cmd':
        case 'wd_life_point':
        case 'wd_lifecheck_query':
        case 'memory_cache_enabled':
        case 'memqcache_method':
        case 'memqcache_memcached_host':
        case 'memqcache_memcached_port':
        case 'memqcache_total_size':
        case 'memqcache_max_num_cache':
        case 'memqcache_expire':
        case 'memqcache_auto_cache_invalidation':
        case 'memqcache_maxcache':
        case 'memqcache_cache_block_size':
        case 'memqcache_oiddir':
        case 'white_memqcache_table_lsit':
        case 'black_memqcache_table_list':
        case 'relcache_size':
        case 'check_temp_table':
            $add_version = 3.2;
            break;

        // params added in 3.1
        case 'follow_master_command':
        case 'log_destination':
        case 'syslog_facility':
        case 'syslog_ident':
        case 'debug_level':
        case 'sr_check_period':
        case 'sr_check_user':
        case 'sr_check_password':
        case 'health_check_password':
        case 'relcache_expire':
        case 'backend_flag':
            $add_version = 3.1;
            break;

        // params added in 3.0
        case 'pool_passwd':
        case 'master_slave_sub_mode':
        case 'delay_threshold':
        case 'log_standby_delay':
        case 'debug_level':
        case 'failover_if_affected_tuples_mismatch':
        case 'white_function_list':
        case 'black_function_list':
            $add_version = 3.0;
            break;

        // params added in 2.3
        case 'fail_over_on_backend_error':
        case 'log_per_node_statement':
        case 'lobj_lock_table':
        case 'ssl':
        case 'ssl_key':
        case 'ssl_cert':
        case 'ssl_ca_cert':
        case 'ssl_ca_cert_dir':
            $add_version = 2.3;
            break;

        // params added in 2.2
        case 'pid_file_name':
        case 'client_idle_limit_in_recovery':
            $add_version = 2.2;
            break;
    }

    /* Delete */
    switch ($param) {
        // params deleted in 3.5
        case 'ifconfig_path':
            $del_version = 3.5;
            break;

        // params deleted in 3.4
        case 'print_timestamp':
        case 'parallel_mode':
        case 'system_db_hostname':
        case 'system_db_port':
        case 'system_db_dbname':
        case 'system_db_schema':
        case 'system_db_user':
        case 'system_db_password':
            $del_version = 3.4;
            break;

        // params deleted in 3.2
        case 'enable_query_cache':
            $del_version = 3.2;
            break;

        // params deleted in 3.0
        case 'backend_socket_dir':
            $del_version = 3.0;
            break;

        // params deleted in 2.1
        case 'replication_timeout':
            $del_version = 2.1;
            break;
    }

    $rtn = TRUE;
    if ($add_version && _PGPOOL2_VERSION < $add_version) {
        $rtn = FALSE;
    }
    if ($del_version && $del_version <= _PGPOOL2_VERSION) {
        $rtn = FALSE;
    }
    return $rtn;
}

/* --------------------------------------------------------------------- */
/* function (mode)                                                       */
/* --------------------------------------------------------------------- */

function versions()
{
    return array('3.5', '3.4', '3.3', '3.2', '3.1', '3.0',
                 '2.3', '2.2', '2.1', '2.0');
}

/**
 * Whether pgpool is operating in the replication mode or not?
 */
function isReplicationMode()
{
    $params = readConfigParams(array('replication_mode'));

    if (isTrue($params['replication_mode'])) {
        return TRUE;
    } else {
        return FALSE;
    }
}

/**
 * Whether pgpool is operating in the master slave mode or not?
 */
function isMasterSlaveMode()
{
    $params = readConfigParams(array('master_slave_mode'));

    if (isTrue($params['master_slave_mode'])) {
        return TRUE;
    } else {
        return FALSE;
    }
}

/**
 * Whether pgpool is operating in the parallel mode or not?
 */
function isParallelMode()
{
    $params = readConfigParams(array('parallel_mode'));

    if (isTrue($params['parallel_mode'])) {
        return TRUE;
    } else {
        return FALSE;
    }
}

/**
 * Whether pgpool is using stream sub mode in master slave mode or not?
 */
function useStreaming()
{
    $params = readConfigParams(array('master_slave_sub_mode'));

    if (isMasterSlaveMode() && $params['master_slave_sub_mode'] == 'stream') {
        return TRUE;
    } else {
        return FALSE;
    }
}

/**
 * Whether pgpool uses syslog or not?
 */
function useSyslog()
{
    if (!paramExists('log_destination')) { return FALSE; }

    $params = readConfigParams(array('log_destination'));

    if ($params['log_destination'] == 'syslog') {
        return TRUE;
    } else {
        return FALSE;
    }
}

/**
 * Return if pgpool has watchdog feature
 */
function hasWatchdog()
{
    return (3.2 <= _PGPOOL2_VERSION);
}

/**
 * Return if pgpool has memqcache
 */
function hasMemqcache()
{
    return (3.2 <= _PGPOOL2_VERSION);
}

/**
 * Return if pgpool has pcp_promote_node ?
 */
function hasPcpPromote()
{
    return (3.1 <= _PGPOOL2_VERSION);
}

/*
 * Return the list of parameters in a group
 */
function getMultiParams()
{
    $rtn = array();

    $rtn['backend'] = array('backend_hostname', 'backend_port', 'backend_weight', 'backend_data_directory');
    if (paramExists('backend_flag')) {
        $rtn['backend'][] = 'backend_flag';
    }

    $rtn['other_pgpool'] = array('other_pgpool_hostname', 'other_pgpool_port', 'other_wd_port');

    $rtn['heartbeat'] = array('heartbeat_destination', 'heartbeat_destination_port', 'heartbeat_device');

    return $rtn;
}

/* --------------------------------------------------------------------- */
/* function (other)                                                      */
/* --------------------------------------------------------------------- */

function isPipe($str)

{
    return (strpos($str, '|') !== FALSE);
}

function isTrue($value)
{
    return in_array($value, array('on', 'true'));
}

function errorPage($errorCode)
{
    global $tpl;

    $tpl->assign('errorCode', $errorCode);
    $tpl->display('error.tpl');
    exit();
}

function pr($array)
{
    echo '<pre>';
    print_r($array);
    echo '</pre>';
}
