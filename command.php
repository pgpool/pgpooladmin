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
 * @copyright  2003-2009 PgPool Global Development Group
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
function execPcp($command, $num = '')
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

    $args = " " . $param['pcp_timeout'] .
            " " . $param['hostname'] .
            " " . $param['pcp_port'] .
            " ". $_SESSION[SESSION_LOGIN_USER] .
            " '" . $_SESSION[SESSION_LOGIN_USER_PASSWORD] . "' " .
            $num;

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
            $configOption = ' -f ' . _PGPOOL2_CONFIG_FILE .
                            ' -F ' . _PGPOOL2_PASSWORD_FILE;

            if(isPipe($num)) {
                $cmdOption = $configOption . $num . ' > /dev/null &';
            } else {
                $cmdOption = $configOption . $num . ' 2>&1 &';
            }

            /* we should not check pid file here.
             * let pgpool handle bogus pid file
             * if(DoesPgpoolPidExist()) {
             *   return array('FAIL'=> '');
             * }
             */
            $cmd = _PGPOOL2_COMMAND . $cmdOption;
            $ret = exec($cmd, $output, $return_var);
            if ($return_var == 0) {
                return array($pcpStatus[$return_var] => $output);
            } else {
                return array('FAIL' => $output);
            }
            break;

        case 'PCP_RELOAD_PGPOOL':
            $cmdOption = $num;
            $cmdOption = $cmdOption .
                         ' -f ' . _PGPOOL2_CONFIG_FILE .
                         ' -F ' . _PGPOOL2_PASSWORD_FILE . ' reload';
            $cmd = _PGPOOL2_COMMAND . $cmdOption . ' 2>&1 &';
            $ret = exec($cmd, $output, $return_var);
            if ($return_var == 0) {
                return array($pcpStatus[$return_var] => $output);
            } else {
                return array('FAIL' => $output);
            }
            break;

        case 'PCP_STOP_PGPOOL':
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
    $params = readConfigParams(array('pcp_port', 'pcp_timeout'));
    return $params;
}
?>
