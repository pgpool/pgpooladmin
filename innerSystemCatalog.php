<?php

/* vim: set expandtab tabstop=4 shiftwidth=4 softtabstop=4: */

/**
 * View of the system catalog selected postgresql server
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
 * @copyright  2003-2006 PgPool Global Development Group
 * @version    CVS: $Id$
 */

require_once('common.php');

if(!isset($_SESSION[SESSION_LOGIN_USER])) {
    exit();
}

$pgCatalog = pg_escape_string($_GET['catalog']);
$nodeNum = $_GET['num'];

if($pgCatalog == '') {
    return;
}

$params =readHealthCheckParam();

$dbParams['hostname'] = $params['backend_hostname'][$nodeNum];
$dbParams['port'] = $params['backend_port'][$nodeNum];
$dbParams['dbname'] = 'template1';
$dbParams['user'] = $params['health_check_user'];
$dbParams['password']  ='';

$tpl->assign('hostname', $dbParams['hostname'] );
$tpl->assign('port', $dbParams['port'] );

$conn = openDBConnection($dbParams);

$sql = 'show pool_status';

$rs = execQuery($conn, $sql);

if(!pg_result_status($rs) == PGSQL_TUPLES_OK) {
    $sql = "SELECT * FROM $pgCatalog";
    $rs = execQuery($conn, $sql);
    $tpl->assign('catalog', $pgCatalog);
} else {
    $tpl->assign('catalog', 'pool_status');
}

if(!pg_result_status($rs) == PGSQL_TUPLES_OK) {
    $errorCode = 'e8001';
    $tpl->assign('errorCode', $errorCode);
    $tpl->display('innerError.tpl');
    exit();
}

$results = pg_fetch_all($rs);

closeDBConnection($conn);

$tpl->assign('results', $results);
$tpl->display('innerSystemCatalog.tpl');

?>
