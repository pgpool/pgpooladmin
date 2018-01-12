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
 * @copyright  2003-2015 PgPool Global Development Group
 * @version    SVN: $Id$
 */

require_once('common.php');
require_once('command.php');

/* --------------------------------------------------------------------- */
/* Status.php                                                            */
/* --------------------------------------------------------------------- */

// Check login status
if (!isset($_SESSION[SESSION_LOGIN_USER])) {
    header('Location: login.php');
    exit();
}

$is_pgpool_running = DoesPgpoolPidExist();

// Do action
$nodeNumber = (isset($_POST['nodeNumber'])) ? $_POST['nodeNumber'] : -1;
$action     = (isset($_POST['action'])) ?  $_POST['action'] : FALSE;
$viewPHP    = _doAction($action, $nodeNumber);

// Set vars
setNodeInfoFromConf();
$tpl->assign('action',         $action);
$tpl->assign('pgpoolIsRunning', $is_pgpool_running);
$tpl->assign('viewPHP',        $viewPHP);
$tpl->assign('help',           basename( __FILE__, '.php'));
$tpl->assign('pgpoolConf',     _PGPOOL2_CONFIG_FILE);
$tpl->assign('pcpConf',        _PGPOOL2_PASSWORD_FILE);
$tpl->assign('refreshTime',    (0 <= _PGPOOL2_STATUS_REFRESH_TIME) ?
                               _PGPOOL2_STATUS_REFRESH_TIME * 1000 : 5000);
$tpl->assign('refreshTimeLog', (0 <= REFRESH_LOG_SECONDS) ?
                               REFRESH_LOG_SECONDS * 1000 : 5000);
$tpl->assign('useSyslog',      useSyslog());
$tpl->assign('pipe',           (isPipe(_PGPOOL2_LOG_FILE)) ? 1 : 0);
$tpl->assign('msgStopPgpool',  $message['msgStopPgpool']);
$tpl->assign('login_user',     $_SESSION[SESSION_LOGIN_USER]);
$tpl->assign('is_superuser',   (isset($_SESSION[SESSION_IS_SUPER_USER])) ? 
    $_SESSION[SESSION_IS_SUPER_USER] : isSuperUser($_SESSION[SESSION_LOGIN_USER]));

// Set params
$configValue = readConfigParams();
$tpl->assign('params', $configValue);

// Set pgpool command option
$tpl->assign('c', _PGPOOL2_CMD_OPTION_C);
$tpl->assign('D', _PGPOOL2_CMD_OPTION_LARGE_D);
$tpl->assign('d', _PGPOOL2_CMD_OPTION_D);
$tpl->assign('m', _PGPOOL2_CMD_OPTION_M);
$tpl->assign('n', _PGPOOL2_CMD_OPTION_N);
$tpl->assign('C', _PGPOOL2_CMD_OPTION_LARGE_C);

// Display
$tpl->display('status.tpl');

/* --------------------------------------------------------------------- */
/* Functions                                                             */
/* --------------------------------------------------------------------- */

