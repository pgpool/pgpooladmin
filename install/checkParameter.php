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
 * @copyright  2003-2007 PgPool Global Development Group
 * @version    CVS: $Id$
 */

require_once('../version.php');

session_start();

require("defaultParameter.php");
require_once('setLang.php');

$error = false;

$action = '';
if(isset($_POST['action'])) {
    $action = $_POST['action'];
}

$pgpool2_config_file = $_POST['pgpool2_config_file'];
if( !$pgpool2_config_file)  {
    $pgpool2_config_file = _PGPOOL2_CONFIG_FILE;
}
if(!@is_file($pgpool2_config_file)) {
    $msgPgpoolConfigFile = 'No file found';
    $error = true;
}
else {
    if(!is_readable($pgpool2_config_file)) {
        $msgPgpoolConfigFile = 'Read access denied';
        $error = true;
    }
    if(!is_writable($pgpool2_config_file)) {
        $msgPgpoolConfigFile = 'Write access denied';
        $error = true;
    }
}

$password_file = $_POST['password_file'];
if( !$password_file)  {
    $password_file = _PGPOOL2_PASSWORD_FILE;
}
if(!@is_file($password_file)) {
    $msgPasswordFile = 'No file found';
        $error = true;
}
else {
    if(!is_readable($password_file)) {
        $msgPasswordFile = 'Read access denied';
        $error = true;
    }
    if(!is_writable($password_file)) {
        $msgPasswordFile = 'Write access denied';
        $error = true;
    }
}

$pgpool_command = $_POST['pgpool_command'];
if( !$pgpool_command)  {
    $pgpool_command = _PGPOOL2_COMMAND;
}
if(!@is_file($pgpool_command)) {
    $msgPgpoolCommand = 'Pgpool not found';
        $error = true;
}
if(!is_executable($pgpool_command)) {
    $msgPgpoolCommand =  'Pgppol command can\'t excutable';
    $error = true;
}

$pgpool_logfile = $_POST['pgpool_logfile'];
if( !$pgpool_logfile)  {
    $pgpool_logfile = _PGPOOL2_LOG_FILE;
}
if(!is_dir(dirname($pgpool_logfile))) {
    $msgPgpoolLogFile = 'No Directory found';
    $error = true;
}
else {
    if(!is_writable(dirname($pgpool_logfile))) {
        $msgPgpoolLogFile = 'Write access denied';
        $error = true;
    }
}

$pcp_client_dir = $_POST['pcp_client_dir'];
if( !$pcp_client_dir)  {
    $pcp_client_dir = _PGPOOL2_PCP_DIR;
}
if(!is_dir($pcp_client_dir)) {
    $msgPcpClientDir = 'Directory not found';
        $error = true;
}
else {
    $command = array('pcp_attach_node',
                            'pcp_detach_node',
                            'pcp_node_count',
                            'pcp_node_info',
                            'pcp_proc_count',
                            'pcp_proc_info',
                            'pcp_stop_pgpool',
                            'pcp_systemdb_info');
    
    for($i=0; $i<count($command); $i++) {
        if(!is_executable($pcp_client_dir . "/" . $command[$i] )) {
            $msgPcpClientDir = $command[$i] . ' can\'t excutable';
        $error = true;
        }
    }
}

$pcp_hostname = $_POST['pcp_hostname'];
if(!$pcp_hostname) {
    $pcp_hostname =  _PGPOOL2_PCP_HOSTNAME;
    $msgPcpHostname = '';
}

$pcp_refreshTime = $_POST['pcp_refreshTime'];
if(!$pcp_refreshTime) {
    $pcp_refreshTime =  _PGPOOL2_STATUS_REFRESH_TIME;
    $msgPcpRefreshTime = '';
}

if($error || $_POST['submitBack'] != null) { 
}
else {
    
    $params['lang'] = $_SESSION['lang'];
    $params['pgpool2_config_file'] = $pgpool2_config_file;
    $params['password_file'] = $password_file;
    $params['pcp_client_dir'] = $pcp_client_dir;
    $params['pcp_hostname'] = $pcp_hostname;
    $params['pcp_refreshTime'] = $pcp_refreshTime;
    
    $_SESSION['params'] = $params;
}

