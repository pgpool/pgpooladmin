<?php

/* vim: set expandtab tabstop=4 shiftwidth=4 softtabstop=4: */

/**
 * Display of status information on pgpool
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
 * @version    SVN: $Id$
 */

require_once('common.php');
require_once('command.php');
$tpl->assign('help', basename( __FILE__, '.php'));

$viewPHP = 'nodeStatus.php';
$refreshTime = 5000;
if (isset($_POST['nodeNumber'])) {
    $nodeNumber = $_POST['nodeNumber'];
} else {
    $nodeNumber = -1;
}


if (!isset($_SESSION[SESSION_LOGIN_USER])) {
    header('Location: login.php');
    exit();
}

if (isset($_POST['action'])) {
    $action = $_POST['action'];
} else {
    $action = FALSE;
}

/**
 * Set pgpool command option
 */

$tpl->assign('c', _PGPOOL2_CMD_OPTION_C);
$tpl->assign('D', _PGPOOL2_CMD_OPTION_LARGE_D);
$tpl->assign('d', _PGPOOL2_CMD_OPTION_D);
$tpl->assign('m', _PGPOOL2_CMD_OPTION_M);
$tpl->assign('n', _PGPOOL2_CMD_OPTION_N);

if (isPipe(_PGPOOL2_LOG_FILE)) {
    $tpl->assign('pipe', 1);
} else {
    $tpl->assign('pipe', 0);
}

