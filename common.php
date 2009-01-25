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
 * @copyright  2003-2008 PgPool Global Development Group
 * @version    SVN: $Id$
 */

require_once('version.php');
require_once('libs/Smarty.class.php');
error_reporting(E_ALL);

define('SESSION_LOGIN_USER', 'loginUser');
define('SESSION_LOGIN_USER_PASSWORD', 'md5pass');
define('SESSION_LANG', 'lang');
define('SESSION_MESSAGE', 'message');

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
$tpl->assign('version', $version);

if(!file_exists('conf/pgmgt.conf.php')) {
    include('lang/en.lang.php');
    $tpl->assign('message', $message);
    $tpl->display('pgmgtNotFound.tpl');
    exit();
}

require_once('conf/pgmgt.conf.php');

/**
 * Check login
 */
$isLogin = FALSE;
if(isset($_SESSION[SESSION_LOGIN_USER])) {
    $isLogin = TRUE;
    $tpl->assign('isLogin', $isLogin);
}

/**
 * Check pgmgt.conf.php Parameter
 */
$errors = array();
if( !defined('_PGPOOL2_LANG')
    || !defined('_PGPOOL2_CONFIG_FILE')
    || !defined('_PGPOOL2_PASSWORD_FILE')
    || !defined('_PGPOOL2_COMMAND')
    || !defined('_PGPOOL2_PCP_DIR')
    || !defined('_PGPOOL2_PCP_HOSTNAME')
    || !defined('_PGPOOL2_STATUS_REFRESH_TIME')) {
        
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
while($file_name = readdir( $res_dir )) {
    if(ereg('.*\.lang\.php$', $file_name)) {
        if(@is_file('lang/' . $file_name)) {
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
    $host= $param['hostname'];
    $port = $param['port'];
    $dbname = $param['dbname'];
    $user = $param['user'];
    $password = $param['password'];

    if($host != '') {
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
function execQuery($conn, $sql) {
    $rs = @pg_query($conn, $sql);
    if(!pg_result_status($rs) == PGSQL_TUPLES_OK) {
        return false;
    }

    return $rs;
}

/**
 * Select language registred in conf directory
 *
 * @return  string
 */
function selectLanguage($selectLang, $messageList) {
    if( $selectLang == null || $selectLang == 'auto') {
        if(isset($_SERVER['HTTP_ACCEPT_LANGUAGE'])) {
            $acceptLanguages = $_SERVER['HTTP_ACCEPT_LANGUAGE'];
        } else {
            $acceptLanguages = FALSE;
        }
        
        $lang = null;
        
        if($acceptLanguages == FALSE) {
            $lang = 'en';
        } else {
            $langList = split(',|;', $acceptLanguages);
            foreach($langList as $acceptLanguage) {
                foreach(array_keys($messageList) as $messageLanguage) {
                    if( $acceptLanguage == $messageLanguage ) {
                        $lang = $messageLanguage;
                        break;
                    }
                }
                if( $lang != null) break;
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
function isParallelMode() {
    
    $params = readConfigParams(array('parallel_mode'));

    if($params['parallel_mode'] == 'true') {
        return true;
    } else {
        return false;
    }
}

/**
 * Confirmation whether node is active or is not.
 *
 * @return  bool
 */
function NodeActive($num) {
    $healthCheckDb = 'template1';
    
    $params = readHealthCheckParam();
    
    $healthCheckUser = $params['health_check_user'];
    $backendHostName = $params['backend_hostname'][$num];
    $backendPort = $params['backend_port'][$num];
    if($backendHostName != '') {
        $conStr = "dbname=$healthCheckDb user=$healthCheckUser host=$backendHostName port=$backendPort" ;
    } else {
        $conStr = "dbname=$healthCheckDb port=$backendPort user=$healthCheckUser" ;
    }

    $conn = @pg_connect($conStr);

    if($conn == FALSE) {
        @pg_close($conn);
        return FALSE;
    } else {
        @pg_close($conn);
        return TRUE;
    }
}

/**
 * Read parameter from pgpool.conf using health check 
 *
 * @return  array
 */
function readHealthCheckParam() {
    
    $params = readConfigParams(array('health_check_user',
                                                  'backend_hostname',
                                                  'backend_port',
                                                  'backend_weight'));
    
    return $params;
}

/**
 * Existence confirmation of pgpool.pid
 *
 * @return  bool
 */
function DoesPgpoolPidExist() {
    $params = readConfigParams(array('pid_file_name'));
    $pidFile = $params['pid_file_name'];
    if( file_exists($pidFile) ) {
        return true;
    }
    return false;
}

/**
 * Existence confirmation of pgpool.pid
 *
 * @return  bool
 */
function readLogDir() {
    
    $params = readConfigParams(array('logdir'));
    return $params['logdir'];
}

/**
 * Whether pgpool is operating in the replication mode or not?
 *
 * @return bool
 */
function isReplicationMode() {
    
    $params = readConfigParams(array('replication_mode'));

    if($params['replication_mode'] == 'true') {
        return true;
    } else {
        return false;
    }
}

/**
 * Whether pgpool is operating in the master slave mode or not?
 *
 * @return bool
 */
function isMasterSlaveMode() {
    
    $params = readConfigParams(array('master_slave_mode'));

    if($params['master_slave_mode'] == 'true') {
        return true;
    } else {
        return false;
    }
}

/**
 * Read parameters specified in $paramList from pgpool.conf.
 * If $paramList is not specified, all item is read from pgpool.conf.
 *
 * @param array $paramList
 * @return array
 */
function readConfigParams($paramList = FALSE) {

    $results = array();
    $configParam = array();
    
    $configFile = @file(_PGPOOL2_CONFIG_FILE);
    if($configFile == false) {
        $errTpl = new Smarty();
        $errTpl->assign('message', $_SESSION[SESSION_MESSAGE]);
        $errorCode = 'e4';
        $errTpl->assign('errorCode', $errorCode);
        $errTpl->display('error.tpl');
        exit();
    }
    
    foreach ($configFile as $line_num => $line) {
        $line = trim($line);
        if(preg_match("/^\w/", $line)) {
            list($key, $value) = split("=", $line);
            
            $key = trim($key);
            $value = trim($value);
            
            if(preg_match("/^backend_hostname/", $key)) {
                $num = str_replace('backend_hostname', '', $key);
                $configParam['backend_hostname'][$num] = ereg_replace("'", "", $value);
            }
            else if(preg_match("/^backend_port/", $key)) {
                $num = str_replace('backend_port', '', $key);
                $configParam['backend_port'][$num] = $value;
            }
            else if(preg_match("/^backend_weight/", $key)) {
                $num = str_replace('backend_weight', '', $key);
                $configParam['backend_weight'][$num] = $value;
            }
            else if(preg_match("/^backend_data_directory/", $key)) {
                $num = str_replace('backend_data_directory', '', $key);
                $configParam['backend_data_directory'][$num] = ereg_replace("'", "", $value);
            }
            else {
                $configParam[$key] = ereg_replace("'", "", $value);
            }
        }
    }
    
    if(is_array($paramList)) {
        foreach($paramList as $key) {
            if(isset($configParam[$key])) {
                $results[$key] = $configParam[$key];
            } else {
                include('definePgpoolConfParam.php');
                if(!preg_match("/^backend_hostname/", $key)
                  && !preg_match("/^backend_port/", $key)
                  && !preg_match("/^backend_weight/", $key)
				   && !preg_match("/^backend_data_directory/", $key)) {
                    $results[$key] = $pgpoolConfigParam[$key]['default'];
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

?>
