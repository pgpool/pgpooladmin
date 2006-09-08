<?php

/* vim: set expandtab tabstop=4 shiftwidth=4 softtabstop=4: */

/**
 * Change in password for PgpoolAdmin written in pcp.conf
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
 * @copyright  2003-2006 PgPool Global Development Group
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


switch ( $action ) {
    case 'update':
        
        if(!isset($_POST['password']) || !isset($_POST['password2'])) {
            $tpl->display('changePassword.tpl');
            break;
        }
        
        $password  = $_POST['password'];
        $password2 = $_POST['password2'];
        
        if($password == '' || $password2 == '') {
            $tpl->assign('error', $message['errPasswordMismatch']);
            $tpl->display('changePassword.tpl');
            break;
        }
        
        if($password === $password2) {
            
            $passFile = @file(_PGPOOL2_PASSWORD_FILE);
            if($passFile == false) {
                $errorCode = 'e6001';
                $tpl->assign('errorCode', $errorCode);
                $tpl->display('error.tpl');
                exit();
            }
            
            if( ! is_writable(_PGPOOL2_PASSWORD_FILE) ) {
                $errorCode = 'e6003';
                $tpl->assign('errorCode', $errorCode);
                $tpl->display('error.tpl');
                exit();
            }
            $fw = fopen(_PGPOOL2_PASSWORD_FILE, 'w');
            
            for($i=0; $i<count($passFile); $i++) {
                
                $line = $passFile[$i];
                $spt = split(":", $line);
                
                if($spt[0] == $_SESSION[SESSION_LOGIN_USER]) {
                    $line = $_SESSION[SESSION_LOGIN_USER] . ":" . md5($password) . "\n";
                }
                fputs($fw, $line);
            }
            fclose($fw);
            
            session_unset();
            $tpl->display('login.tpl');
            break;
        } else {
            $tpl->assign('error', $message['errPasswordMismatch']);
        }

    default:
        $tpl->display('changePassword.tpl');
        break;
}
?>