if(!$error && $action == 'next') {

    $fp = fopen( "../conf/pgmgt.conf.php", "w");

    fputs($fp, "<?php"."\n");
    
    $str = 'define(\'_PGPOOL2_LANG\', \'' . $_SESSION['lang'] . '\');' . "\n";
    fputs($fp, $str);
    
    $str = 'define(\'_PGPOOL2_CONFIG_FILE\', \'' . $_POST['pgpool2_config_file'] . '\');' . "\n";
    fputs($fp, $str);
    
    $str = 'define(\'_PGPOOL2_PASSWORD_FILE\', \'' . $_POST['password_file'] . '\');' . "\n";
    fputs($fp, $str);
    
    $str = 'define(\'_PGPOOL2_COMMAND\', \'' . $_POST['pgpool_command'] . '\');' . "\n";
    fputs($fp, $str);
    
    if(isset($_POST['c'])) {
        $c = 1;
    } else {
        $c = 0;
    }
    
    if(isset($_POST['d'])) {
        $d = 1;
    } else {
        $d = 0;
    }
    
    if(isset($_POST['n'])) {
        $n = 1;
    } else {
        $n = 0;
    }
    
    $str = 'define(\'_PGPOOL2_CMD_OPTION_C\', \'' . $c . '\');' . "\n";
    fputs($fp, $str);
    
    $str = 'define(\'_PGPOOL2_CMD_OPTION_D\', \'' . $d . '\');' . "\n";
    fputs($fp, $str);
    
    $str = 'define(\'_PGPOOL2_CMD_OPTION_M\', \'' . $_POST['m'] . '\');' . "\n";
    fputs($fp, $str);
    
    $str = 'define(\'_PGPOOL2_CMD_OPTION_N\', \'' . $n . '\');' . "\n";
    fputs($fp, $str);
    
    $str = 'define(\'_PGPOOL2_LOG_FILE\', \'' . $_POST['pgpool_logfile'] . '\');' . "\n";
    fputs($fp, $str);
    
    $str = 'define(\'_PGPOOL2_PCP_DIR\', \'' . $_POST['pcp_client_dir'] . '\');' . "\n";
    fputs($fp, $str);
    
    $str = 'define(\'_PGPOOL2_PCP_HOSTNAME\', \'' . $_POST['pcp_hostname'] . '\');' . "\n";
    fputs($fp, $str);
    
    $str = 'define(\'_PGPOOL2_PCP_TIMEOUT\', \'' . $_POST['pcp_timeout'] . '\');' . "\n";
    fputs($fp, $str);
    
    $str = 'define(\'_PGPOOL2_STATUS_REFRESH_TIME\', \'' . $_POST['pcp_refreshTime'] . '\');' . "\n";
    fputs($fp, $str);
    
    fputs($fp, "?>"."\n");
    
    fclose($fp);
    
    header("Location: finish.php");
}
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
  <h3><?php echo $message['strParameterCheck']; ?></h3>
  <form action="checkParameter.php" method="post" name="CheckPath" id="CheckPath">
    <?php
    if($error) {
        echo '<input type="hidden" name="action" value="check">';
    } else {
        echo '<input type="hidden" name="action" value="next">';
    }
    ?>
