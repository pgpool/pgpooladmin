<?php

/* vim: set expandtab tabstop=4 shiftwidth=4 softtabstop=4: */

/**
 * Display and edit of pgpool system database
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
$tpl->assign('help', basename( __FILE__, '.php'));

if (!isset($_SESSION[SESSION_LOGIN_USER])) {
    header('Location: login.php');
    exit();
}

if (!file_exists(_PGPOOL2_CONFIG_FILE)) {
    $errorCode = 'e3006';
    $tpl->assign('errorCode', $errorCode);
    $tpl->display('error.tpl');
    exit();
}

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

$conn = openDBConnection($sysDbParam);
if ($conn == FALSE) {
    $errorCode = 'e3001';
    $tpl->assign('errorCode', $errorCode);
    $tpl->display('error.tpl');
    exit();
}

$sysDbSchema = $sysDbParam['system_db_schema'];

if (isset($_GET['dbname'])) {
    $dbname = pg_escape_string($_GET['dbname']);
} else {
    $dbname = '';
}
if (isset($_GET['schema_name'])) {
    $schema_name = pg_escape_string($_GET['schema_name']);
} else {
    $schema_name = '';
}
if (isset($_GET['table_name'])) {
    $table_name = pg_escape_string($_GET['table_name']);
} else {
    $table_name = '';
}

$result = NULL;

if ($dbname && $schema_name && $table_name) {
    $sql = "SELECT * FROM $sysDbSchema.dist_def ".
           "WHERE dbname='$dbname' AND schema_name='$schema_name' AND table_name = '$table_name'";

    $rs = execQuery($conn, $sql);
    if ($rs == FALSE) {
        $errorCode = 'e3002';
        $tpl->assign('errorCode', $errorCode);
        $tpl->display('error.tpl');
        exit();
    }

    if (pg_num_rows($rs) > 0) {
        $result = pg_fetch_array($rs, 0);

        $col_lists  = var_sql2php($result['col_list']);
        $type_lists = var_sql2php($result['type_list']);

        $col_list  = "'{$col_lists[0]}'";
        $type_list = "'{$type_lists[0]}'";

        for ($i = 1; $i < count($col_lists); $i++) {
            $col_list  = "{$col_list}, '{$col_lists[$i]}'";
            $type_list = "{$type_list}, '{$type_lists[$i]}'";
        }

        $result['col_list']  = $col_list;
        $result['type_list'] = $type_list;

        $tpl->assign('isUpdate', TRUE);
    }
}

$tpl->assign('result', $result);

if (isset($_POST['action'])) {
    $action = $_POST['action'];
} else {
    $action = FALSE;
}

$error = FALSE;

switch ($action) {

    case 'add':
        $dbname        = $_POST['dbname'];
        $schema_name   = $_POST['schema_name'];
        $table_name    = $_POST['table_name'];
        $col_name      = $_POST['col_name'];
        $col_list      = $_POST['col_list'];
        $type_list     = $_POST['type_list'];
        $dist_def_func = $_POST['dist_def_func'];

        $col_list  = str_replace('\\', '', $col_list);
        $type_list = str_replace('\\', '', $type_list);

        $col_lists  = explode_csv($col_list, FALSE, ',', '\'', array());
        $type_lists = explode_csv($type_list, FALSE, ',', '\'', array());

        if ($dbname        == '' ||
            $schema_name   == '' ||
            $table_name    == '' ||
            $col_name      == '' ||
            $col_list      == '' ||
            $type_list     == '' ||
            $dist_def_func == '')
        {
            $tpl->assign('error', $message['errInputEverything']);
            $error = TRUE;
            break;
        }

        if (count($col_lists) != count($type_lists)) {
            $tpl->assign('error', $message['errNotSameLength']);
            $error = TRUE;
            break;
        }

        for ($i = 0; $i < count($col_lists); $i++) {
            if (trim($col_lists[$i]) == '' || trim($type_lists[$i]) == '') {
                $tpl->assign('error', $message['errNotSameLength']);
                $error = TRUE;
                break 2;
            }
        }

        for ($i = 0; $i < count($col_lists); $i++) {
            $col_lists[$i]  = pg_escape_string(trim($col_lists[$i]));
            $type_lists[$i] = pg_escape_string(trim($type_lists[$i]));
        }

        $col_list  = array2sql($col_lists);
        $type_list = array2sql($type_lists);

        $dbname        = pg_escape_string($dbname);
        $schema_name   = pg_escape_string($schema_name);
        $table_name    = pg_escape_string($table_name);
        $col_name      = pg_escape_string($col_name);
        $dist_def_func = pg_escape_string($dist_def_func);

        $sql = "SELECT count(*) FROM $sysDbSchema.dist_def ".
               "WHERE dbname='$dbname' AND schema_name='$schema_name' AND table_name = '$table_name'";

        $rs = execQuery($conn, $sql);
        if ($rs == FALSE) {
            $errorCode = 'e3003';
            $tpl->assign('errorCode', $errorCode);
            $tpl->display('error.tpl');
            exit();
        }

        $count = pg_fetch_row($rs, 0);

        if ($count[0] > 0) {
            $tpl->assign('error', $message['errAlreadyExist']);
            $error = TRUE;
            break;
        }

        $sql = "INSERT INTO $sysDbSchema.dist_def VALUES ".
               "('$dbname', '$schema_name', '$table_name', '$col_name', ".
               "ARRAY[$col_list], ARRAY[$type_list], '$dist_def_func')";

        $rs = execQuery($conn, $sql);
        if ($rs == FALSE) {
            $errorCode = 'e3003';
            $tpl->assign('errorCode', $errorCode);
            $tpl->display('error.tpl');
            exit();
        }

        break;

    case 'update':
        $tpl->assign('isUpdate', TRUE);

        $dbname        = $_POST['dbname'];
        $schema_name   = $_POST['schema_name'];
        $table_name    = $_POST['table_name'];
        $col_name      = $_POST['col_name'];
        $col_list      = $_POST['col_list'];
        $type_list     = $_POST['type_list'];
        $dist_def_func = $_POST['dist_def_func'];

        $col_list  = str_replace('\\', '', $col_list);
        $type_list = str_replace('\\', '', $type_list);

        $col_lists  = explode_csv($col_list, FALSE, ',', '\'', array());
        $type_lists = explode_csv($type_list, FALSE, ',', '\'', array());

        if ($dbname        == '' ||
            $schema_name   == '' ||
            $table_name    == '' ||
            $col_name      == '' ||
            $col_list      == '' ||
            $type_list     == '' ||
            $dist_def_func == '')
        {
            $tpl->assign('error', $message['errInputEverything']);
            $error = TRUE;
            break;
        }

        if (count($col_lists) != count($type_lists)) {
            $tpl->assign('error', $message['errNotSameLength']);
            $error = TRUE;
            break;
        }

        $err = FALSE;

        for ($i = 0; $i < count($col_lists); $i++) {
            if (trim($col_lists[$i]) == '' || trim($type_lists[$i]) == '') {
                $tpl->assign('error', $message['errNotSameLength']);
                $error = TRUE;
                break 2;
            }
        }

        for ($i = 0; $i<count($col_lists); $i++) {
            $col_lists[$i]  = pg_escape_string(trim($col_lists[$i]));
            $type_lists[$i] = pg_escape_string(trim($type_lists[$i]));
        }

        $col_list  = array2sql($col_lists);
        $type_list = array2sql($type_lists);

        $dbname        = pg_escape_string($dbname);
        $schema_name   = pg_escape_string($schema_name);
        $table_name    = pg_escape_string($table_name);
        $col_name      = pg_escape_string($col_name);
        $dist_def_func = pg_escape_string($dist_def_func);

        if ($dbname && $schema_name && $table_name) {
            $sql = "UPDATE $sysDbSchema.dist_def SET ".
                   "dbname = '$dbname', ".
                   "schema_name = '$schema_name', ".
                   "table_name = '$table_name', ".
                   "col_name = '$col_name', ".
                   "col_list = ARRAY[$col_list], ".
                   "type_list = ARRAY[$type_list], ".
                   "dist_def_func = '$dist_def_func' ".
                   "WHERE dbname='$dbname' AND schema_name='$schema_name' AND table_name = '$table_name'";

            $rs = execQuery($conn, $sql);
            if ($rs == FALSE) {
                $errorCode = 'e3004';
                $tpl->assign('errorCode', $errorCode);
                $tpl->display('error.tpl');
                exit();
            }
            $tpl->assign('isUpdate', FALSE);

            break;
        }

    case 'delete':
        $dbname      = pg_escape_string($_POST['dbname']);
        $schema_name = pg_escape_string($_POST['schema_name']);
        $table_name  = pg_escape_string($_POST['table_name']);

        if ($dbname && $schema_name && $table_name) {
            $sql = "DELETE FROM $sysDbSchema.dist_def WHERE ".
                   "dbname = '$dbname' AND ".
                   "schema_name = '$schema_name' AND ".
                   "table_name = '$table_name'";

            $rs = execQuery($conn, $sql);
            if ($rs == FALSE) {
                $errorCode = 'e3005';
                $tpl->assign('errorCode', $errorCode);
                $tpl->display('error.tpl');
                exit();
            }
            break;

        }

    case 'cancel':
    default:
}

if ($error == TRUE) {
    $result['dbname']        = $dbname;
    $result['schema_name']   = $schema_name;
    $result['table_name']    = $table_name;
    $result['col_name']      = $col_name;
    $result['col_list']      = $col_list;
    $result['type_list']     = $type_list;
    $result['dist_def_func'] = $dist_def_func;

    $tpl->assign('result', $result);
}

$sql = "SELECT * FROM $sysDbSchema.dist_def ORDER BY dbname";
$rs = execQuery($conn, $sql);
if ($rs == FALSE) {
    $errorCode = 'e3002';
    $tpl->assign('errorCode', $errorCode);
    $tpl->display('error.tpl');
    exit();
}

$result = pg_fetch_all($rs);

closeDBConnection($conn);

if ($result) {
    $arrayResult = array();
    foreach($result as $rc) {
        $rc['col_list']   = var_sql2php($rc['col_list']);
        $rc['type_list']  = var_sql2php($rc['type_list']);
        $rc['listLength'] = count($rc['col_list']);
        array_push($arrayResult, $rc);
    }

    $tpl->assign('systemDb', $arrayResult);
}

$tpl->display('systemDb.tpl');

/* --------------------------------------------------------------------- */
/* Functions                                                             */
/* --------------------------------------------------------------------- */

