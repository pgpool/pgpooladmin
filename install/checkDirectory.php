<?php

/* vim: set expandtab tabstop=4 shiftwidth=4 softtabstop=4: */

/**
 * Check directory used in PgpoolAdmin
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
 * @version    CVS: $Id$
 */

require_once('../version.php');

session_start();

require_once('setLang.php');

$error = false;

$action = '';
if(isset($_POST['action'])) {
    $action = $_POST['action'];
}

$templates_c = dirname(dirname(__FILE__) . '/') . '/templates_c';
if(!is_writable($templates_c)) {
    $templates_c = $templates_c . '  write denied';
    $error = true;
} else {
    unset($templates_c);
}
$conf = dirname(dirname(__FILE__) . '/') . '/conf/pgmgt.conf.php';
if(!is_writable($conf)) {
    $conf = $conf . '  write denied';
    $error = true;
} else {
    unset($conf);
}

if(!$error && $action == 'next') {
    header("Location: checkParameter.php");
}

?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><? echo $message['strDirectoryCheck'] ?></title>
<link href="../screen.css" rel="stylesheet" type="text/css" />
</head>
  <body>
    <div id="header">
      <h1><img src="../images/logo.gif" alt="pgpoolAdmin" /></h1>
    </div>
	  <div id="content">
  <h2>Welcome to pgpool-II Administration Tool</h2>
  <h3><? echo $message['strDirectoryCheck'] ?></h3>
  <form action="checkDirectory.php" method="post" name="CheckPath" id="CheckPath">
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
    <th><label><?php echo $message['strTempDir'] ?></label></th>
    <td>
      <?php
      if(isset($templates_c))
        echo "<img src='images/ng.gif' alt='ng' /> " . $templates_c;
      else
        echo "<img src='images/ok.gif' alt='ok' />";
      ?>
    </td>
   </tr>
   <tr>
    <th><label><?php echo $message['strPgmgtFile'] ?></label></th>
    <td>
        <?php
        if(isset($conf))
          echo "<img src='images/ng.gif' alt='ng' /> " . $conf;
        else
          echo "<img src='images/ok.gif' alt='ok' />";
        ?>
    </td>
   </tr>
   </tbody>
</table>
<p>
<?php
if($error)
    echo '<input type="submit" value="' . $message['strCheck'] . '" />';
else
    echo '<input type="submit" value="' . $message['strNext'] . '" />';
?>
</p>
</form>
</div>
    <div id="footer">
      <address>Version <?php echo $version;?><br />
      Copyright &copy; 2006 - 2008 <a href="http://pgpool.projects.postgresql.org/">pgpool Global Development Group</a>. All rights reserved.</address>
    </div>
  </body>
</html>
