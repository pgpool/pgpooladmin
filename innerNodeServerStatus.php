<?php

/* vim: set expandtab tabstop=4 shiftwidth=4 softtabstop=4: */

/**
 * View of servers status registered in pgpool.conf
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
/* InnerNodeServerStatus.php                                             */
/* --------------------------------------------------------------------- */

// Check login status
if (!isset($_SESSION[SESSION_LOGIN_USER])) {
    exit();
}

// Get backend info
$params = readConfigParams(array('backend_hostname', 'backend_port'));
if (isset($params['backend_hostname'])) {
    $backendHostName = $params['backend_hostname'];
    $backendPort     = $params['backend_port'];

} else {
    $backendHostName = array();
    $backendHostPort = array();
}

$is_pgpool_running = DoesPgpoolPidExist();
$nodeInfo = array();
foreach($backendHostName as $num => $hostname) {
    $nodeInfo[$num]['hostname'] = $backendHostName[$num];
    $nodeInfo[$num]['port']     = $backendPort[$num];
    $nodeInfo[$num]['is_active'] = NodeActive($num);

    if ($is_pgpool_running) {
        $result = getNodeInfo($num);
        $nodeInfo[$num]['status'] = $result['status'];
    }
}

// Get node num
$nodeNum = (isset($_GET['num'])) ? $_GET['num'] : NULL;

// Set vars
$tpl->assign('pgpoolIsRunning',   $is_pgpool_running);
$tpl->assign('nodeServerStatus', $nodeInfo);
$tpl->assign('nodeCount',        count($nodeInfo));
$tpl->assign('nodeNum',          $nodeNum);
$tpl->assign('refreshTime',      (0 <= _PGPOOL2_STATUS_REFRESH_TIME) ?
                                 _PGPOOL2_STATUS_REFRESH_TIME * 1000 : 5000);

// Display
$tpl->display('innerNodeServerStatus.tpl');
