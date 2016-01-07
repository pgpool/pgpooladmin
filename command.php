<?php

/* vim: set expandtab tabstop=4 shiftwidth=4 softtabstop=4: */

/**
 * Command of PCP
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
 * @copyright  2003-2016 PgPool Global Development Group
 * @version    CVS: $Id$
 */

require_once('common.php');

/**
 * Execute pcp command
 *
 * @param string $command
 * @param srgs $num
 * @return array
 */
function execPcp($command, $extra_args = array())
{
    $pcpStatus = array (
        '0'   => 'SUCCESS',
        '1'   => 'UNKNOWNERR',
        '2'   => 'EOFERR',
        '3'   => 'NOMEMERR',
        '4'   => 'READERR',
        '5'   => 'WRITEERR',
        '6'   => 'TIMEOUTERR',
        '7'   => 'INVALERR',
        '8'   => 'CONNERR',
        '9'   => 'NOCONNERR',
        '10'  => 'SOCKERR',
        '11'  => 'HOSTERR',
        '12'  => 'BACKENDERR',
        '13'  => 'AUTHERR',
        '127' => 'COMMANDERROR'
    );

    $param = readPcpInfo();
    $param['hostname'] = _PGPOOL2_PCP_HOSTNAME;

    if (3.5 <= _PGPOOL2_VERSION) {
        // Check /home/apache/.pcppass (If error, exit here)
        checkPcppass();

        $args = sprintf(' -w -h %s -p %d -U %s',
            $param['hostname'], $param['pcp_port'],
            $_SESSION[SESSION_LOGIN_USER]
        );

        foreach ($extra_args as $arg_name => $val) {
            $args .= " -{$arg_name} {$val}";
        }

    } elseif ($param) {
        $args = " " . PCP_TIMEOUT.
                " " . $param['hostname'] .
                " " . $param['pcp_port'] .
                " ". $_SESSION[SESSION_LOGIN_USER] .
                " '" . $_SESSION[SESSION_LOGIN_USER_PASSWORD] . "' " .
                implode($extra_args, ' ');
    }

    switch ($command) {
        case 'PCP_NODE_COUNT':
            $cmd = _PGPOOL2_PCP_DIR . '/pcp_node_count' . $args;
            $ret = exec($cmd, $output, $return_var);
            break;

        case 'PCP_NODE_INFO':
            $cmd = _PGPOOL2_PCP_DIR . '/pcp_node_info' . $args;
            $ret = exec($cmd, $output, $return_var);
            break;

        case 'PCP_ATTACH_NODE':
            $cmd = _PGPOOL2_PCP_DIR . '/pcp_attach_node' . $args;
            $ret = exec($cmd, $output, $return_var);
            break;

        case 'PCP_DETACH_NODE':
            $cmd = _PGPOOL2_PCP_DIR . '/pcp_detach_node' . $args;
            $ret = exec($cmd, $output, $return_var);
            break;

        case 'PCP_PROC_COUNT':
            $cmd = _PGPOOL2_PCP_DIR . '/pcp_proc_count' . $args;
            $ret = exec($cmd, $output, $return_var);
            break;

        case 'PCP_PROC_INFO':
            $cmd = _PGPOOL2_PCP_DIR . '/pcp_proc_info' . $args;
            $ret = exec($cmd, $output, $return_var);
            $ret = $output;
            break;

        case 'PCP_START_PGPOOL':
            $args = _setStartArgs();
            $cmd = _PGPOOL2_COMMAND . $args;
            $ret = exec($cmd, $output, $return_var);
            if ($return_var == 0) {
                return array($pcpStatus[$return_var] => $output);
            } else {
                return array('FAIL' => $output);
            }
            break;

        case 'PCP_RELOAD_PGPOOL':
            $args = _setStartArgs();
            $cmd = _PGPOOL2_COMMAND . $args. ' reload 2>&1 &';
            $ret = exec($cmd, $output, $return_var);
            if ($return_var == 0) {
                return array($pcpStatus[$return_var] => $output);
            } else {
                return array('FAIL' => $output);
            }
            break;

        case 'PCP_STOP_PGPOOL':
            $args .= " {$_POST['stop_mode']}";
            $cmd = _PGPOOL2_PCP_DIR . '/pcp_stop_pgpool' . $args;
            $ret = exec($cmd, $output, $return_var);
            break;

        case 'PCP_PROMOTE_NODE':
            // -g option means that standby doesn't become primary
            // untill all connection get closed.
            $cmd = _PGPOOL2_PCP_DIR . '/pcp_promote_node' .' -g '. $args;
            $ret = exec($cmd, $output, $return_var);
            break;

        case 'PCP_RECOVERY_NODE':
            $cmd = _PGPOOL2_PCP_DIR . '/pcp_recovery_node' . $args;
            $ret = exec($cmd, $output, $return_var);
            break;

        case 'PCP_WATCHDOG_INFO':
            $cmd = _PGPOOL2_PCP_DIR . '/pcp_watchdog_info' . $args;
            $ret = exec($cmd, $output, $return_var);
            if (3.5 <= _PGPOOL2_VERSION) {
                $ret = $output[2];
            }
            break;

        default:
            return array($pspStatus[1] => $pspStatus[1]);
    }

    return array($pcpStatus[$return_var] => $ret);
}