/** Execute a command */
function _doAction($action, $nodeNumber)
{
    global $tpl;

    $viewPHP = 'nodeStatus.php';
    $tpl->assign('pgpoolStatus',   NULL);
    $tpl->assign('pgpoolMessage',  NULL);

    switch ($action) {
        /* --------------------------------------------------------------------- */
        /* pgpool                                                                */
        /* --------------------------------------------------------------------- */

        case 'startPgpool':
            if (_startPgpool()) {
                header("Location: " . $_SERVER['PHP_SELF']);
            }
            break;

        case 'stopPgpool':
            if (_stopPgpool()) {
                header("Location: " . $_SERVER['PHP_SELF']);
            }
            break;

        case 'restartPgpool':
            if (_restartPgpool()) {
                header("Location: " . $_SERVER['PHP_SELF']);
            }
            break;

        case 'reloadPgpool':
            $args = ' ';
            $result = execPcp('PCP_RELOAD_PGPOOL', $args);
            break;

        /* --------------------------------------------------------------------- */
        /* other command                                                         */
        /* --------------------------------------------------------------------- */

        case 'return':
            if (_execPcp('PCP_ATTACH_NODE', array('n' => $nodeNumber), 'e1010') === FALSE) { exit(); }
            break;

        case 'recovery':
            if (_execPcp('PCP_RECOVERY_NODE', array('n' => $nodeNumber), 'e1012') === FALSE) { exit(); }
            break;

        case 'detach':
            if (_execPcp('PCP_DETACH_NODE', array('n' => $nodeNumber), 'e1007') === FALSE) { exit(); }
            break;

        case 'promote':
            if (_execPcp('PCP_PROMOTE_NODE', array('n' => $nodeNumber), 'e1007') === FALSE) { exit(); }
            break;

        /* --------------------------------------------------------------------- */
        /* PostgreSQL                                                            */
        /* --------------------------------------------------------------------- */

        case 'startPgsql':
            // ...
            break;

        case 'stopPgsql':
            _doPgCtl($nodeNumber, 'stop');
            break;

        case 'restartPgsql':
            _doPgCtl($nodeNumber, 'restart');
            break;

        case 'reloadPgsql':
            $result = _doPgCtl($nodeNumber, 'reload');
            $tpl->assign('status', ($result) ? 'success' : 'fail');
            break;

        case 'addBackend':
            $result = _addNewBackend();
            $tpl->assign('status', ($result) ? 'success' : 'fail');
            break;

        case 'removeBackend':
            $result = _removeBackend();
            $tpl->assign('status', ($result) ? 'success' : 'fail');
            break;

        /* --------------------------------------------------------------------- */
        /* other                                                                 */
        /* --------------------------------------------------------------------- */

        case 'summary':
            $viewPHP = 'innerSummary.php';
            break;

        case 'proc':
            $viewPHP = 'procInfo.php';
            break;

        case 'watchdog':
            $viewPHP = 'innerWatchdog.php';
            break;

        case 'node':
            $viewPHP = 'nodeStatus.php';
            break;

        case 'log':
            $viewPHP = 'innerLog.php';
            break;
    }

    return $viewPHP;
}

/** Set node info from pgpool.conf when pgpool isn't running */
function setNodeInfoFromConf()
{
    global $tpl;
    global $is_pgpool_running;

    if (! $is_pgpool_running) {
        $nodeInfo = array();

        $configValue = readConfigParams(array('backend_hostname', 'backend_port'));
        if (isset($configValue['backend_hostname'])) {
            foreach ($configValue['backend_hostname'] as $i => $backend_hostname) {
                $nodeInfo[$i]['backend_hostname'] = $backend_hostname;
                $nodeInfo[$i]['backend_port']     = $configValue['backend_port'][$i];
                $nodeInfo[$i]['is_active']        = NodeActive($i);
            }
        }
        $tpl->assign('nodeInfo', $nodeInfo);
    }

    $configValue = readConfigParams(array('backend_hostname'));
    $tpl->assign('next_node_num', (isset($configValue['backend_hostname'])) ?
                                  max(array_keys($configValue['backend_hostname'])) + 1 : 0);
}

/** Modify start options */
function _setStartArgs()
{
    $args = array();

    $args[] = "-f ". _PGPOOL2_CONFIG_FILE;
    $args[] = "-F ".  _PGPOOL2_PASSWORD_FILE;

    foreach ($_POST as $key => $value) {
        switch ($key) {
        case 'c':
        case 'D':
        case 'd':
        case 'C':
        case 'n':
            if ($value == 'on') {
                $args[] = "-{$key}";
            }

            if ($key == 'n') {
                $pgpoolLog = _PGPOOL2_LOG_FILE;
                if ($pgpoolLog == '') {
                    $logDir = readLogDir();
                    $pgpoolLog = "$logDir/pgpool.log";
                }
                if (isPipe($pgpoolLog)) {
                    $args[] = "2>&1 > $pgpoolLog &";
                } else {
                    $args[] = "> $pgpoolLog 2>&1 &";
                }
            }
            break;
        }
    }


    $args = ' ' . implode(' ', $args);
    return $args;
}

/** Wait to find pgpool.pid */
function _waitForPidFile()
{
    for ($i = 0; $i < PGPOOL_WAIT_SECONDS; $i++) {
        if (DoesPgpoolPidExist()) {
            return TRUE;
        } else {
            sleep(1);
        }
    }
    return FALSE;
}

/** Wait that pgpool.pid disappears */
function _waitForNoPidFile()
{
    for ($i = 0; $i < PGPOOL_WAIT_SECONDS; $i++) {
        if (DoesPgpoolPidExist()) {
            sleep(1);
        } else {
            return TRUE;
        }
    }
    return FALSE;
}

