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
 * @copyright  2003-2015 PgPool Global Development Group
 * @version    CVS: $Id$
 */

require_once('common.php');

/* --------------------------------------------------------------------- */
/* InnerSystemCatalog.php                                                */
/* --------------------------------------------------------------------- */

// Check login status
if (!isset($_SESSION[SESSION_LOGIN_USER])) {
    exit();
}

// Get node num
$pgCatalog = pg_escape_string($_GET['catalog']);
$nodeNum = $_GET['num'];

if ($pgCatalog == '') {
    return;
}

// Get Data From Database
$params = readConfigParams(array(
    'backend_hostname', 'backend_port', 'backend_weight',
    'health_check_user', 'health_check_password'
));
$conn = openDBConnection(array(
    'host'     => $params['backend_hostname'][$nodeNum],
    'port'     => $params['backend_port'][$nodeNum],
    'dbname'   => 'template1',
    'user'     => $params['health_check_user'],
    'password' => $params['health_check_password'],
    'connect_timeout' => _PGPOOL2_CONNECT_TIMEOUT,
));

$rs = execQuery($conn, 'SHOW pool_status');

if (! pg_result_status($rs) == PGSQL_TUPLES_OK) {
    $rs = execQuery($conn, "SELECT * FROM $pgCatalog");
    $tpl->assign('catalog', $pgCatalog);

} else {
    $tpl->assign('catalog', 'pool_status');
}

if (! pg_result_status($rs) == PGSQL_TUPLES_OK) {
    $errorCode = 'e8001';
    $tpl->assign('errorCode', $errorCode);
    $tpl->display('innerError.tpl');
    exit();
}

$results = pg_fetch_all($rs);

closeDBConnection($conn);

// Set vars
$tpl->assign('hostname', $params['backend_hostname'][$nodeNum]);
$tpl->assign('port',     $params['backend_port'][$nodeNum]);
$tpl->assign('results', $results);
$tpl->assign('nodeNum', $nodeNum);

// Display
$tpl->display('innerSystemCatalog.tpl');
