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
 * @copyright  2003-2013 PgPool Global Development Group
 * @version    SVN: $Id$
 */

require_once('version.php');
require_once('libs/Smarty.class.php');
error_reporting(E_ALL);

define('SESSION_LOGIN_USER',          'loginUser');
define('SESSION_LOGIN_USER_PASSWORD', 'md5pass');
define('SESSION_LANG',                'lang');
define('SESSION_MESSAGE',             'message');

function versions()
{
    return array('3.2', '3.1', '3.0',
                 '2.3', '2.2', '2.1', '2.0');
}

session_start();

/**
 * Smarty Parameter
 */
define('SMARTY_TEMPLATE_DIR', dirname(__FILE__) . '/templates' );
define('SMARTY_COMPILE_DIR', dirname(__FILE__) . '/templates_c' );

/**
 * Initialize Smartry
 */
$tpl = new Smarty();
//$tpl->error_reporting = E_ALL & ~E_NOTICE;
$tpl->assign('version', $version);

if (!file_exists('conf/pgmgt.conf.php')) {
    include('lang/en.lang.php');
    $tpl->assign('message', $message);
    $tpl->display('pgmgtNotFound.tpl');
    exit();
}

require_once('conf/pgmgt.conf.php');

/**
 * Check login
 */
$tpl->assign('isLogin', isset($_SESSION[SESSION_LOGIN_USER]));
$tpl->assign('isHelp', FALSE);

// If old pgmgt.conf is used, _PGPOOL2_VERSION doen't exist.
// This defined var exists from pgpoolAdmin 3.2.
if (!defined('_PGPOOL2_VERSION')) {
    $versions = versions();
    define('_PGPOOL2_VERSION', $versions[0]);
}

/**
 * Check pgmgt.conf.php Parameter
 */