<table>
  <tbody>
  <tr>
    <th><label><?php echo $message['strPgConfFile'] ?></label></th>
    <td><input name="pgpool2_config_file" type="text" value="<?php echo $pgpool2_config_file?>" size="50" />
    <?php
    if($msgPgpoolConfigFile != '') {
        echo '<br />' . $msgPgpoolConfigFile;
        echo '</td><td><img src="images/ng.gif" alt="ng" />';
    } else {
        echo '</td><td><img src="images/ok.gif" alt="ok" />';
    }
    ?>
    </td>
  </tr>
  <tr>
    <th><label><?php echo $message['strPasswordFile'] ?></label></th>
	  <td><input name="password_file" type="text" value="<?php echo $password_file ?>" size="50" />
    <?php
    if($msgPasswordFile != '') {
        echo '<br />' . $msgPasswordFile;
        echo '</td><td><img src="images/ng.gif" alt="ng" />';
    } else {
        echo '</td><td><img src="images/ok.gif" alt="ok" />';
    }
    ?>
    </td>
  </tr>
  <tr>
    <th><label><?php echo $message['strPgpoolCommand'] ?></label></th>
                  <td><input name="pgpool_command" type="text" value="<?php echo $pgpool_command ?>" size="50" />
    <?php
    if($msgPgpoolCommand != '') {
        echo '<br />' . $msgPgpoolCommand;
        echo '</td><td><img src="images/ng.gif" alt="ng" />';
    } else {
        echo '</td><td><img src="images/ok.gif" alt="ok" />';
    }
    ?>
    </td>
  </tr>
  <tr>
    <th colspan="3"><label><?php echo $message['strPgpoolCommandOption'] ?></label></th>
  </tr>
  <tr>
    <th><label><?php echo $message['strCmdC'] ?></label></th>
      <td><input type="checkbox" name="c" /></td>
    <?php
    if($msgCmdC != '') {
        echo '<br />' . $msgCmdC;
        echo '</td><td><img src="images/ng.gif" alt="ng" />';
    } else {
        echo '</td><td><img src="images/ok.gif" alt="ok" />';
    }
    ?>
    </td>
  </tr>
  <tr>
    <th><label><?php echo $message['strCmdN'] ?></label></th>
      <td><input type="checkbox" name="n" /></td>
    <?php
    if($msgCmdN != '') {
        echo '<br />' . $msgCmdN;
        echo '</td><td><img src="images/ng.gif" alt="ng" />';
    } else {
        echo '</td><td><img src="images/ok.gif" alt="ok" />';
    }
    ?>
    </td>
  </tr>
  <tr>
    <th><label><?php echo $message['strCmdD'] ?></label></th>
      <td><input type="checkbox" name="d" /></td>
    <?php
    if($msgCmdD != '') {
        echo '<br />' . $msgCmdD;
        echo '</td><td><img src="images/ng.gif" alt="ng" />';
    } else {
        echo '</td><td><img src="images/ok.gif" alt="ok" />';
    }
    ?>
    </td>
  </tr>
  <tr>
    <th><label><?php echo $message['strCmdM'] ?></label></th>
      <td><select  name="m" />
           <option value="s" selected="selected">smart</optgroup>
           <option value="f">fast</optgroup>
           <option value="i">immediate</optgroup>
           </select>
     </td>
    <?php
    if($msgCmdM != '') {
        echo '<br />' . $msgCmdM;
        echo '</td><td><img src="images/ng.gif" alt="ng" />';
    } else {
        echo '</td><td><img src="images/ok.gif" alt="ok" />';
    }
    ?>
    </td>
  </tr>
  <tr>
    <th><label><?php echo $message['strPgpoolLogFile'] ?></label></th>
                  <td><input name="pgpool_logfile" type="text" value="<?php echo $pgpool_logfile ?>" size="50" />
    <?php
    if($msgPgpoolLogFile != '') {
        echo '<br />' . $msgPgpoolLogFile;
        echo '</td><td><img src="images/ng.gif" alt="ng" />';
    } else {
        echo '</td><td><img src="images/ok.gif" alt="ok" />';
    }
    ?>
    </td>
  </tr>

  <tr>
    <th><label><?php echo $message['strPcpDir'] ?></label></th>
                  <td><input name="pcp_client_dir" type="text" value="<?php echo $pcp_client_dir ?>" size="50" />
    <?php
    if($msgPcpClientDir != '') {
        echo '<br />' . $msgPcpClientDir;
        echo '</td><td><img src="images/ng.gif" alt="ng" />';
    } else {
        echo '</td><td><img src="images/ok.gif" alt="ok" />';
    }
    ?>
    </td>
  </tr>
  <tr>
    <th><label><?php echo $message['strPcpHostName'] ?></label></th>
                  <td><input name="pcp_hostname" type="text" value="<?php echo $pcp_hostname ?>" size="50" />
    <?php
    if($msgPcpHostname != '') {
        echo '<br />' . $msgPcpHostname;
        echo '</td><td><img src="images/ng.gif" alt="ng" />';
    } else {
        echo '</td><td><img src="images/ok.gif" alt="ok" />';
    }
    ?>
    </td>
  </tr>
  <tr>
    <th><label><?php echo $message['strPcpRefreshTime'] ?></label></th>
                  <td><input name="pcp_refreshTime" type="text" value="<?php echo $pcp_refreshTime ?>" size="50" />
    <?php
    if($msgPcpRefreshTime != '') {
        echo '<br />' . $msgPcpRefreshTime;
        echo '</td><td><img src="images/ng.gif" alt="ng" />';
    } else {
        echo '</td><td><img src="images/ok.gif" alt="ok" />';
    }
    ?>
    </td>
  </tr>
  </tbody>
</table>
<p>
<?php
if($error) {
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
      Copyright &copy; 2006 <a href="http://pgpool.projects.postgresql.org/">pgpool Global Development Group</a>. All rights reserved.</address>
    </div>
  </body>
</html>
