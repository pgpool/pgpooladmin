<?php

/* vim: set expandtab tabstop=4 shiftwidth=4 softtabstop=4: */

/**
 * Check parameters used in PgpoolAdmin
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

require_once('../version.php');

session_start();

require_once("defaultParameter.php");
require_once('setLang.php');

/* --------------------------------------------------------------------- */
/* Error check                                                           */
/* --------------------------------------------------------------------- */

$error = FALSE;

$action = '';
if (isset($_POST['action'])) {
    $action = $_POST['action'];
}

// check version
if (isset($_POST['version']) && $_POST['version']) {
    $version = $_POST['version'];
}

// check pgpool.conf
if (isset($_POST['pgpool2_config_file']) && $_POST['pgpool2_config_file']) {
    $pgpool2_config_file = $_POST['pgpool2_config_file'];
} else {
    $pgpool2_config_file = _PGPOOL2_CONFIG_FILE;
}

$msgPgpoolConfigFile = '';
if (! @is_file($pgpool2_config_file)) {
    $msgPgpoolConfigFile = 'File not found';
    $error = TRUE;
} else {
    if (!is_readable($pgpool2_config_file)) {
        $msgPgpoolConfigFile = 'Read access denied';
        $error = TRUE;
    }
    if (!is_writable($pgpool2_config_file)) {
        $msgPgpoolConfigFile = 'Write access denied';
        $error = TRUE;
    }
}

// check pcp.conf
if (isset($_POST['password_file']) && $_POST['password_file']) {
    $password_file = $_POST['password_file'];
} else {
    $password_file = _PGPOOL2_PASSWORD_FILE;
}

$msgPasswordFile = '';
if (! @is_file($password_file)) {
    $msgPasswordFile = 'File not found';
    $error = TRUE;
} else {
    if (!is_readable($password_file)) {
        $msgPasswordFile = 'Read access denied';
        $error = TRUE;
    }
    if (!is_writable($password_file)) {
        $msgPasswordFile = 'Write access denied';
        $error = TRUE;
    }
}

// check bin directory
if (isset($_POST['pgpool_command']) && $_POST['pgpool_command']) {
    $pgpool_command = $_POST['pgpool_command'];
} else {
    $pgpool_command = _PGPOOL2_COMMAND;
}

$msgPgpoolCommand = '';
if (! @is_file($pgpool_command)) {
    $msgPgpoolCommand = 'pgpool command not found';
    $error = TRUE;
} elseif (!is_executable($pgpool_command)) {
    $msgPgpoolCommand =  'pgpool command not executable';
    $error = TRUE;
}

// check args of pgpool command
$msgCmdC = '';
$msgCmdLargeD = '';
$msgCmdD = '';
$msgCmdN = '';
$msgCmdM = '';
$msgCmdLargeC = '';

$msgPgpoolLogFile = '';
if (isset($_POST['pgpool_logfile']) && $_POST['pgpool_logfile']) {
    $pgpool_logfile = $_POST['pgpool_logfile'];
} else {
    $pgpool_logfile = _PGPOOL2_LOG_FILE;
}

if ($pgpool_logfile != '' && strpos($pgpool_logfile, '|') !== FALSE) {
    // pipe
    $tmp_str = trim($pgpool_logfile);
    if (($tmp_str[0] != '|') || ($tmp_str[strlen($tmp_str) - 1] == '|')) {
        $msgPgpoolLogFile = 'Directory not found';
        $error = TRUE;
    }

// check log file directory
} elseif (!is_dir(dirname($pgpool_logfile))) {
    $msgPgpoolLogFile = 'Directory not found';
    $error = TRUE;

} elseif (!is_writable(dirname($pgpool_logfile))) {
    $msgPgpoolLogFile = 'Write access denied';
    $error = TRUE;
}

// check pcp parameters
if (isset($_POST['pcp_client_dir']) && $_POST['pcp_client_dir']) {
    $pcp_client_dir = $_POST['pcp_client_dir'];
} else {
    $pcp_client_dir = _PGPOOL2_PCP_DIR;
}

$msgPcpClientDir = '';
if (!is_dir($pcp_client_dir)) {
    $msgPcpClientDir = 'Directory not found';
    $error = TRUE;

} else {
    $commands = getPcpCommands();

    foreach ($commands as $command) {
        $command_fullpath = "{$pcp_client_dir}/{$command}";

        if (! @is_file($command_fullpath)) {
            $msgPcpClientDir = $command . ' command not found';
            $error = TRUE;

        } elseif (!is_executable($command_fullpath)) {
            $msgPcpClientDir = $command . ' not executable';
            $error = TRUE;
        }
    }
}

