<?php

/* vim: set expandtab tabstop=4 shiftwidth=4 softtabstop=4: */

/**
 * Log view of Pgpool in status view
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
 * @version    CVS: $Id$
 */

require_once('common.php');

if (!isset($_SESSION[SESSION_LOGIN_USER])) {
    exit();
}

$pgpoolLog = _PGPOOL2_LOG_FILE;
if ($pgpoolLog == '') {
    $logDir = readLogDir();
    $pgpoolLog = "$logDir/pgpool.log";
}

$logFile = @file($pgpoolLog);
if ($logFile == FALSE) {
    $errorCode = 'e8001';
    $tpl->assign('errorCode', $errorCode);
    $tpl->display('innerError.tpl');
    exit();
}

$logSplitFile = array();
for ($i = 0; $i < count($logFile); $i++) {
    $words = explode(" ", $logFile[$i]);
    $words = array_merge(array_diff($words, array("")));

    $logFile[$i] = array('timestamp' => $words[0]. ' '. $words[1],
                         'level'     => $words[2],
                         'pid'       => $words[3]. ' '. $words[4],
                         'message'   => ''
                         );

    for ($j = 5; $j < count($words); $j++) {
        $logFile[$i]['message'] .= ' '. $words[$j];
    }
    $logFile[$i]['message'] = trim($logFile[$i]['message']);
}

$tpl->assign('logFile', $logFile);
$tpl->display('innerLog.tpl');
?>
