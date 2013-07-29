<?php

/* vim: set expandtab tabstop=4 shiftwidth=4 softtabstop=4: */

/**
 * Infomation of the pgpool summary
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

if (!isset($_SESSION[SESSION_LOGIN_USER])) {
    exit();
}

$params = readConfigParams(array('port',
                                 'wd_hostname',
                                 'wd_port',
                                 'trusted_servers',
                                 'delegate_IP',
                                 'wd_lifecheck_method',
                                 'wd_heartbeat_port',
                                 'wd_heartbeat_keepalive',
                                 'wd_heartbeat_deadtime',
                                 'wd_interval',
                                 'wd_life_point',
                                 'wd_lifecheck_query',
                                 'other_pgpool_hostname',
                                 'other_pgpool_port',
                                 'other_wd_port'));


// get watchdog information
$watchdogInfo = array();
for ($i = 0; $i < count($params['other_pgpool_hostname']); $i++) {
    $watchdogInfo[] = getWatchdogInfo($i);
}
$watchdogInfo['local'] = getWatchdogInfo();

foreach ($watchdogInfo as $key => $info) {
    switch ($info['status']) {
    case WATCHDOG_INIT:
        $watchdogInfo[$key]['status_str'] = $message['strWdInit'];
        break;
    case WATCHDOG_STANDBY:
        $watchdogInfo[$key]['status_str'] = $message['strWdStandby'];
        break;
    case WATCHDOG_ACTIVE:
        $watchdogInfo[$key]['status_str'] = $message['strWdActive'];
        break;
    case WATCHDOG_DOWN:
        $watchdogInfo[$key]['status_str'] = $message['strWdDown'];
        break;
    default:
        $watchdogInfo[$key]['status_str'] = $message['strUnknown'];
        break;
    }
}

$tpl->assign('params', $params);
$tpl->assign('watchdogInfo', $watchdogInfo);
$tpl->display('innerWatchdog.tpl');

?>