$msgPcpHostname = '';
if (isset($_POST['pcp_hostname']) && $_POST['pcp_hostname']) {
    $pcp_hostname = $_POST['pcp_hostname'];
} else {
    $pcp_hostname =  _PGPOOL2_PCP_HOSTNAME;
}

$proc_user_info = posix_getpwuid(posix_geteuid());
$pcppass_file = "{$proc_user_info['dir']}/.pcppass";
$msgPcpPassFile = '';
if (3.5 <= $version) {
    if (! is_file($pcppass_file)) {
        $msgPcpPassFile = 'File not found';
    } elseif (fileowner($pcppass_file) != $proc_user_info['uid']) {
        $msgPcpPassFile = 'Invalid owner';
    } elseif (substr(sprintf('%o', fileperms($pcppass_file)), -4) != '0600') {
        $msgPcpPassFile = 'Invalid permission';
    }
}

$msgPcpTimeout = '';
if (isset($_POST['pcp_timeout']) && $_POST['pcp_timeout']) {
    $pcp_timeout= $_POST['pcp_timeout'];
} else {
    $pcp_timeout =  _PGPOOL2_PCP_TIMEOUT;
}

$msgPcpRefreshTime = '';
if (isset($_POST['pcp_refreshTime']) && $_POST['pcp_refreshTime']) {
    $pcp_refreshTime = $_POST['pcp_refreshTime'];
} else {
    $pcp_refreshTime =  _PGPOOL2_STATUS_REFRESH_TIME;
}

$msgPgConnectTimeout = '';
if (isset($_POST['pg_connect_timeout']) && $_POST['pg_connect_timeout']) {
    $pg_connect_timeout = $_POST['pg_connect_timeout'];
} else {
    $pg_connect_timeout =  _PGPOOL2_PG_CONNECT_TIMEOUT;
}

$msgPhpPgsql= '';
if (!extension_loaded('pgsql')){
    $msgPhpPgsql = 'not installed';
    $error = TRUE;
}

/* --------------------------------------------------------------------- */
/* Write pgmt.conf.php                                                   */
/* --------------------------------------------------------------------- */

if ($error || (isset($_POST['submitBack']) && $_POST['submitBack'] != NULL)) {

} else {
    $params['lang']                = $_SESSION['lang'];
    $params['version']             = $_POST['version'];
    $params['pgpool2_config_file'] = $pgpool2_config_file;
    $params['password_file']       = $password_file;
    $params['pcp_client_dir']      = $pcp_client_dir;
    $params['pcp_hostname']        = $pcp_hostname;
    $params['pcp_refreshTime']     = $pcp_refreshTime;
    $params['pg_connect_timeout']  = $pg_connect_timeout;

    $_SESSION['params'] = $params;
}

if (!$error && $action == 'next') {
    $fp = fopen( "../conf/pgmgt.conf.php", "w");

    fputs($fp, "<?php"."\n");

    write($fp, '_PGPOOL2_LANG',               $_SESSION['lang']);
    write($fp, '_PGPOOL2_VERSION',            $_POST['version']);

    write($fp, '_PGPOOL2_CONFIG_FILE',        $_POST['pgpool2_config_file']);
    write($fp, '_PGPOOL2_PASSWORD_FILE',      $_POST['password_file']);
    write($fp, '_PGPOOL2_COMMAND',            $_POST['pgpool_command']);

    write($fp, '_PGPOOL2_CMD_OPTION_C',       (int)isset($_POST['c']));
    write($fp, '_PGPOOL2_CMD_OPTION_LARGE_D', (int)isset($_POST['D']));
    write($fp, '_PGPOOL2_CMD_OPTION_D',       (int)isset($_POST['d']));
    write($fp, '_PGPOOL2_CMD_OPTION_M',       $_POST['m']);
    write($fp, '_PGPOOL2_CMD_OPTION_N',       (int)isset($_POST['n']));
    write($fp, '_PGPOOL2_CMD_OPTION_LARGE_C', (int)isset($_POST['C']));

    write($fp, '_PGPOOL2_LOG_FILE',            $_POST['pgpool_logfile']);
    write($fp, '_PGPOOL2_PCP_DIR',             $_POST['pcp_client_dir']);
    write($fp, '_PGPOOL2_PCP_HOSTNAME',        $_POST['pcp_hostname']);
    write($fp, '_PGPOOL2_PCP_TIMEOUT',         $_POST['pcp_timeout']);
    write($fp, '_PGPOOL2_STATUS_REFRESH_TIME', $_POST['pcp_refreshTime']);
    write($fp, '_PGPOOL2_PG_CONNECT_TIMEOUT', $_POST['pg_connect_timeout']);

    fputs($fp, "?>"."\n");

    fclose($fp);

    header("Location: finish.php");
}