/** Start pgpool */
function _startPgpool()
{
    global $tpl;
    $rtn = FALSE;

    $result = execPcp('PCP_START_PGPOOL');
    if (! array_key_exists('SUCCESS', $result)) {
        $pgpoolStatus = 'pgpool start failed.';
        $pgpoolMessage = $result;

    } else {
        if (_waitForPidFile()) {
            $pgpoolStatus = 'pgpool start succeed';
            $rtn = TRUE;
        } else {
            $pgpoolStatus = 'pgpool start failed. pgpool.pid not found';
        }
        $pgpoolMessage = $result['SUCCESS'];
    }

    $tpl->assign('pgpoolStatus', $pgpoolStatus);
    $tpl->assign('pgpoolMessage', $pgpoolMessage);

    return $rtn;
}

/** Stop pgpool */
function _stopPgpool()
{
    global $_POST;
    global $tpl;
    $rtn = FALSE;

    $m = $_POST['stop_mode'];

    $result = execPcp('PCP_STOP_PGPOOL', $m);
    if (!array_key_exists('SUCCESS', $result)) {
        $errorCode = 'e1006';
        $tpl->assign('errorCode', $errorCode);
        $tpl->display('error.tpl');
        exit();

    } else {
        if (_waitForNoPidFile()) {
            $pgpoolStatus = 'pgpool stop succeed';
            $rtn = TRUE;
        } else {
            $pgpoolStatus = 'pgpool stop failed. pgpool.pid exists.';
        }
        $tpl->assign('pgpoolStatus', $pgpoolStatus);
    }

    return $rtn;
}

/** Restart pgpool */
function _restartPgpool()
{
    global $_POST;
    global $tpl;
    $rtn = FALSE;

    // Stop pgpool
    $m = $_POST['stop_mode'];

    $result = execPcp('PCP_STOP_PGPOOL', $m);
    if (!array_key_exists('SUCCESS', $result)) {
        $errorCode = 'e1006';
        $tpl->assign('errorCode', $errorCode);
        $tpl->display('error.tpl');
        exit();
    }

    if (_waitForNoPidFile()) {
        // Start pgpool
        $args = _setStartArgs();
        $result = execPcp('PCP_START_PGPOOL', $args);
        if (!array_key_exists('SUCCESS', $result)) {
            $pgpoolStatus = 'pgpool restart failed.';
            $pgpoolMessage = $result;

        } else {
            if (_waitForPidFile()) {
                $pgpoolStatus = 'pgpool restart succeed';
                $rtn = TRUE;
            } else {
                $pgpoolStatus = 'pgpool restart failed. pgpool.pid not found';
            }
            $pgpoolMessage = $result['SUCCESS'];
        }

    } else {
        $pgpoolStatus = 'pgpool restart failed. pgpool.pid exists.';
    }

    $tpl->assign('pgpoolStatus', $pgpoolStatus);
    $tpl->assign('pgpoolMessage', $pgpoolMessage);

    return $rtn;
}

/** Execute PCP command with node number */
function _execPcp($pcp_command, $nodeNumber, $errorCode)
{
    global $tpl;

    $result = execPcp($pcp_command, $nodeNumber);

    if (!array_key_exists('SUCCESS', $result)) {
        $tpl->assign('errorCode', $errorCode);
        $tpl->display('error.tpl');
        return FALSE;
    }

    return TRUE;
}

/** Add a new backend and reload conf */
function _addNewBackend()
{
    global $is_pgpool_running;
    global $_POST;

    // Check
    if ($_POST['backend_hostname'][0] == NULL || $_POST['backend_port'][0] == NULL ||
        $_POST['backend_weight'][0] == NULL)
    {
        return FALSE;
    }

    // Get next nodeNumber
    $configValue = readConfigParams(array('backend_hostname'));
    $i = (isset($configValue['backend_hostname'])) ?
         max(array_keys($configValue['backend_hostname'])) + 1 : 0;

    // add
    $lines[] = "backend_hostname{$i} = '{$_POST['backend_hostname'][0]}'\n";
    $lines[] = "backend_port{$i} = {$_POST['backend_port'][0]}\n";
    $lines[] = "backend_weight{$i} = {$_POST['backend_weight'][0]}\n";
    $lines[] = "backend_data_directory{$i} = '{$_POST['backend_data_directory'][0]}'\n";
    if (paramExists('backend_flag')) {
        $lines[] = "backend_flag{$i}= '{$_POST['backend_flag'][0]}'\n";
    }

    // Write pgpool.conf
    $outfp = fopen(_PGPOOL2_CONFIG_FILE, 'a');
    if (! $outfp) { return FALSE; }
    foreach ($lines as $line) {
        if (fputs($outfp, $line) === FALSE) {
            return FALSE;
        }
    }
    fclose($outfp);

    // Reload pgpool
    $result = TRUE;
    if (isset($_POST['reload_ok']) && $is_pgpool_running) {
        $result = execPcp('PCP_RELOAD_PGPOOL', NO_ARGS);
    }

    return $result;
}

