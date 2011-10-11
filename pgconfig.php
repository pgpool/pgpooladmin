<?php

/* vim: set expandtab tabstop=4 shiftwidth=4 softtabstop=4: */

/**
 * View and edit of pgpool.conf
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
 * @copyright  2003-2010 PgPool Global Development Group
 * @version    CVS: $Id$
 */

require_once('common.php');
require('definePgpoolConfParam.php');
$tpl->assign('help', basename( __FILE__, '.php'));


if (!isset($_SESSION[SESSION_LOGIN_USER])) {
    header('Location: login.php');
    exit();
}

$configParam = array();
$error = array();

if (isset($_POST['action'])) {
    $action = $_POST['action'];
} else {
    $action = FALSE;
}

/* --------------------------------------------------------------------- */
/* Add or Cancel                                                         */
/* --------------------------------------------------------------------- */

switch ($action) {
    case 'add':

        // Boolean value
        foreach ($pgpoolConfigParam as $key => $value) {
            if ($pgpoolConfigParam[$key]['type'] == 'B') {
                if (isset($_POST[$key])) {
                    $configValue[$key] = 'on';
                } else {
                    $configValue[$key] = 'off';
                }
            } else {
                $configValue[$key] = trim($_POST[$key]);
            }
        }

        // Backend settings
        if (isset($_POST['backend_hostname'])) {
            $configValue['backend_hostname'] = $_POST['backend_hostname'];
        } else {
             $configValue['backend_hostname'] = array();

        }
        if (isset($_POST['backend_port'])) {
            $configValue['backend_port'] = $_POST['backend_port'];
        } else {
             $configValue['backend_port'] = array();
        }

        if (isset($_POST['backend_weight'])) {
            $configValue['backend_weight'] = $_POST['backend_weight'];
        } else {
             $configValue['backend_weight'] = array();
        }

        if (isset($_POST['backend_data_directory'])) {
            $configValue['backend_data_directory'] = $_POST['backend_data_directory'];
        } else {
             $configValue['backend_data_directory'] = array();
        }

        if (isset($_POST['backend_flag'])) {
            $configValue['backend_flag'] = $_POST['backend_flag'];
        } else {
             $configValue['backend_flag'] = array();
        }

        $tpl->assign('params', $configValue);
        $tpl->assign('isAdd', TRUE);
        $tpl->display('pgconfig.tpl');

        return;

    case 'cancel':

        // Boolean value
        foreach ($pgpoolConfigParam as $key => $value) {
            if ($pgpoolConfigParam[$key]['type'] == 'B') {
                if (isset($_POST[$key])) {
                    $configValue[$key] = 'on';
                } else {
                    $configValue[$key] = 'off';
                }
            } else {
                $configValue[$key] = trim($_POST[$key]);
            }
        }

        // Backend settings
        if (isset($_POST['backend_hostname'])) {
            $configValue['backend_hostname'] = $_POST['backend_hostname'];
        }
        if (isset($_POST['backend_port'])) {
            $configValue['backend_port'] = $_POST['backend_port'];
        }
        if (isset($_POST['backend_weight'])) {
            $configValue['backend_weight'] = $_POST['backend_weight'];
        }
        if (isset($_POST['backend_data_directory'])) {
            $configValue['backend_data_directory'] = $_POST['backend_data_directory'];
        }
        if (isset($_POST['backend_flag'])) {
            $configValue['backend_flag'] = $_POST['backend_flag'];
        }

        array_pop($configValue['backend_hostname']);
        array_pop($configValue['backend_port']);
        array_pop($configValue['backend_weight']);
        array_pop($configValue['backend_data_directory']);
        array_pop($configValue['backend_flag']);
        $tpl->assign('params', $configValue);
        $tpl->assign('isAdd', FALSE);
        $tpl->display('pgconfig.tpl');

        return;
}

/* --------------------------------------------------------------------- */
/* Update or Delete                                                      */
/* --------------------------------------------------------------------- */

/**
 * check $configFile
 */
$configValue = readConfigParams();
foreach ($pgpoolConfigParam as $key => $value) {
    if (!isset($configValue[$key]) ) {
        $configValue[$key] = $value['default'];
    }
}

