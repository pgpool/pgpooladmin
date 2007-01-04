<?php

/* vim: set expandtab tabstop=4 shiftwidth=4 softtabstop=4: */

/**
 * Configuration of PgpoolAdmin
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
 * @copyright  2003-2007 PgPool Global Development Group
 * @version    CVS: $Id$
 */

require_once('common.php');
$tpl->assign('help', basename( __FILE__, '.php'));

if(!isset($_SESSION[SESSION_LOGIN_USER])) {
    header('Location: login.php');
    exit();
}

if(isset($_POST['action'])) {
    $action = $_POST['action'];
} else {
    $action = FALSE;
}

$errors = array();
$params = array();

/**
 * Read current parameter
 */
if( defined('_PGPOOL2_LANG'))
    $params['lang'] = _PGPOOL2_LANG;
else
    $errors['lang'] = $message['errNoDefined'];
    
if( defined('_PGPOOL2_CONFIG_FILE'))
    $params['pgpool_config_file'] = _PGPOOL2_CONFIG_FILE;
else
    $errors['pgpool_config_file'] = $message['errNoDefined'];

if( defined('_PGPOOL2_PASSWORD_FILE'))
    $params['password_file'] = _PGPOOL2_PASSWORD_FILE;
else
    $errors['password_file'] = $message['errNoDefined'];

if( defined('_PGPOOL2_COMMAND'))
    $params['pgpool_command'] = _PGPOOL2_COMMAND;
else
    $errors['pgpool_command'] = $message['errNoDefined'];

if( defined('_PGPOOL2_CMD_OPTION_C'))
    $params['c'] = _PGPOOL2_CMD_OPTION_C;
else
    $errors['c'] = $message['errNoDefined'];

if( defined('_PGPOOL2_CMD_OPTION_D'))
    $params['d'] = _PGPOOL2_CMD_OPTION_D;
else
    $errors['d'] = $message['errNoDefined'];

if( defined('_PGPOOL2_CMD_OPTION_M'))
    $params['m'] = _PGPOOL2_CMD_OPTION_M;
else
    $errors['m'] = $message['errNoDefined'];

if( defined('_PGPOOL2_CMD_OPTION_N'))
    $params['n'] = _PGPOOL2_CMD_OPTION_N;
else
    $errors['n'] = $message['errNoDefined'];

if( defined('_PGPOOL2_LOG_FILE'))
    $params['pgpool_logfile'] = _PGPOOL2_LOG_FILE;
else
    $errors['pgpool_logfile'] = $message['errNoDefined'];

if( defined('_PGPOOL2_PCP_DIR'))
    $params['pcp_client_dir'] = _PGPOOL2_PCP_DIR;
else
    $errors['pcp_client_dir'] = $message['errNoDefined'];
    
if( defined('_PGPOOL2_PCP_HOSTNAME'))
    $params['pcp_hostname'] = _PGPOOL2_PCP_HOSTNAME;
else
    $errors['pcp_hostname'] = $message['errNoDefined'];
    
if( defined('_PGPOOL2_STATUS_REFRESH_TIME'))
    $params['pcp_refresh_time'] = _PGPOOL2_STATUS_REFRESH_TIME;
else
    $errors['pcp_refresh_time'] = $message['errNoDefined'];
    