/**
 * Read parameter of pcp_port and pcp_timeout from pgpool.conf
 *
 * @return array
 */
function readPcpInfo()
{
    $params = readConfigParams(array('pcp_port'));
    return $params;
}

/** Get node count */
function getNodeCount()
{
    global $tpl;

    $result = execPcp('PCP_NODE_COUNT');

    if (!array_key_exists('SUCCESS', $result)) {
        $errorCode = 'e1002';
        $tpl->assign('errorCode', $errorCode);
        $tpl->display('innerError.tpl');
        exit();
    }

    return $result['SUCCESS'];
}

/** Get info of the specified node */
function getNodeInfo($i)
{
    global $tpl;

    // execute "pcp_node_info" command
    $result = execPcp('PCP_NODE_INFO', array('n' => $i));

    if (!array_key_exists('SUCCESS', $result)) {
        $tpl->assign('errorCode', 'e1003');
        $tpl->assign('result', $result);
        $tpl->display('innerError.tpl');
        exit();
    }

    $arr = explode(" ", $result['SUCCESS']);
    $rtn['hostname'] = $arr[0];
    $rtn['port']     = $arr[1];
    $rtn['status']   = $arr[2];
    $rtn['weight']   = sprintf('%.3f', $arr[3]);

    return $rtn;
}

/** Get the watchdog information of thet specified other pgpool
 *  If $i is omitted one's own watchdog information is returned.
 */
function getWatchdogInfo($i = '')
{
    global $tpl, $g_watchdog_status_str_arr;

    $result = execPcp('PCP_WATCHDOG_INFO',
        (3.5 <= _PGPOOL2_VERSION) ? array('n' => $i) : array($i)
    );

    if (! array_key_exists('SUCCESS', $result)) {
        $errorCode = 'e1013';
        $tpl->assign('errorCode', $errorCode);
        $tpl->display('innerError.tpl');
        exit();
    }

    $arr = explode(' ', $result['SUCCESS']);

    if (3.5 <= _PGPOOL2_VERSION) {
        // ex.) Linux_dhcp-177-180_9999 133.137.177.180 9999 9000 4 MASTER
        $rtn['hostname']    = $arr[1];
        $rtn['pgpool_port'] = $arr[2];
        $rtn['wd_port']     = $arr[3];
        $rtn['status']      = $arr[4];
        $rtn['status_str']  = $arr[5];

    } else {
        // ex.) 133.137.177.180 9999 9000 3
        $rtn['hostname']    = $arr[0];
        $rtn['pgpool_port'] = $arr[1];
        $rtn['wd_port']     = $arr[2];
        $rtn['status']      = $arr[3];
        $rtn['status_str']  = $g_watchdog_status_str_arr[$rtn['status']];
    }
    return $rtn;
}

function checkPcppass()
{
    global $message, $tpl;

    $proc_user_info = posix_getpwuid(posix_geteuid());
    $pcppass_file = "{$proc_user_info['dir']}/.pcppass";

    $detail = NULL;
    if (! is_file($pcppass_file)) {
        $detail = $message['errFileNotFound'];
    } elseif (fileowner($pcppass_file) != $proc_user_info['uid']) {
        $detail = $message['errInvalidOwner'];
    } elseif (substr(sprintf('%o', fileperms($pcppass_file)), -4) != '0600') {
        $detail = $message['errInvalidPermission'];
    }

    if ($detail) {
        $tpl->assign('errorCode', 'e1014');
        $tpl->assign('detail', $detail);
        $tpl->display('innerError.tpl');
        exit();
    }
}