switch ($action) {
    case 'update':

        /**
         * copy from POST data to $configValue except backend value
         */
        foreach ($pgpoolConfigParam as $key => $value) {
            if ($pgpoolConfigParam[$key]['type'] == 'B') {
                if (isset($_POST[$key])) {
                    $configValue[$key] = 'true';
                } else {
                    $configValue[$key] = 'false';
                }
            } else {
                $configValue[$key] = trim($_POST[$key]);
            }
        }

        /**
         * Confirmations of value except backend host
         */
        foreach( $pgpoolConfigParam as $key => $value) {
            check($key, $value, $configValue, $error);
        }

        /**
         * copy backend value from POST data to $configValue
         */
        foreach ($pgpoolConfigBackendParam as $key => $value) {
            if (isset($_POST[$key])) {
                $configValue[$key] = $_POST[$key];
            }
        }
        /**
         * check backend value
         */
        if (isset($configValue['backend_hostname'])) {
            for ($i = 0; $i < count($configValue['backend_hostname']); $i++) {
                $hostname       = $configValue['backend_hostname'][$i];
                $port           = $configValue['backend_port'][$i];
                $weight         = $configValue['backend_weight'][$i];
                $data_directory = $configValue['backend_data_directory'][$i];
                $flag           = $configValue['backend_flag'][$i];

                $result = FALSE;

                // backend_hostname
                $result = checkString($hostname,
                                      $pgpoolConfigBackendParam['backend_hostname']['regexp']);
                if (!$result) {
                    $error['backend_hostname'][$i] = TRUE;
                } else {
                    $error['backend_hostname'][$i] = FALSE;
                }

                // backend_port
                $result = checkInteger($port,
                                       $pgpoolConfigBackendParam['backend_port']['min'],
                                       $pgpoolConfigBackendParam['backend_port']['max']);
                if (!$result) {
                    $error['backend_port'][$i] = TRUE;
                } else {
                    $error['backend_port'][$i] = FALSE;
                }

                // backend_weight
                $result = checkFloat($weight,
                                     $pgpoolConfigBackendParam['backend_weight']['min'],
                                     $pgpoolConfigBackendParam['backend_weight']['max']);
                if (!$result) {
                    $error['backend_weight'][$i] = TRUE;
                } else {
                    $error['backend_weight'][$i] = FALSE;
                }

                // backend_data_directory
                $result = checkString($data_directory,
                                      $pgpoolConfigBackendParam['backend_data_directory']['regexp']);
                if (!$result) {
                    $error['backend_data_directory'][$i] = TRUE;
                } else {
                    $error['backend_data_directory'][$i] = FALSE;
                }

                // backend_flag
                $result = checkString($flag,
                                      $pgpoolConfigBackendParam['backend_flag']['regexp']);
                if (!$result) {
                    $error['backend_flag'][$i] = TRUE;
                } else {
                    $error['backend_flag'][$i] = FALSE;
                }
            }
        }

        $isError = FALSE;
        foreach ($error as $key => $value) {
            if (preg_match("/^backend_hostname/",       $key) ||
                preg_match("/^backend_port/",           $key) ||
                preg_match("/^backend_weight/",         $key) ||
                preg_match("/^backend_data_directory/", $key) ||
                preg_match("/^backend_flag/",           $key))
            {
                for ($i = 0; $i < count($value); $i++) {
                    if ($value[$i] == TRUE) {
                        $isError = TRUE;
                    }
                }

            } else {
                if ($value == TRUE) {
                    $isError = TRUE;
                }
            }

            if ($isError) { break; }
        }

        if (!$isError) {
            if (is_writable(_PGPOOL2_CONFIG_FILE)) {
                writeConfigFile($configValue, $pgpoolConfigParam);
                $configValue = readConfigParams();
                $tpl->assign('status', 'success');
            } else {
                $errorCode = 'e4003';
                $tpl->assign('errorCode', $errorCode);
                $tpl->display('error.tpl');
                exit();
            }

        } else {
            $tpl->assign('status', 'fail');
        }

        break;

    case 'delete':
        $num = $_POST['num'];
        deleteBackendHost($num, $configValue);

        if (is_writable(_PGPOOL2_CONFIG_FILE)) {
            writeConfigFile($configValue, $pgpoolConfigParam);
            $configValue = readConfigParams();

        } else {
            $errorCode = 'e4003';
            $tpl->assign('errorCode', $errorCode);
            $tpl->display('error.tpl');
            exit();
        }

        break;

    case 'reset':
    default:
}

$tpl->assign('params', $configValue);
$tpl->assign('error', $error);

$tpl->display('pgconfig.tpl');

/* --------------------------------------------------------------------- */
/* Functions                                                             */
/* --------------------------------------------------------------------- */

/**
 * check POST value
 *
 * @param string $key
 * @param string $value
 * @param array $configParam
 * @param string $error
 */
function check($key, $value, &$configParam ,&$error)
{
    $type = $value['type'];
    $result = FALSE;
    switch ($type) {
        case 'B':
            $result = checkBoolean($configParam[$key]);

            // allow true/false and on/off as input format,
            // but write with only on/off format.
            if ($result) {
                if ($configParam[$key] == 'true') {
                    $configParam[$key] = 'on';
                } elseif ($configParam[$key] == 'false') {
                    $configParam[$key] = 'off';
                }
            }

            break;

        case 'C':
            $result = checkString($configParam[$key], $value['regexp']);
            break;

        case 'F':
            $result = checkFloat($configParam[$key], $value['min'], $value['max']);
            break;

        case 'N':
            $result = checkInteger($configParam[$key], $value['min'], $value['max']);
            break;
    }
    if (!$result) {
        $error[$key] = TRUE;
    }
}