switch ( $action ) {
    case 'update':
        
        $key = 'lang';
        if(isset($_POST[$key])) {
            $params[$key] = $_POST[$key];
        } else {
            $errors[$key] = $message['errNoDefined'];            
        }
        
        $key = 'pgpool_config_file';
        if(isset($_POST[$key])) {
            $params[$key] = $_POST[$key];
        } else {
            $errors[$key] = $message['errNoDefined'];            
        }
        if(!@is_file($params[$key])) {
            $errors[$key] = $message['errFileNotFound'];
        }
        
        $key = 'password_file';
        if(isset($_POST[$key])) {
            $params[$key] = $_POST[$key];
        } else {
            $errors[$key] = $message['errNoDefined'];            
        }
        if(!@is_file($params[$key])) {
            $errors[$key] = $message['errFileNotFound'];
        }
        
        $key = 'pgpool_command';
        if(isset($_POST[$key])) {
            $params[$key] = $_POST[$key];
        } else {
            $errors[$key] = $message['errNoDefined'];            
        }
        if(!is_executable($params[$key])) {
            $errors[$key] = $message['errFileNotFound'];
        }
        
        $key = 'c';
        if(isset($_POST[$key])) {
            $params[$key] = 1;
        } else {
            $params[$key] = 0;
        }
        
        $key = 'd';
        if(isset($_POST[$key])) {
            $params[$key] = 1;
        } else {
            $params[$key] = 0;
        }
        
        $key = 'm';
        if(isset($_POST[$key])) {
            $params[$key] = $_POST[$key];
        } else {
            $errors[$key] = $message['errNoDefined'];            
        }
        
        $key = 'n';
        if(isset($_POST[$key])) {
            $params[$key] = 1;
        } else {
            $params[$key] = 0;
        }
        
        $key = 'pgpool_logfile';
        if(isset($_POST[$key])) {
            $params[$key] = $_POST[$key];
        } else {
            $errors[$key] = $message['errNoDefined'];            
        }
        if($params[$key] != '' && !is_writable(dirname($params[$key]))) {
            $errors[$key] = $message['errFileNotWritable'];
        }

        $key = 'pcp_client_dir';
        if(isset($_POST[$key])) {
            $params[$key] = $_POST[$key];
        } else {
            $errors[$key] = $message['errNoDefined'];            
        }
        
        $key = 'pcp_hostname';
        if(isset($_POST[$key])) {
            $params[$key] = $_POST[$key];
        } else {
            $errors[$key] = $message['errNoDefined'];            
        }
        if(!ereg("^[0-9a-zA-Z\._\-]+$", $params[$key])) {
            $errors[$key] = $message['errIllegalHostname'];            
        }
        
        $key = 'pcp_refresh_time';
        if(isset($_POST[$key])) {
            $params[$key] = $_POST[$key];
        } else {
            $errors[$key] = $message['errNoDefined'];            
        }
        if( !is_numeric($params[$key] )) {
            $errors[$key] = $message['errShouldBeInteger'];
        } else {
            if ( $params[$key] < 0) {
                $errors[$key] = $message['errShouldBeZeroOrMore'];
            }
        }

        if( count($errors) == 0 ) {
            
            $pgmgtConfigFile = dirname(__FILE__) . '/conf/pgmgt.conf.php';
            
            if( ! is_writable($pgmgtConfigFile)) {
                $errorCode = 'e5003';
                $tpl->assign('errorCode', $errorCode);
                $tpl->display('error.tpl');
                exit();
            }
            
            $fp = fopen( $pgmgtConfigFile,  "w");
            if($fp == false) {
                $errorCode = 'e5001';
                $tpl->assign('errorCode', $errorCode);
                $tpl->display('error.tpl');
                exit();
            }

            $str = "<?php\n";
            fputs($fp, $str);
            
            $str = 'define(\'_PGPOOL2_LANG\', \'' . $params['lang'] . '\');' . "\n";
            fputs($fp, $str);

            $str = 'define(\'_PGPOOL2_CONFIG_FILE\', \'' .  $params['pgpool_config_file'] . '\');' . "\n";
            fputs($fp, $str);
            
            $str = 'define(\'_PGPOOL2_PASSWORD_FILE\', \'' .  $params['password_file'] . '\');' . "\n";
            fputs($fp, $str);
            
            $str = 'define(\'_PGPOOL2_COMMAND\', \'' .  $params['pgpool_command'] . '\');' . "\n";
            fputs($fp, $str);

            $str = 'define(\'_PGPOOL2_CMD_OPTION_C\', \'' .  $params['c'] . '\');' . "\n";
            fputs($fp, $str);

            $str = 'define(\'_PGPOOL2_CMD_OPTION_D\', \'' .  $params['d'] . '\');' . "\n";
            fputs($fp, $str);

            $str = 'define(\'_PGPOOL2_CMD_OPTION_M\', \'' .  $params['m'] . '\');' . "\n";
            fputs($fp, $str);

            $str = 'define(\'_PGPOOL2_CMD_OPTION_N\', \'' .  $params['n'] . '\');' . "\n";
            fputs($fp, $str);

            $str = 'define(\'_PGPOOL2_LOG_FILE\', \'' .  $params['pgpool_logfile'] . '\');' . "\n";
            fputs($fp, $str);

            $str = 'define(\'_PGPOOL2_PCP_DIR\', \'' .  $params['pcp_client_dir'] . '\');' . "\n";
            fputs($fp, $str);

            $str = 'define(\'_PGPOOL2_PCP_HOSTNAME\', \'' .  $params['pcp_hostname'] . '\');' . "\n";
            fputs($fp, $str);

            $str = 'define(\'_PGPOOL2_STATUS_REFRESH_TIME\', \'' .  $params['pcp_refresh_time'] . '\');' . "\n";
            fputs($fp, $str);
            
            $str = "?>\n";
            fputs($fp, $str);
            fclose($fp);

            $tpl->assign('status', 'success');
        }
        
        /**
         * reload message catalog
         */
        $lang = selectLanguage($params['lang'], $messageList);
        include('lang/' . $lang . '.lang.php');
        $tpl->assign('message', $message);
        break;
        
    default:
}

$tpl->assign('pgpoolConf', _PGPOOL2_CONFIG_FILE);
$tpl->assign('pcpConf', _PGPOOL2_PASSWORD_FILE);
$tpl->assign('params', $params);
$tpl->assign('errors', $errors);
$tpl->display('config.tpl');

?>
