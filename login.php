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
 * @copyright  2003-2013 PgPool Global Development Group
 * @version    CVS: $Id$
 */

require_once('common.php');
require_once('command.php');

/* --------------------------------------------------------------------- */
/* login.php                                                             */
/* --------------------------------------------------------------------- */

// Check loginstatus
$success = FALSE;
if (isset($_SESSION[SESSION_LOGIN_USER])) {
    $success = TRUE;
}

// Do login
if ($success == FALSE) {
    if (isset($_POST['username'])) {
        $username = $_POST['username'];
    } else {
        $tpl->display('login.tpl');
        exit();
    }

    if (isset($_POST['password'])) {
        $password = $_POST['password'];
    }

    $md5password = md5($password);

    if (!file_exists(_PGPOOL2_PASSWORD_FILE)) {
        $errorCode = 'e7001';
        $tpl->assign('errorCode', $errorCode);
        $tpl->display('error.tpl');
        exit();
    }

    // Check each rows in pcp.conf to search
    $fp = fopen(_PGPOOL2_PASSWORD_FILE, 'r');
    $regexp = "^{$username}:{$md5password}";

    if ($fp != NULL) {
        while (!feof($fp) ) {
            $line = fgets($fp);
            if (preg_match("/$regexp/", $line) ) {
                $_SESSION[SESSION_LOGIN_USER]          = $username;
                $_SESSION[SESSION_LOGIN_USER_PASSWORD] = $password;
                $success = TRUE;
            }
        }
    }
    fclose($fp);

    // If login falied, show login page again.
    if (!$success) {
        $tpl->display('login.tpl');
        exit();
    }
}

// If user has already logined, show status page.
header("Location: status.php");
exit();