function explode_csv($STR, $SQL = FALSE, $DELIMITER = ',', $ENCLOSURE = '"', $BRACKETS = array('{','}'))
{
    $column  = 0;
    $enclose = FALSE;
    $escape  = FALSE;
    $braket  = 0;
    settype($ROW[$column],'string');

    for ($i = 0; $i < mb_strlen($STR); $i++) {
        $C =  mb_substr($STR,$i,1);

        if (isset($BRACKETS[0])) {
            $brakets0 = $BRACKETS[0];
        } else {
            $brakets0 = NULL;
        }

        if (isset($BRACKETS[1])) {
            $brakets1 = $BRACKETS[1];
        } else {
            $brakets1 = NULL;
        }

        switch ($C) {
            case $DELIMITER:
                if($enclose || $braket > 0) {
                    $ROW[$column] .= $C;
                } else {
                    $column++;
                    settype($ROW[$column],'string');
                }
                $escape = FALSE;
                break;

            case $ENCLOSURE:
                if ($escape || $braket) {
                    $ROW[$column] .= $C;
                } else {
                    if ($enclose) {
                       $enclose = FALSE;
                    } else {
                        $enclose = TRUE;
                    }
                }
                $escape = FALSE;
                break;

            case '\\':
                $ROW[$column] .= $C;
                $escape = TRUE;
                break;

            case $brakets0:
                $ROW[$column] .= $C;
                if ($SQL && !$escape) {
                    $braket++;
                }
                $escape = FALSE;
                break;

            case $brakets1:
                $ROW[$column] .= $C;
                if ($SQL && !$escape) {
                    $braket--;
                }
                $escape = FALSE;
                break;

            default:
                $ROW[$column] .= $C;
                $escape = FALSE;
        }
    }

    return($ROW);
}

function var_sql2php($VAL)
{
    if (mb_ereg('^\{(.*)\}$',$VAL,$match) !== FALSE) {
        $VAL = array_map('var_sql2php', explode_csv($match[1],TRUE));
    }
    return($VAL);
}

function array2sql($var)
{
    if (!is_array($var)) {
        return '';
    }

    $str = '';
    $str = "'{$var[0] }'";

    for ($i = 1; $i < count($var); $i++) {
        $str  = "{$str} , '{$var[$i]}'";
    }
    return $str;
}

?>
