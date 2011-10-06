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
 * @copyright  2003-2010 PgPool Global Development Group
 * @version    CVS: $Id$
 */

require_once('common.php');
$tpl->assign('help', basename( __FILE__, '.php'));

if (!isset($_SESSION[SESSION_LOGIN_USER])) {
    header('Location: login.php');
    exit();
}

if (isset($_POST['action'])) {
    $action = $_POST['action'];
} else {
    $action = FALSE;
}

global $g_msg_nodef;
$g_msg_nodef = $message['errNoDefined'];

global $g_msg_notfound;
$g_msg_notfound = $message['errFileNotFound'];

global $g_post;
$g_post = $_POST;

global $params;
$params = array();

global $errors;
$errors = array();

/*
 * Read current parameter
 */
$params['lang']               = (defined('_PGPOOL2_LANG')) ?
                                _PGPOOL2_LANG : $message['errNoDefined'];
$params['pgpool_config_file'] = (defined('_PGPOOL2_CONFIG_FILE')) ?
                                _PGPOOL2_CONFIG_FILE : $message['errNoDefined'];
$params['password_file']      = (defined('_PGPOOL2_PASSWORD_FILE')) ?
                                _PGPOOL2_PASSWORD_FILE : $message['errNoDefined'];
$params['pgpool_command']     = (defined('_PGPOOL2_COMMAND')) ?
                                _PGPOOL2_COMMAND : $message['errNoDefined'];
$params['c']                  = (defined('_PGPOOL2_CMD_OPTION_C')) ?
                                _PGPOOL2_CMD_OPTION_C : $message['errNoDefined'];
$params['d']                  = (defined('_PGPOOL2_CMD_OPTION_D')) ?
                                _PGPOOL2_CMD_OPTION_D : $message['errNoDefined'];
$params['D']                  = (defined('_PGPOOL2_CMD_OPTION_LARGE_D')) ?
                                _PGPOOL2_CMD_OPTION_LARGE_D  : $message['errNoDefined'];
$params['m']                  = (defined('_PGPOOL2_CMD_OPTION_M')) ?
                                _PGPOOL2_CMD_OPTION_M : $message['errNoDefined'];
$params['n']                  = (defined('_PGPOOL2_CMD_OPTION_N')) ?
                                _PGPOOL2_CMD_OPTION_N : $message['errNoDefined'];
$params['pgpool_logfile']     = (defined('_PGPOOL2_LOG_FILE')) ?
                                _PGPOOL2_LOG_FILE : $message['errNoDefined'];
$params['pcp_client_dir']     = (defined('_PGPOOL2_PCP_DIR')) ?
                                _PGPOOL2_PCP_DIR : $message['errNoDefined'];
$params['pcp_hostname']       = (defined('_PGPOOL2_PCP_HOSTNAME')) ?
                                _PGPOOL2_PCP_HOSTNAME : $message['errNoDefined'];
$params['pcp_refresh_time']   = (defined('_PGPOOL2_STATUS_REFRESH_TIME')) ?
                                _PGPOOL2_STATUS_REFRESH_TIME : $message['errNoDefined'];

switch ( $action ) {
    case 'update':

        setValue('lang');
        setValue('pgpool_config_file');
        setValue('password_file');

        setValue('pgpool_command');
        if (!is_executable($params['pgpool_command'])) {
            $errors['pgpool_command'] = $message['errFileNotFound'];
        }

        setBool('c');
        setBool('D');
        setBool('d');
        setValue('m');
        setBool('n');

        setValue('pgpool_logfile');
        // pipe
        if ($params['pgpool_logfile'] != '' && isPipe($params['pgpool_logfile'])) {
            $tmp_str = trim($params['pgpool_logfile']);
            if ($tmp_str[0] != '|' || $tmp_str[strlen($tmp_str) - 1] == '|') {
                $errors['pgpool_logfile'] = $message['errIllegalPipe'];
            }
        // file
        } elseif ($params['pgpool_logfile'] != '' && !is_writable(dirname($params['pgpool_logfile']))) {
            $errors['pgpool_logfile'] = $message['errFileNotWritable'];
        }

        setValue('pcp_client_dir');

        setValue('pcp_hostname');
        if (!preg_match("/^[0-9a-zA-Z\._\-]+$/", $params['pcp_hostname'])) {
            $errors[$key] = $message['errIllegalHostname'];
        }

        setValue('pcp_refresh_time');
        if (!is_numeric($params['pcp_refresh_time'] )) {
            $errors['pcp_refresh_time'] = $message['errShouldBeInteger'];
        } else {
            if ($params['pcp_refresh_time'] < 0) {
                $errors['pcp_refresh_time'] = $message['errShouldBeZeroOrMore'];
            }
        }

        /*
         * If no error, write conf/pgmgt.conf.php.
         */
        if (count($errors) == 0 ) {
            $pgmgtConfigFile = dirname(__FILE__) . '/conf/pgmgt.conf.php';

            if (!is_writable($pgmgtConfigFile)) {
                $errorCode = 'e5003';
                $tpl->assign('errorCode', $errorCode);
                $tpl->display('error.tpl');
                exit();
            }

            $result = writePgmtConf($pgmgtConfigFile);
            if (!$result) {
                $errorCode = 'e5001';
                $tpl->assign('errorCode', $errorCode);
                $tpl->display('error.tpl');
                exit();
            }

            $tpl->assign('status', 'success');

        } else {
            $tpl->assign('errors', $errors);
        }

        /*
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

/* --------------------------------------------------------------------- */
/* Functions                                                             */
/* --------------------------------------------------------------------- */

function setValue($key)
{
    global $g_post;
    global $g_err_msg;
    global $params;

    if (isset($g_post[$key])) {
        $params[$key] = $g_post[$key];
    } else {
        $params[$key] = $g_msg_nodef;
    }

    if (strpos($key, 'file') !== FALSE) {
        fileError($key);
    }
}

function setBool($key)
{
    global $g_post;
    global $prams;

    if (isset($g_post[$key])) {
        $params[$key] = 1;
    } else {
        $params[$key] = 0;
    }
}

function fileError($key)
{
    global $params;
    global $errors;
    global $g_msg_notfound;

    if (!@is_file($params[$key])) {
        $errors[$key] = $g_msg_notfound;
    }
}

function writePgmtConf($pgmgtConfigFile)
{
    global $params;

    $fp = fopen($pgmgtConfigFile,  "w");
    if ($fp == FALSE) {
        return FALSE;
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

    $str = 'define(\'_PGPOOL2_CMD_OPTION_LARGE_D\', \'' .  $params['D'] . '\');' . "\n";
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
    return TRUE;
}
?>
