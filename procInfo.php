<?php

/* vim: set expandtab tabstop=4 shiftwidth=4 softtabstop=4: */

/**
 * Infomation view of Pgpool process info in status view
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

require_once('command.php');

if(!isset($_SESSION[SESSION_LOGIN_USER])) {
    exit();
}

$ret = execPcp('PCP_PROC_COUNT');
if(!array_key_exists('SUCCESS', $ret)) {
    $errorCode = 'e1004';
    $tpl->assign('errorCode', $errorCode);
    $tpl->display('innerError.tpl');
    exit();
} else {
        $procPids = split(" ", $ret['SUCCESS']);
}

for($i=0; $i<count($procPids); $i++) {
    $procPid = $procPids[$i];
    $ret = execPcp('PCP_PROC_INFO', $procPid);
    if(!array_key_exists('SUCCESS', $ret)) {
        $errorCode = 'e1005';
        $tpl->assign('errorCode', $errorCode);
        $tpl->display('innerError.tpl');
        exit();
    } else {

        $ret = $ret['SUCCESS'];
        
        if(count($ret) > 0) {
            foreach($ret as $line) {
                $data = split(" ", $line);
                
                $dateFormat = $message['strDateFormat'];
                $data[2] = date($dateFormat, $data[2]); 
                $data[3] = date($dateFormat, $data[3]);
                $procInfo[$procPid][]  = $data;
            }
        } else {
            $procInfo[$procPid] = array('');
        }
    }
}
$tpl->assign('procInfo', $procInfo);
$tpl->display('procInfo.tpl');

?>

