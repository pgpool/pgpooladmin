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
 * @copyright  2003-2018 PgPool Global Development Group
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
    if (isset($_POST['username']) && $_POST['username'] != '') {
        $username = trim($_POST['username']);
    } else {
        $tpl->display('login.tpl');
        exit();
    }

    if (isset($_POST['password']) && $_POST['password'] != '') {
        $password = trim($_POST['password']);
    } else {
        $tpl->display('login.tpl');
        exit();
    }

    $md5username = md5($username);
    $md5password = md5($password);

    if (!file_exists(_PGPOOL2_PASSWORD_FILE)) {
        $errorCode = 'e7001';
        $tpl->assign('errorCode', $errorCode);
        $tpl->display('error.tpl');
        exit();
    }

    // Check each rows in pcp.conf to search
    $fp = fopen(_PGPOOL2_PASSWORD_FILE, 'r');
    $input = "{$md5username}:{$md5password}";

    if ($fp != NULL) {
        while (!feof($fp)) {
            
            $line = trim(fgets($fp));
            $line_arr = explode(':', $line);

            // Ignore empty lines and comment lines
            if (count($line_arr) != 2 || $line_arr[0] == '' || $line_arr[1] == '' || 
                strpos($line, '#') === 0) {
                continue;
            }

            $expected_username = md5($line_arr[0]);
            $expected_password = $line_arr[1];
            $expected = "{$expected_username}:{$expected_password}";

            if (hash_equals($expected, $input)) {
                $_SESSION[SESSION_LOGIN_USER]          = $username;
                $_SESSION[SESSION_LOGIN_USER_PASSWORD] = $password;
                $success = TRUE;
                break;
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