/**
 * check string value
 *
 * @param string $str
 * @param string $pattern
 * @return bool
 */
function checkString($str, $pattern)
{
    if (preg_match("/$pattern/", $str)) {
        return TRUE;
    } else {
        return FALSE;
    }
}

/**
 * check integer value
 *
 * @param int $str
 * @param int $min
 * @param int $max
 * @return bool
 */
function checkInteger($str, $min, $max)
{
    if (is_numeric($str)) {
        $minLen = strlen($min);
        $maxLen = strlen($max);

        if ($str < $min || $str > $max) {
            return FALSE;
        } else {
            return TRUE;
        }
    }
    return FALSE;
}

/**
 * check float value
 *
 * @param float $str
 * @param float $min
 * @param float $max
 * @return bool
 */
function checkFloat($str, $min, $max)
{
    if (is_numeric($str)) {
        if ($str < $min || $str > $max) {
            return FALSE;
        }
        return TRUE;
    }
    return FALSE;
}

/**
 * Check Boolean value
 *
 * @param bool $str
 * @return bool
 */
function checkBoolean($str)
{
    if (in_array($str, array('true', 'false', 'on', 'off'))) {
        return TRUE;
    } else {
        return FALSE;
    }
}

/**
 * Write pgpool.conf
 *
 * @param array $configValue
 * @param array $pgpoolConfigParam
 */
function writeConfigFile($configValue, $pgpoolConfigParam)
{
    $configFile = @file(_PGPOOL2_CONFIG_FILE);

    $removeBackendConfigFile = array();

    for ($i = 0; $i < count($configFile); $i++) {
        $line = $configFile[$i];

        if (preg_match("/^\w/", $line)) {
            list($key, $value) = explode("=", $line);
            $key = trim($key);

            if (!preg_match("/^backend_hostname/",       $key) &&
                !preg_match("/^backend_port/",           $key) &&
                !preg_match("/^backend_weight/",         $key) &&
                !preg_match("/^backend_data_directory/", $key) &&
                !preg_match("/^backend_flag/",           $key))
            {
                $removeBackendConfigFile[] =  $line;
            }

        } else {
            $removeBackendConfigFile[] =  $line;
        }
    }

    $configFile = $removeBackendConfigFile;

    foreach ($pgpoolConfigParam as $key => $value) {
        $isWrite = FALSE;
        for ($j = 0; $j<count($configFile); $j++) {
            $line = $configFile[$j];
            $line = trim($line);

            if (preg_match("/^$key/", $line)) {
                if (strcmp($pgpoolConfigParam[$key]['type'], "C") == 0) {
                    $configFile[$j] = $key . " = '" . $configValue[$key] . "'\n";
                } else {
                    $configFile[$j] = $key . " = " . $configValue[$key]."\n";
                }
                $isWrite = TRUE;
                break;
            }
        }

        if (!$isWrite) {
            if (strcmp($pgpoolConfigParam[$key]['type'], "C") == 0) {
                $configFile[] = $key . " = '" . $configValue[$key] . "'\n";
            } else {
                $configFile[] = $key . " = " . $configValue[$key]."\n";
            }
        }
    }

    if (isset($configValue['backend_hostname'])) {
        for ($i = 0; $i<count($configValue['backend_hostname']); $i++) {

            $line = "backend_hostname$i = '" . $configValue['backend_hostname'][$i] . "'\n";
            $configFile[] = $line;

            $line = "backend_port$i = " . $configValue['backend_port'][$i] . "\n";
            $configFile[] = $line;

            $line = "backend_weight$i = " . $configValue['backend_weight'][$i] . "\n";
            $configFile[] = $line;

            $line = "backend_data_directory$i = '" . $configValue['backend_data_directory'][$i] . "'\n";
            $configFile[] = $line;

            $line = "backend_flag$i= '" . $configValue['backend_flag'][$i] . "'\n";
            $configFile[] = $line;
        }
    }

    $outfp = fopen(_PGPOOL2_CONFIG_FILE, 'w');
    foreach ($configFile as $line) {
        fputs($outfp, $line);
    }
    fclose($outfp);
}

/**
 * Delete backend host
 *
 * @param int $num
 * @param array $configValue
 */
function  deleteBackendHost($num, &$configValue)
{
    unset($configValue['backend_hostname'][$num]);
    $configValue['backend_hostname'] = array_values($configValue['backend_hostname']);

    unset($configValue['backend_port'][$num]);
    $configValue['backend_port'] = array_values($configValue['backend_port']);

    unset($configValue['backend_weight'][$num]);
    $configValue['backend_weight'] = array_values($configValue['backend_weight']);

    unset($configValue['backend_data_directory'][$num]);
    $configValue['backend_data_directory'] = array_values($configValue['backend_data_directory']);

    unset($configValue['backend_flag'][$num]);
    $configValue['backend_flag'] = array_values($configValue['backend_flag']);
}

?>
