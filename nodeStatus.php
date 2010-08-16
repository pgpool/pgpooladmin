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

$MAX_VALUE = 2147483647;

if(!isset($_SESSION[SESSION_LOGIN_USER])) {
    exit();
}

$ret = execPcp('PCP_NODE_COUNT');
if(!array_key_exists('SUCCESS', $ret)) {
    $errorCode = 'e1002';
    $tpl->assign('errorCode', $errorCode);
    $tpl->display('innerError.tpl');
    exit();
} else {
    $nodeCount = $ret['SUCCESS'];
}

$tpl->assign('nodeCount', $nodeCount);

$isParallelMode = isParallelMode();
$isReplicationMode = isReplicationMode();
$isMasterSlaveMode = isMasterSlaveMode();

$nodeInfo = array();
$node_alive = false;

for($i=0; $i<$nodeCount; $i++) {
    $ret = execPcp('PCP_NODE_INFO', $i);
    if(!array_key_exists('SUCCESS', $ret)) {
        $errorCode = 'e1003';
        $tpl->assign('errorCode', $errorCode);
        $tpl->display('innerError.tpl');
        exit();
    } else {
        $ret = $ret['SUCCESS'];
    }
    $nodeInfo[$i] = explode(" ", $ret);
    $nodeInfo[$i][3] =  sprintf('%.3f', $nodeInfo[$i][3]);
	/* node is active? */
	if ($nodeInfo[$i][2] != 3)
		$node_alive = true;

	$nodeInfo[$i][5] = NodeStandby($i);
}

for ($i = 0; $i < $nodeCount; $i++) {
	if ($node_alive == false) {
		if (($isReplicationMode || $isMasterSlaveMode) &&
			NodeActive($i))
			array_push($nodeInfo[$i], 'return');
		else
			array_push($nodeInfo[$i], 'none');
	} else if( $isParallelMode ) {
        array_push($nodeInfo[$i], 'none');
    } else {
        switch($nodeInfo[$i][2]) {
		case 1:
		case 2:
			if($isReplicationMode || $isMasterSlaveMode) {
				array_push($nodeInfo[$i], 'disconnect');
			} else {
				array_push($nodeInfo[$i], 'none');
			}
			break; 
		case 3:
			if($isReplicationMode || $isMasterSlaveMode) {
				if(NodeActive($i)) {
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
}

$tpl->assign('refreshTime', _PGPOOL2_STATUS_REFRESH_TIME*1000);
$tpl->assign('nodeInfo', $nodeInfo);
$tpl->assign('parallelMode', $isParallelMode);
$tpl->assign('msgStopPgpool', $message['msgStopPgpool']);
$tpl->display('nodeStatus.tpl');

?>