/* --------------------------------------------------------------------- */
/* HTML                                                                  */
/* --------------------------------------------------------------------- */
?>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title><?php echo $message['strParameterCheck']; ?></title>
<link href="../screen.css" rel="stylesheet" type="text/css" />
</head>
  <body>
    <div id="header">
      <h1><img src="../images/logo.gif" alt="pgpoolAdmin" /></h1>
    </div>
      <div id="content">
  <h2>Welcome to pgpool-II Administration Tool</h2>

  <form action="checkParameter.php" method="post" name="CheckPath" id="CheckPath">
    <?php
    if ($error) {
        echo '<input type="hidden" name="action" value="check">';
    } else {
        echo '<input type="hidden" name="action" value="next">';
    }
    ?>

<?php
/* --------------------------------------------------------------------- */
/* Version                                                               */
/* --------------------------------------------------------------------- */
?>
  <h3><?php echo $message['strVersion'] ?></h3>

  <table>
  <tr>
    <th><label><?php echo $message['strVersion'] ?></label></th>
    <td><select name="version" />
        <?php
        foreach (versions() as $v) {
            printf('<option value="%s"%s>%s</optgroup>',
                   $v, ($v == $version) ? ' selected' : NULL, $v);
        }
        ?>
        </select>
    <?php showResult($msgCmdM); ?>
    </td>
  </tr>
  </table>

<?php
/* --------------------------------------------------------------------- */
/* Dependencies                                                          */
/* --------------------------------------------------------------------- */
?>
  <h3><?php echo $message['strDependencies'] ?></h3>
  <table>
  <tr>
    <th><label><?php echo $message['strPgPhp'] ?></label></th>
    <td>
    <?php showResult($msgPhpPgsql); ?>
    </td>
  </tr>
  </table>

<?php
/* --------------------------------------------------------------------- */
/* Config File                                                           */
/* --------------------------------------------------------------------- */
?>
  <h3><?php echo $message['strParameterCheck'] ?></h3>

  <table>
  <tr>
    <th><label><?php echo $message['strPgConfFile'] ?></label></th>
    <td><input name="pgpool2_config_file" type="text" value="<?php echo $pgpool2_config_file?>" size="50" />
    <?php showResult($msgPgpoolConfigFile); ?>
    </td>
  </tr>
  <tr>
    <th><label><?php echo $message['strPasswordFile'] ?></label></th>
    <td><input name="password_file" type="text" value="<?php echo $password_file ?>" size="50" />
    <?php showResult($msgPasswordFile); ?>
    </td>
  </tr>
  <tr>
    <th><label><?php echo $message['strPgpoolCommand'] ?></label></th>
    <td><input name="pgpool_command" type="text" value="<?php echo $pgpool_command ?>" size="50" />
    <?php showResult($msgPgpoolCommand); ?>
    </td>
  </tr>
  </table>

