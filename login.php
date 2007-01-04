<?php

/* vim: set expandtab tabstop=4 shiftwidth=4 softtabstop=4: */

/**
 * Login processing to PgpoolAdmin
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
require_once('command.php');

$success = false;

if(isset($_SESSION[SESSION_LOGIN_USER])) {
    $success = true;
}

if($success == false) {
    if(isset($_POST['username'])) {
        $username = $_POST['username'];
    } else {
        $tpl->display('login.tpl');
        exit();
    }
    
    if(isset($_POST['password'])) {
        $password = $_POST['password'];
    }
    
    $md5password = md5($password);
    
    if( !file_exists(_PGPOOL2_PASSWORD_FILE)) {
        $errorCode = 'e7001';
        $tpl->assign('errorCode', $errorCode);
        $tpl->display('error.tpl');
        exit();
    }
    
    $fp = fopen(_PGPOOL2_PASSWORD_FILE, 'r');
    $regexp = '^' . $username.":".$md5password;
    
    if($fp != null) {
        while( !feof($fp) ) {
            $line = fgets($fp);
            if( ereg($regexp, $line) ) {
                $_SESSION[SESSION_LOGIN_USER] = $username;
                $_SESSION[SESSION_LOGIN_USER_PASSWORD] = $password;
                $success = true;
            }
        }
    }
    fclose($fp);
}

if(!$success) {
    $tpl->display('login.tpl');
    exit();
}

$tpl->assign('isLogin', TRUE);
$tpl->assign('viewPHP', 'nodeStatus.php');

$refreshTime = 5000;
if( _PGPOOL2_STATUS_REFRESH_TIME >= 0 ) {
    $refreshTime = _PGPOOL2_STATUS_REFRESH_TIME * 1000;
}
if(DoesPgpoolPidExist()) {
    $tpl->assign('pgpoolIsActive', true);
} else {
    $tpl->assign('pgpoolIsActive', false);
}

$tpl->assign('c', _PGPOOL2_CMD_OPTION_C);
$tpl->assign('d', _PGPOOL2_CMD_OPTION_D);
$tpl->assign('m', _PGPOOL2_CMD_OPTION_M);
$tpl->assign('n', _PGPOOL2_CMD_OPTION_N);

$tpl->assign('pgpoolConf', _PGPOOL2_CONFIG_FILE);
$tpl->assign('pcpConf', _PGPOOL2_PASSWORD_FILE);
$tpl->assign('refreshTime', $refreshTime);
$tpl->assign('msgStopPgpool', $message['msgStopPgpool']);
$tpl->assign('help', 'status');
$tpl->display('status.tpl');

?>
