<?php

/* vim: set expandtab tabstop=4 shiftwidth=4 softtabstop=4: */

/**
 * List of query cache
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

require_once('common.php');
$tpl->assign('help', basename( __FILE__, '.php'));

if (!isset($_SESSION[SESSION_LOGIN_USER])) {
    header('Location: login.php');
    exit();
}

readConfigParams();

if (isset($_GET['action'])) {
    $action=$_GET['action'];
} else {
    $action = '';
}

if (isset($_GET['col'])) {
    $col  = $_GET{'col'};
} else {
    $col = '';
}

if (isset($_GET['sort'])) {
    $sort  = $_GET{'sort'};
} else {
    $sort = '';
}

$tpl->assign('col', $col);
$tpl->assign('sort', $sort);

$sysDbParam = readConfigParams(array('system_db_hostname',
                                     'system_db_port',
                                     'system_db_dbname',
                                     'system_db_schema',
                                     'system_db_user',
                                     'system_db_password'));

$sysDbParam['hostname'] = $sysDbParam['system_db_hostname'];
$sysDbParam['port']     = $sysDbParam['system_db_port'];
$sysDbParam['dbname']   = $sysDbParam['system_db_dbname'];
$sysDbParam['user']     = $sysDbParam['system_db_user'];
$sysDbParam['password'] = $sysDbParam['system_db_password'];
$sysDbParam['connect_timeout'] = _PGPOOL2_CONNECT_TIMEOUT;

$sysDbSchema = $sysDbParam['system_db_schema'];

$conn = openDBConnection($sysDbParam);
if ($conn == FALSE) { errorPage('e2001'); }

$deleteRow = NULL;
if ($action == 'delete') {
    if (isset($_POST['hash'])) {
        $hashArray = $_POST['hash'];
    } else {
        $hashArray = FALSE;
    }

    if ($hashArray != FALSE) {
        $sql = "DELETE FROM $sysDbSchema.query_cache WHERE ";
        for ($i = 0; $i < count($hashArray) -1; $i++) {
            $escaped = pg_escape_string($hashArray[$i]);
            $sql .= "hash = '$escaped' OR ";
        }
        $sql .= "hash = '{$hashArray[$i]}'";
        $rs = execQuery($conn, $sql);
        $deleteRow = pg_affected_rows($rs);
    }
}
$tpl->assign("deleteRow", $deleteRow);

if ($action == 'search') {
    $query  = $_POST['qQueryStr'];
    $dbname = $_POST['qDb'];

    $_SESSION['qQueryStr'] = $query;
    $_SESSION['qDb'] = $dbname;
}

if (isset($_SESSION['qQueryStr'])) {
    $query = $_SESSION['qQueryStr'];
} else {
    $query = '';
}

if (isset($_SESSION['qDb'])) {
    $dbname = $_SESSION['qDb'];
} else {
    $dbname = '';
}

if ($action == 'clear') {
    session_unregister('qQueryStr');
    session_unregister('qDb');

    $query = '';
    $dbname = '';
}

$sql = "SELECT hash, query, dbname, create_time FROM $sysDbSchema.query_cache ";

$first = TRUE;
if ($query != NULL) {
    if ($first) {
        $sql = $sql . " WHERE ";
        $first = FALSE;

    } else {
        $sql = $sql . " AND ";
    }

    $sql = $sql . "query like '%" . pg_escape_string($query) . "%' ";
}
if ($dbname != NULL) {
    if ($first) {
        $sql = $sql . " WHERE ";
        $first = FALSE;

    } else {
        $sql = $sql . " AND ";
    }

    $sql = $sql . "dbname like '%" . pg_escape_string($dbname). "%' ";
}

if ($col == NULL) {
    $col = 'query';
}

$sql = $sql . " ORDER BY " . pg_escape_string($col);

if ($sort == "descending") {
    $sql = $sql . " DESC";
}

$rs = execQuery($conn, $sql);
if ($rs == FALSE) { errorPage('e2002'); }


$result = pg_fetch_all($rs);

closeDBConnection($conn);

$result = NULL;
if ($result) {
    $dateFormat = $message['strDateFormat'];
    for ($i = 0; $i < count($result); $i++) {
        $result[$i]['create_time'] = date($dateFormat, strtotime($result[$i]['create_time']));
    }
}
$tpl->assign('queryCache', $result);

$tpl->assign('qQueryStr', $query);
$tpl->assign("qDb", $dbname);

$tpl->display('queryCache.tpl');

?>
