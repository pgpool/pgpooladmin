<?php

/* vim: set expandtab tabstop=4 shiftwidth=4 softtabstop=4: */

/**
 * Node status of pgpool
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
 * @version    SVN: $Id$
 */

require_once('common.php');
require_once('command.php');

/* --------------------------------------------------------------------- */
/* nodeStatus.php                                                        */
/* --------------------------------------------------------------------- */

// Check login status
if (!isset($_SESSION[SESSION_LOGIN_USER])) {
    exit();
}

// select buttons to each nodes depending on their status
$isParallelMode    = isParallelMode();
$isReplicationMode = isReplicationMode();
$isMasterSlaveMode = isMasterSlaveMode();

$configValue = readConfigParams(array('backend_hostname', 'backend_port'));
if (!isset($configValue['backend_hostname'])) { return; }
$backends_in_conf = $configValue['backend_hostname'];

// Get nodes' status
$nodeCount = NULL;
$is_pgpool_active = DoesPgpoolPidExist();
if ($is_pgpool_active) {
    $nodeCount = getNodeCount();
}
$has_not_loaded_node = FALSE;

// Merge backends in pgpool.conf and them in pgpool
// ex) when remove a backend but not reload yet
if (count($backends_in_conf) < $nodeCount) {
    for ($i = 0; $i < $nodeCount; $i++) {
        $backends_in_conf[$i] = array();
    }
}

$nodeInfo = array();
foreach ($backends_in_conf as $i => $backend) {
    // Set buttons
    $nodeInfo[$i]['return']     = FALSE;
    $nodeInfo[$i]['disconnect'] = FALSE;
    $nodeInfo[$i]['promote']    = FALSE;
    $nodeInfo[$i]['recovery']   = FALSE;

    // The flag if postgres is active or sleeping
    $nodeInfo[$i]['is_active'] = NodeActive($i);

    // nodes recognized by pgpool
    if ($nodeCount != NULL/* && $i < $nodeCount*/) {
        // Get info by pcp_node_info
        $nodeInfo[$i] += getNodeInfo($i);

        // Get the result of "SELECT pg_is_in_recovery()" as integer(0, 1, -1)
        // (If pgpool don't act in Master/Slave & SR mode, this value will be ignored.)
        $nodeInfo[$i]['is_standby'] = NodeStandby($i);

        switch($nodeInfo[$i]['status']) {
            case NODE_ACTIVE_NO_CONNECT:
            case NODE_ACTIVE_CONNECTED:
                if ($isReplicationMode || $isMasterSlaveMode) {
                    if ($nodeInfo[$i]['is_active']) {
                        $nodeInfo[$i]['disconnect'] = TRUE;
                    }
                }

                // pcp_promote_node exists after V3.1
                if (hasPcpPromote() && useStreaming()) {
                    $nodeInfo[$i]['promote'] = TRUE;
                }
                break;

            case NODE_DOWN:
                if ($isReplicationMode || $isMasterSlaveMode) {
                    if ($nodeInfo[$i]['is_active']) {
                        $nodeInfo[$i]['return'] = TRUE;
                    } else {
                        $nodeInfo[$i]['recovery'] = TRUE;
                    }
                }
                break;
        }

    // nodes not working as backend (just written in pgpool.conf)
    } else {
        $has_not_loaded_node = TRUE;
        $nodeInfo[$i]['hostname'] = $configValue['backend_hostname'][$i];
        $nodeInfo[$i]['port'] = $configValue['backend_port'][$i];
        $nodeInfo[$i]['weight'] = 0;
        $nodeInfo[$i]['status'] =  NODE_NOT_LOADED;
        $nodeInfo[$i]['is_standby'] = NULL;
    }
}

// Set vars
$tpl->assign('help', basename( __FILE__, '.php'));

$tpl->assign('refreshTime',   _PGPOOL2_STATUS_REFRESH_TIME * 1000);
$tpl->assign('nodeInfo',      $nodeInfo);
$tpl->assign('parallelMode',  $isParallelMode);
$tpl->assign('msgStopPgpool', $message['msgStopPgpool']);
$tpl->assign('nodeCount',     $nodeCount);
$tpl->assign('has_not_loaded_node', $has_not_loaded_node);
$tpl->assign('pgpoolIsActive', $is_pgpool_active);

// Set params
$configValue = readConfigParams('recovery_1st_stage');
$tpl->assign('params', $configValue);

// Display
$tpl->display('nodeStatus.tpl');