/** Remove a backend and reload conf */
function _removeBackend()
{
    global $is_pgpool_running;
    global $_POST;

    if (!isset($_POST['nodeNumber'])) { return FALSE; }
    $nodeNumber = $_POST['nodeNumber'];

    // Read execept backend info of node $nodeNumber
    $lines_to_write = array();
    $fd = fopen(_PGPOOL2_CONFIG_FILE, 'r');
    if (! $fd) { return FALSE; }
    while (! feof($fd)) {
        $line = fgets($fd);

        if (strpos($line, "backend_hostname") !== FALSE ||
            strpos($line, "backend_port") !== FALSE ||
            strpos($line, "backend_weight") !== FALSE ||
            strpos($line, "backend_data_directory") !== FALSE ||
            strpos($line, "backend_flag") !== FALSE)
        {
            continue;
        }
        $lines_to_write[] = $line;
    }
    fclose($fd);


    // Get all the current backends' info
    $params = readConfigParams(array('backend_hostname', 'backend_port', 'backend_weight',
                                     'backend_data_directory', 'backend_flag'));
    $i = 0;
    foreach ($params['backend_hostname'] as $old_i => $arr) {
        if ($old_i == $nodeNumber) { continue; }

        $lines_to_write[] = "backend_hostname{$i} = '{$params['backend_hostname'][$old_i]}'\n";
        $lines_to_write[] = "backend_port{$i} = {$params['backend_port'][$old_i]}\n";
        $lines_to_write[] = "backend_weight{$i} = {$params['backend_weight'][$old_i]}\n";
        $lines_to_write[] = "backend_data_directory{$i} = '{$params['backend_data_directory'][$old_i]}'\n";
        if (paramExists('backend_flag')) {
            $lines_to_write[] = "backend_flag{$i} = '{$params['backend_flag'][$old_i]}'\n";
        }
        $i++;
    }

    // Write editted lines
    $fd = fopen(_PGPOOL2_CONFIG_FILE, 'w');
    if (! $fd) { return FALSE; }
    foreach ($lines_to_write as $line) {
        if (fputs($fd, $line) === FALSE) {
            return FALSE;
        }
    }
    fclose($fd);

    // Reload pgpool
    $result = TRUE;
    if ($is_pgpool_running) {
        $result = execPcp('PCP_RELOAD_PGPOOL', NO_ARGS);
    }
    return $result;
}

/** Execute pg_ctl through pgpool_pgctl() */
function _doPgCtl($nodeNumber, $pg_ctl_action)
{
    global $_POST;

    if (isSuperUser($_SESSION[SESSION_LOGIN_USER]) == FALSE) { return FALSE; }

    $params = readConfigParams(array(
        'backend_hostname', 'backend_port', 'backend_weight',
    ));
    $conn = openDBConnection(array(
        'host'     => $params['backend_hostname'][$nodeNumber],
        'port'     => $params['backend_port'][$nodeNumber],
        'dbname'   => 'template1',
        'user'     => $_SESSION[SESSION_LOGIN_USER],
        'password' => $_SESSION[SESSION_LOGIN_USER_PASSWORD],
        'connect_timeout' => _PGPOOL2_CONNECT_TIMEOUT,
    ));

    if ($conn == FALSE) {
        closeDBConnection($conn);
        return FALSE;
    }
    $query = sprintf("SELECT pgpool_pgctl('%s', '%s')",
                     $pg_ctl_action,
                     (isset($_POST['stop_mode'])) ? $_POST['stop_mode'] : NULL);
    $result = execQuery($conn, $query);

    closeDBConnection($conn);

    return $result;
}