$errors = array();
if (!defined('_PGPOOL2_LANG') ||
    !defined('_PGPOOL2_VERSION') ||
    !defined('_PGPOOL2_CONFIG_FILE') ||
    !defined('_PGPOOL2_PASSWORD_FILE') ||
    !defined('_PGPOOL2_COMMAND') ||
    !defined('_PGPOOL2_PCP_DIR') ||
    !defined('_PGPOOL2_PCP_HOSTNAME') ||
    !defined('_PGPOOL2_STATUS_REFRESH_TIME'))
{
    include('lang/en.lang.php');
    $tpl->assign('message', $message);
    $errorCode = 'e7';
    $tpl->assign('errorCode', $errorCode);
    $tpl->display('error.tpl');
    exit();
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
            $errorCode = 'e2';
            $tpl->assign('errorCode', $errorCode);
            $tpl->display('error.tpl');
            exit();
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

/**
 * Open databse connection
 *
 * @param  array $param
 * @return resource
 */
function openDBConnection($param)
{
    $host     = $param['hostname'];
    $port     = $param['port'];
    $dbname   = $param['dbname'];
    $user     = $param['user'];
    $password = $param['password'];

    if ($host != '') {
        $conStr = "host=$host port=$port dbname=$dbname user=$user password=$password" ;
    } else {
        $conStr = "port=$port dbname=$dbname user=$user password=$password" ;
    }

    $con = @pg_connect($conStr);
    return $con;
}

/**
 * Close database connection
 *
 * @param bool
 */
function closeDBConnection($connection)
{
    return pg_close($connection);
}

/**
 * Execute query
 *
 * @param resource $conn
 * @param string $sql
 * @return resource
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
 * Select language registred in conf directory
 *
 * @return  string
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
 * Whether pgpool is operating in the parallel mode or not?
 *
 * @return bool
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
 * Confirmation whether node is active or is not.
 *
 * @return  bool
 */
function NodeActive($num)
{
    $conn = @pg_connect(conStr($num));

    if ($conn == FALSE) {
        @pg_close($conn);
        return FALSE;
    } else {
        @pg_close($conn);
        return TRUE;
    }
}

/**
 * Confirmation whether node is act as a standby server
 *
 * @return  integer
 */
function NodeStandby($num)
{
    if (isMasterSlaveMode() == FALSE || useStreaming() == FALSE) {
        return -1;
    }

    $conn = @pg_connect(conStr($num, 'stream'));

    if ($conn == FALSE) {
        @pg_close($conn);
        return -1;
    }

    $res = pg_query($conn, 'SELECT pg_is_in_recovery()');
    if (!pg_result_status($res) == PGSQL_TUPLES_OK) {
        @pg_close($conn);
        return -1;
    }

    $rr = pg_fetch_array($res);

    if ($rr[0][0] == 't') {
        $r = 1;
    } else {
        $r = 0;
    }

    @pg_free_result($res);
    @pg_close($conn);
    return $r;
}

/**
 * Create connection str for pg_connect()
 */
function conStr($num, $mode = NULL)
{
    // check user info
    if ($mode == 'stream' && paramExists('sr_check_user')) {
        $params = readConfigParams(array('sr_check_user',
                                         'sr_check_password'));
        $user     = $params['sr_check_user'];
        $password = $params['sr_check_password'];

    } else {
        $params = readConfigParams(array('health_check_user',
                                         'health_check_password'));
        $user     = $params['health_check_user'];
        $password = (isset($params['health_check_user'])) ?
                    $params['health_check_password'] : NULL;
    }

    // backkend info
    $params = readConfigParams(array('backend_hostname',
                                     'backend_port',
                                     'backend_weight'));
    $conStr = array();
    if ($params['backend_hostname'][$num] != '') {
        $conStr[] = "host={$params['backend_hostname'][$num]} ";
    }
    $conStr[] = "port='{$params['backend_port'][$num]}'";
    $conStr[] = "dbname='template1'";
    $conStr[] = "user='{$user}'";
    $conStr[] = "password='{$password}'";

    $conStr = implode($conStr, ' ');
    return $conStr;
}

/**
 * Existence confirmation of pgpool.pid
 *
 * @return  bool
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

/**
 * Existence confirmation of pgpool.pid
 *
 * @return  bool
 */
function readLogDir()
{

    $params = readConfigParams(array('logdir'));
    return $params['logdir'];
}

/**
 * Whether pgpool is operating in the replication mode or not?
 *
 * @return bool
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
 *
 * @return bool
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
 * Whether pgpool is using stream sub mode in master slave mode or not?
 *
 * @return bool
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
 *
 * @return bool
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
 * Read parameters specified in $paramList from pgpool.conf.
 * If $paramList is not specified, all item is read from pgpool.conf.
 *
 * @param array $paramList
 * @return array
 */
function readConfigParams($paramList = FALSE)
{
    $results = array();
    $configParam = array();

    $configFile = @file(_PGPOOL2_CONFIG_FILE);
    if ($configFile == FALSE) {
        $errTpl = new Smarty();
        $errTpl->assign('message', $_SESSION[SESSION_MESSAGE]);
        $errorCode = 'e4';
        $errTpl->assign('errorCode', $errorCode);
        $errTpl->display('error.tpl');
        exit();
    }

    foreach ($configFile as $line_num => $line) {
        $line = trim($line);
        if (preg_match("/^\w/", $line)) {
            list($key, $value) = explode("=", $line);

            $key = trim($key);
            $value = trim($value);

            // params about backend nodes
            if (preg_match("/^backend_hostname/", $key)) {
                $num = str_replace('backend_hostname', '', $key);
                $configParam['backend_hostname'][$num] = str_replace("'", "", $value);

            } elseif (preg_match("/^backend_port/", $key)) {
                $num = str_replace('backend_port', '', $key);
                $configParam['backend_port'][$num] = $value;

            } elseif (preg_match("/^backend_weight/", $key)) {
                $num = str_replace('backend_weight', '', $key);
                $configParam['backend_weight'][$num] = $value;

            } elseif (preg_match("/^backend_data_directory/", $key)) {
                $num = str_replace('backend_data_directory', '', $key);
                $configParam['backend_data_directory'][$num] =str_replace("'", "", $value);

            } elseif (preg_match("/^backend_flag/", $key)) {
                $num = str_replace('backend_flag', '', $key);
                $configParam['backend_flag'][$num] =str_replace("'", "", $value);

            // params about watchdog monitoring
            } elseif (preg_match("/^other_pgpool_hostname/", $key)) {
                $num = str_replace('other_pgpool_hostname', '', $key);
                $configParam['other_pgpool_hostname'][$num] = str_replace("'", "", $value);

            } elseif (preg_match("/^other_pgpool_port/", $key)) {
                $num = str_replace('other_pgpool_port', '', $key);
                $configParam['other_pgpool_port'][$num] = $value;

            } elseif (preg_match("/^other_wd_port/", $key)) {
                $num = str_replace('other_wd_port', '', $key);
                $configParam['other_wd_port'][$num] = $value;

            } else {
                $configParam[$key] = str_replace("'", "", $value);
            }
        }
    }

    if (is_array($paramList)) {
        foreach ($paramList as $key) {
            if (isset($configParam[$key])) {
                $results[$key] = $configParam[$key];
            } else {
                require_once('definePgpoolConfParam.php');
                if(!preg_match("/^backend_hostname/",       $key) &&
                   !preg_match("/^backend_port/",           $key) &&
                   !preg_match("/^backend_weight/",         $key) &&
                   !preg_match("/^backend_data_directory/", $key) &&
                   !preg_match("/^backend_flag/",           $key) &&
                   !preg_match("/^other_pgpool_hostname/",  $key) &&
                   !preg_match("/^other_pgpool_port/",      $key) &&
                   !preg_match("/^other_wd_port/",          $key)
                   )
                {
                    if (isset($configParam[$key])) {
                        $results[$key] = $configParam[$key]['default'];
                    }
                }
            }
        }

    } else {
        $results = $configParam;
    }

    return $results;

}

function isPipe($str)

{
    return (strpos($str, '|') !== FALSE);
}

function isTrue($value)
{
    return in_array($value, array('on', 'true'));
}

/* check version */
function hasWatchdog()
{
    return (3.2 <= _PGPOOL2_VERSION);
}

function hasMemqcache()
{
    return (3.2 <= _PGPOOL2_VERSION);
}
// pgpool has pcp_promote_node ?
function hasPcpPromote()
{
    return (3.1 <= _PGPOOL2_VERSION);
}

function paramExists($param)
{
    $add_version = $del_version = 0;
    switch ($param) {
        /* Add */

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

        /* Delete */

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

    if ($add_version && $add_version <= _PGPOOL2_VERSION) {
        return TRUE;
    } elseif ($del_version && _PGPOOL2_VERSION < $del_version) {
        return TRUE;
    }
    return FALSE;
}
?>
