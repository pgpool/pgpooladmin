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
 * @copyright  2003-2013 PgPool Global Development Group
 * @version    CVS: $Id$
 */

require_once('common.php');

if (!isset($_SESSION[SESSION_LOGIN_USER])) {
    exit();
}

$logAction = (isset($_GET['logAction']) && $_GET['logAction'] ?
    $_GET['logAction'] : 'all');
$logOffset = (isset($_GET['logOffset']) && $_GET['logOffset'] ?
    $_GET['logOffset'] : 0);
$logEnd = (isset($_GET['logEnd']) && $_GET['logEnd'] ?
    $_GET['logEnd'] : 0);

$pgpoolLog = _PGPOOL2_LOG_FILE;
if ($pgpoolLog == '') {
    $logDir = readLogDir();
    $pgpoolLog = "$logDir/pgpool.log";
}

$logFileAll = @file($pgpoolLog);
if ($logFileAll == FALSE) {
    $errorCode = 'e8001';
    $tpl->assign('errorCode', $errorCode);
    $tpl->display('innerError.tpl');
    exit();
}
$logTotalLines = count($logFileAll);

switch ($logAction) {
    case 'latest':
        $logEnd = $logTotalLines;
        $logOffset = $logTotalLines - EACH_LOG_LINES;
        break;
    case 'prev':
        $logEnd = $logOffset;
        $logOffset = $logOffset - EACH_LOG_LINES;
        break;
    case 'next':
        $logOffset = $logEnd;
        $logEnd = $logEnd + EACH_LOG_LINES;
        break;
    case 'all':
    default:
        $logEnd = $logTotalLines;
        $logOffset = 0;
        break;
}

$logOffset = min(max($logOffset, 0), $logTotalLines);
$logEnd = min(max($logEnd, 0), $logTotalLines);
if ($logOffset == $logEnd) {
    $logEnd = $logTotalLines;
    $logOffset = 0;
}

$logFile = array();
for ($i = $logOffset; $i < $logEnd; $i++) {
    $words = explode(" ", $logFileAll[$i]);
    $words = array_merge(array_diff($words, array("")));
    $logLine = array('timestamp' => $words[0]. ' '. $words[1],
                     'level'     => $words[2],
                     'pid'       => $words[3]. ' '. $words[4],
                     'message'   => ''
                     );
    for ($j = 5; $j < count($words); $j++) {
        $logLine['message'] .= ' '. $words[$j];
    }
    $logLine['message'] = trim($logLine['message']);
    $logFile[] = $logLine;
}

$tpl->assign('logFile', $logFile);
$tpl->assign('logTotalLines', $logTotalLines);
$tpl->assign('logAction', $logAction);
$tpl->assign('logOffset', $logOffset);
$tpl->assign('logEnd', $logEnd);
$tpl->assign('refreshTimeLog', REFRESH_LOG_SECONDS);
$tpl->assign('eachLogLines', EACH_LOG_LINES);
$tpl->display('innerLog.tpl');
?>