<?php
/* --------------------------------------------------------------------- */
/* Command options                                                       */
/* --------------------------------------------------------------------- */
?>
  <h3><?php echo $message['strPgpoolCommandOption'] ?></h3>

  <table>
  <tr>
    <th><label><?php echo $message['strCmdC'] ?> (-c)</label></th>
    <td><input type="checkbox" name="c" />
    <?php showResult($msgCmdC); ?>
    </td>
  </tr>
  <tr>
    <th><label><?php echo $message['strCmdLargeD'] ?> (-D)</label></th>
    <td><input type="checkbox" name="D" />
    <?php showResult($msgCmdLargeD); ?>
    </td>
  </tr>
  <tr>
    <th><label><?php echo $message['strCmdN'] ?> (-n)</label></th>
    <td><input type="checkbox" name="n" />
    <?php showResult($msgCmdN); ?>
    </td>
  </tr>
  <tr>
    <th><label><?php echo $message['strCmdLargeC'] ?> (-C)</label></th>
    <td><input type="checkbox" name="D" />
    <?php showResult($msgCmdLargeC); ?>
    </td>
  </tr>
  <tr>
    <th><label><?php echo $message['strCmdD'] ?> (-d)</label></th>
    <td><input type="checkbox" name="d" />
    <?php showResult($msgCmdD); ?>
    </td>
  </tr>
  <tr>
    <th><label><?php echo $message['strCmdM'] ?> (-m)</label></th>
    <td><select  name="m" />
          <option value="s" selected="selected">smart</optgroup>
          <option value="f">fast</optgroup>
          <option value="i">immediate</optgroup>
        </select>
    <?php showResult($msgCmdM); ?>
    </td>
  </tr>
  <tr>
    <th><label><?php echo $message['strPgpoolLogFile'] ?></label></th>
    <td><input name="pgpool_logfile" type="text" value="<?php echo $pgpool_logfile ?>" size="50" />
    <?php showResult($msgPgpoolLogFile); ?>
    </td>
  </tr>

  <tr>
    <th><label><?php echo $message['strPcpDir'] ?></label></th>
    <td><input name="pcp_client_dir" type="text" value="<?php echo $pcp_client_dir ?>" size="50" />
    <?php showResult($msgPcpClientDir); ?>
    </td>
  </tr>
  <tr>
    <th><label><?php echo $message['strPcpHostName'] ?></label></th>
    <td><input name="pcp_hostname" type="text" value="<?php echo $pcp_hostname ?>" size="50" />
    <?php showResult($msgPcpHostname); ?>
    </td>
  </tr>
  <tr id="tr_pcppass">
    <th><label>.pcppass [V3.5 - ]</label></th>
    <td><?php echo $pcppass_file; ?>
    <?php showResult($msgPcpPassFile); ?>
  <tr>
    <th><label><?php echo $message['strPcpTimeout'] ?></label></th>
    <td><input name="pcp_timeout" type="text" value="<?php echo $pcp_timeout?>" size="50" />
    <?php showResult($msgPcpTimeout); ?>
    </td>
  </tr>
  <tr>
    <th><label><?php echo $message['strPcpRefreshTime'] ?></label></th>
    <td><input name="pcp_refreshTime" type="text" value="<?php echo $pcp_refreshTime ?>" size="50" />
    <?php showResult($msgPcpRefreshTime); ?>
    </td>
  </tr>
  <tr>
	  <th><label><?php echo $message['strPgConnectTimeout'] ?></label></th>
	  <td><input name="pg_connect_timeout" type="text" value="<?php echo $pg_connect_timeout ?>" size="50" />
		  <?php showResult($msgPgConnectTimeout); ?>
	  </td>
  </tr>
</table>

<p>
<?php
if ($error) {
    echo '<input type="submit" value="' . $message['strCheck'] . '" />';
}
else {
    echo '<input type="submit" value="' . $message['strNext'] . '" />';
}
?>
</p>
</form>
</div>
    <div id="footer">
      <address>Version <?php echo $version;?><br />
      Copyright &copy; 2006 - <?php echo date('Y'); ?> <a href="http://pgpool.projects.postgresql.org/">pgpool Global Development Group</a>. All rights reserved.</address>
    </div>
  </body>
</html>

<?php

/* --------------------------------------------------------------------- */
/* Function                                                              */
/* --------------------------------------------------------------------- */

function versions()
{
    return array('4.0', '3.7', '3.6', '3.5', '3.4', '3.3', '3.2', '3.1', '3.0',
                 '2.3', '2.2', '2.1', '2.0');
}

function write($fp, $defname, $val)
{
    fputs($fp, "define('{$defname}', '{$val}');\n");
}

function showResult($msg)
{
    if ($msg != '') {
        echo '<br />' . $msg;
        echo '</td><td><img src="images/ng.gif" alt="ng" />';
    } else {
        echo '</td><td><img src="images/ok.gif" alt="ok" />';
    }
}

/**
 * Get pcp commands in specified version
 */
function getPcpCommands()
{
    global $version;

    $commands = array();
    $commands[] = 'pcp_attach_node';
    $commands[] = 'pcp_node_count';
    $commands[] = 'pcp_proc_info';
    $commands[] = 'pcp_recovery_node';
    $commands[] = 'pcp_detach_node';
    $commands[] = 'pcp_node_info';
    $commands[] = 'pcp_proc_count';
    $commands[] = 'pcp_stop_pgpool';

    // 3.3 -
    if (3.3 <= $version) {
        $commands[] = 'pcp_watchdog_info';
    }

    // 3.1 -
    if (3.1 <= $version) {
        $commands[] = 'pcp_pool_status';
        $commands[] = 'pcp_promote_node';
    }

    // - 3.4
    if ($version <= 3.4) {
        $commands[] = 'pcp_systemdb_info';
    }

    return $commands;
}

