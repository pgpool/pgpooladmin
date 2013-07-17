<?php

/* vim: set expandtab tabstop=4 shiftwidth=4 softtabstop=4: */

/**
 * Infomation of the pgpool summary
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
 * @copyright  2003-2011 PgPool Global Development Group
 * @version    CVS: $Id$
 */

require_once('common.php');

if (!isset($_SESSION[SESSION_LOGIN_USER])) {
    exit();
}

$params = readConfigParams(array('parallel_mode',
                                 'master_slave_mode',
                                 'master_slave_sub_mode',
                                 'memory_cache_enabled',
                                 'memqcache_method',
                                 'enable_query_cache',
                                 'replication_mode',
                                 'load_balance_mode',
                                 'use_watchdog',
                                 'wd_lifecheck_method',
                                 'health_check_period'));

$tpl->assign('params', $params);
$tpl->display('innerSummary.tpl');

?>
