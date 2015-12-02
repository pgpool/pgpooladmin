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
 * @copyright  2003-2015 PgPool Global Development Group
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

/* --------------------------------------------------------------------- */
/* define                                                                */
/* --------------------------------------------------------------------- */

$select_options = array(
    'lang' => array('auto' => 'auto') + $messageList,
    'version' => array_combine(versions(), versions()),
    'm' => array('s' => 'smart', 'f' => 'fast', 'i' => 'immediate'),
);
$tpl->assign('select_options', $select_options);

/* --------------------------------------------------------------------- */
/* main                                                                  */
/* --------------------------------------------------------------------- */

/*
 * Read current parameter
 */
$params['lang']               = (defined('_PGPOOL2_LANG')) ?
                                _PGPOOL2_LANG : $message['errNoDefined'];
$params['version']            = (defined('_PGPOOL2_LANG')) ?
                                _PGPOOL2_VERSION : $message['errNoDefined'];
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
$params['C']                  = (defined('_PGPOOL2_CMD_OPTION_LARGE_C')) ?
                                _PGPOOL2_CMD_OPTION_LARGE_C  : $message['errNoDefined'];
$params['pgpool_logfile']     = (defined('_PGPOOL2_LOG_FILE')) ?
                                _PGPOOL2_LOG_FILE : $message['errNoDefined'];
$params['pcp_client_dir']     = (defined('_PGPOOL2_PCP_DIR')) ?
                                _PGPOOL2_PCP_DIR : $message['errNoDefined'];
$params['pcp_hostname']       = (defined('_PGPOOL2_PCP_HOSTNAME')) ?
                                _PGPOOL2_PCP_HOSTNAME : $message['errNoDefined'];
$params['pcp_refresh_time']   = (defined('_PGPOOL2_STATUS_REFRESH_TIME')) ?
                                _PGPOOL2_STATUS_REFRESH_TIME : $message['errNoDefined'];

$tpl->assign('status', NULL);
switch ( $action ) {
    case 'update':
        setValue('lang');
        setValue('version');
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
        setBool('C');

        setValue('pgpool_logfile');
        if ($params['pgpool_logfile'] != '' && isPipe($params['pgpool_logfile'])) {
            $tmp_str = trim($params['pgpool_logfile']);
            if ($tmp_str[0] != '|' || $tmp_str[strlen($tmp_str) - 1] == '|') {
                $errors['pgpool_logfile'] = $message['errIllegalPipe'];
            }
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

            if (! is_writable($pgmgtConfigFile)) { errorPage('e5003'); }

            $result = writePgmtConf($pgmgtConfigFile);
            if (!$result) { errorPage('e5001'); }

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

    if (strpos($key, 'file') !== FALSE && $key != 'pgpool_logfile') {
        fileError($key);
    }
}

function setBool($key)
{
    global $g_post;
    global $params;

    switch ($key) {
    case 'C':
        $key_in_form = 'large_c'; break;
    case 'D':
        $key_in_form = 'large_d'; break;
    default:
        $key_in_form = $key; break;
    }

    if (isset($g_post[$key_in_form])) {
        $params[$key] = $g_post[$key_in_form];
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

    write($fp, '_PGPOOL2_LANG',               $params['lang']);
    write($fp, '_PGPOOL2_VERSION',            $params['version']);

    write($fp, '_PGPOOL2_CONFIG_FILE',        $params['pgpool_config_file']);
    write($fp, '_PGPOOL2_PASSWORD_FILE',      $params['password_file']);
    write($fp, '_PGPOOL2_COMMAND',            $params['pgpool_command']);

    write($fp, '_PGPOOL2_CMD_OPTION_C',       $params['c']);
    write($fp, '_PGPOOL2_CMD_OPTION_LARGE_D', $params['D']);
    write($fp, '_PGPOOL2_CMD_OPTION_D',       $params['d']);
    write($fp, '_PGPOOL2_CMD_OPTION_M',       $params['m']);
    write($fp, '_PGPOOL2_CMD_OPTION_N',       $params['n']);
    write($fp, '_PGPOOL2_CMD_OPTION_LARGE_C', $params['C']);

    write($fp, '_PGPOOL2_LOG_FILE',            $params['pgpool_logfile']);
    write($fp, '_PGPOOL2_PCP_DIR',             $params['pcp_client_dir']);
    write($fp, '_PGPOOL2_PCP_HOSTNAME',        $params['pcp_hostname']);
    write($fp, '_PGPOOL2_STATUS_REFRESH_TIME', $params['pcp_refresh_time']);

    $str = "?>\n";
    fputs($fp, $str);

    fclose($fp);
    return TRUE;
}

function write($fp, $defname, $val)
{
    fputs($fp, "define('{$defname}', '{$val}');\n");
}
?>
