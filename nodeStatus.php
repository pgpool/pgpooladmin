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
 * @copyright  2003-2010 PgPool Global Development Group
 * @version    SVN: $Id$
 */

require_once('common.php');
require_once('command.php');
$tpl->assign('help', basename( __FILE__, '.php'));

$MAX_VALUE = PHP_INT_MAX;

// node status in "pcp_node_info" result
define('NODE_ACTIVE_NO_CONNECT', 1);
define('NODE_ACTIVE_CONNECTED',  2);
define('NODE_DOWN',              3);

if (!isset($_SESSION[SESSION_LOGIN_USER])) {
    exit();
}

// cout nodes
$ret = execPcp('PCP_NODE_COUNT');
if (!array_key_exists('SUCCESS', $ret)) {
    $errorCode = 'e1002';
    $tpl->assign('errorCode', $errorCode);
    $tpl->display('innerError.tpl');
    exit();
} else {
    $nodeCount = $ret['SUCCESS'];
}

$tpl->assign('nodeCount', $nodeCount);

$nodeInfo = array();
$node_alive = FALSE;

// get nodes' status
for ($i = 0; $i < $nodeCount; $i++) {
    // execute "pcp_node_info" command
    // ex) host1 5432 1 1073741823.500000
    $ret = execPcp('PCP_NODE_INFO', $i);

    if (!array_key_exists('SUCCESS', $ret)) {
        $errorCode = 'e1003';
        $tpl->assign('errorCode', $errorCode);
        $tpl->display('innerError.tpl');
        exit();

    } else {
        $ret = $ret['SUCCESS'];
    }

    $nodeInfo[$i] = explode(" ", $ret);

    // load balance weight: normalize format
    $nodeInfo[$i][3] =  sprintf('%.3f', $nodeInfo[$i][3]);

    // node is active?
    if ($nodeInfo[$i][2] != NODE_DOWN) {
        $node_alive = TRUE;
    }
}

// select buttons to each nodes depending on their status
$isParallelMode    = isParallelMode();
$isReplicationMode = isReplicationMode();
$isMasterSlaveMode = isMasterSlaveMode();

for ($i = 0; $i < $nodeCount; $i++) {
    if ($node_alive == FALSE) {
        if (($isReplicationMode || $isMasterSlaveMode) && NodeActive($i)) {
            array_push($nodeInfo[$i], 'return');
        } else {
            array_push($nodeInfo[$i], 'none');
        }

    } elseif ($isParallelMode ) {
        array_push($nodeInfo[$i], 'none');

    } else {
        switch($nodeInfo[$i][2]) {
            case NODE_ACTIVE_NO_CONNECT:
            case NODE_ACTIVE_CONNECTED:
                if ($isReplicationMode || $isMasterSlaveMode) {
                    array_push($nodeInfo[$i], 'disconnect');
                } else {
                    array_push($nodeInfo[$i], 'none');
                }
                if (useStreaming()) {
                    array_push($nodeInfo[$i], 'promote');
                }
                break;

            case NODE_DOWN:
                if ($isReplicationMode || $isMasterSlaveMode) {
                    if (NodeActive($i)) {
                        array_push($nodeInfo[$i], 'return');
                    } else {
                        array_push($nodeInfo[$i], 'recovery');
                    }
                } else {
                    array_push($nodeInfo[$i], 'none');
                }
                break;
        }
    }

    // result of "SELECT pg_is_in_recovery()" as integer(0, 1, -1)
    // (If pgpool don't act in Master/Slave & SR mode, this value will be ignored.)
    $nodeInfo[$i][6] = NodeStandby($i);
}

$tpl->assign('refreshTime',   _PGPOOL2_STATUS_REFRESH_TIME * 1000);
$tpl->assign('nodeInfo',      $nodeInfo);
$tpl->assign('parallelMode',  $isParallelMode);
$tpl->assign('msgStopPgpool', $message['msgStopPgpool']);
$tpl->display('nodeStatus.tpl');

?>