switch ($action) {
    case 'start':
        $args = ' ';

        if (isset($_POST['c'])) {
            $args = $args . "-c ";
        }
        if (isset($_POST['D'])) {
            $args = $args . "-D ";
        }
        if (isset($_POST['d'])) {
            $args = $args . "-d ";
        }
        if (isset($_POST['n'])) {
            $pgpoolLog = _PGPOOL2_LOG_FILE;
            if ($pgpoolLog == '') {
                $logDir = readLogDir();
                $pgpoolLog = "$logDir/pgpool.log";
            }
            if (isPipe($pgpoolLog)) {
                $args = "$args -n 2>&1 $pgpoolLog ";
            } else {
                $args = "$args -n > $pgpoolLog ";
            }
        }

        $ret = execPcp('PCP_START_PGPOOL', $args);
        if (!array_key_exists('SUCCESS', $ret)) {
            $tpl->assign('pgpoolStatus', 'pgpool start failed.');
            $tpl->assign('pgpoolMessage', $ret);
        } else {
            for ($i = 0; $i < 10; $i++) {
                if(DoesPgpoolPidExist()) {
                    break;
                } else {
                    sleep(1);
                }
            }

            if (DoesPgpoolPidExist()) {
                $tpl->assign('pgpoolStatus', 'pgpool start succeed');
            } else {
                $tpl->assign('pgpoolStatus', 'pgpool start failed. pgpool.pid not found');
            }
            $tpl->assign('pgpoolMessage', $ret['SUCCESS']);
        }

        break;

    case 'stop':
        $m = $_POST['stop_mode'];

        $ret = execPcp('PCP_STOP_PGPOOL', $m);
        if (!array_key_exists('SUCCESS', $ret)) {
            $errorCode = 'e1006';
            $tpl->assign('errorCode', $errorCode);
            $tpl->display('error.tpl');
            exit();

        } else {
            for ($i = 0; $i < 10; $i++) {
                if (DoesPgpoolPidExist()) {
                    sleep(1);
                } else {
                    break;
                }
            }

            if (DoesPgpoolPidExist()) {
                $tpl->assign('pgpoolStatus', 'pgpool stop failed. pgpool.pid exists.');
            } else {
                $tpl->assign('pgpoolStatus', 'pgpool stop succeed');
            }
        }

        break;

    case 'restart':
        /**
         * Stop pgpool
         */
        $m = $_POST['restart_mode'];

        $ret = execPcp('PCP_STOP_PGPOOL', $m);
        if (!array_key_exists('SUCCESS', $ret)) {
            $errorCode = 'e1006';
            $tpl->assign('errorCode', $errorCode);
            $tpl->display('error.tpl');
            exit();

        } else {
            for($i = 0; $i < 10; $i++) {
                if (DoesPgpoolPidExist()) {
                    sleep(1);
                } else {
                    break;
                }
            }
        }

        if (DoesPgpoolPidExist()) {
            $tpl->assign('pgpoolStatus', 'pgpool restart failed. pgpool.pid exists.');
            break;
        }

        /**
         * Start pgpool
         */
        $args = ' ';

        if (isset($_POST['c'])) {
            $args = $args . "-c ";
        }
        if (isset($_POST['D'])) {
            $args = $args . "-D ";
        }
        if (isset($_POST['d'])) {
            $args = $args . "-d ";
        }
        if (isset($_POST['n'])) {
            $pgpoolLog = _PGPOOL2_LOG_FILE;
            if ($pgpoolLog == '') {
                $logDir = readLogDir();
                $pgpoolLog = "$logDir/pgpool.log";
            }
            if (isPipe($pgpoolLog)) {
                $args = "$args -n 2>&1 $pgpoolLog ";
            } else {
                $args = "$args -n > $pgpoolLog ";
            }
        }

        $ret = execPcp('PCP_START_PGPOOL', $args);
        if (!array_key_exists('SUCCESS', $ret)) {
            $tpl->assign('pgpoolStatus', 'pgpool restart failed.');
            $tpl->assign('pgpoolMessage', $ret);

        } else {
            for ($i = 0; $i < 10; $i++) {
                if (DoesPgpoolPidExist()) {
                    $tpl->assign('pgpoolStatus', 'pgpool restart succeed');
                    break;
                } else {
                    sleep(1);
                }
            }
            if (!DoesPgpoolPidExist()) {
                $tpl->assign('pgpoolStatus', 'pgpool restart failed. pgpool.pid not found');
            }
            $tpl->assign('pgpoolMessage', $ret['SUCCESS']);
        }
        break;

    case 'reload':
        /**
         * reload pgpool
         */
        $args = ' ';
        $ret = execPcp('PCP_RELOAD_PGPOOL', $args);
        break;


    case 'return':
        $ret = execPcp('PCP_ATTACH_NODE', $nodeNumber);
        if (!array_key_exists('SUCCESS', $ret)) {
            $errorCode = 'e1010';
            $tpl->assign('errorCode', $errorCode);
            $tpl->display('error.tpl');
            exit();
        }
        break;

    case 'recovery':
        $ret = execPcp('PCP_RECOVERY_NODE', $nodeNumber);
        if (!array_key_exists('SUCCESS', $ret)) {
            $errorCode = 'e1012';
            $tpl->assign('errorCode', $errorCode);
            $tpl->display('error.tpl');
            exit();
        }
        break;


    case 'detach':
        $ret = execPcp('PCP_DETACH_NODE', $nodeNumber);
        if (!array_key_exists('SUCCESS', $ret)) {
            $errorCode = 'e1007';
            $tpl->assign('errorCode', $errorCode);
            $tpl->display('error.tpl');
            exit();
        }
        break;

    case 'summary':
        $viewPHP = 'innerSummary.php';
        break;

    case 'proc':
        $viewPHP = 'procInfo.php';
        break;

    case 'node':
        $viewPHP = 'nodeStatus.php';
        break;

    case 'log':
        $viewPHP = 'innerLog.php';
        break;
}

if (DoesPgpoolPidExist()) {
    $tpl->assign('pgpoolIsActive', TRUE);
} else {
    $tpl->assign('pgpoolIsActive', FALSE);
}

$tpl->assign('viewPHP', $viewPHP);

if (_PGPOOL2_STATUS_REFRESH_TIME >= 0 ) {
    $refreshTime = _PGPOOL2_STATUS_REFRESH_TIME * 1000;
}

$tpl->assign('pgpoolConf',    _PGPOOL2_CONFIG_FILE);
$tpl->assign('pcpConf',       _PGPOOL2_PASSWORD_FILE);
$tpl->assign('refreshTime',   $refreshTime);
$tpl->assign('msgStopPgpool', $message['msgStopPgpool']);
$tpl->display('status.tpl');

?>
