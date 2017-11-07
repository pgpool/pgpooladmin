<?php
/**
 * @copyright  2003-2016 PgPool Global Development Group
 */

// Session
define('SESSION_LOGIN_USER',          'loginUser');
define('SESSION_LOGIN_USER_PASSWORD', 'md5pass');
define('SESSION_LANG',                'lang');
define('SESSION_MESSAGE',             'message');
define('SESSION_IS_SUPER_USER',       'is_superuser');

// Smarty Parameter
define('SMARTY_TEMPLATE_DIR', dirname(__FILE__) . '/templates' );
define('SMARTY_COMPILE_DIR',  dirname(__FILE__) . '/templates_c' );

// pgpool-II
define('PGPOOL_OFFICIAL_SITE', 'http://www.pgpool.net/');

// pgpoolAdmin
define('PGPOOLADMIN_HOST', exec('hostname -f'));

// node status in "pcp_node_info" result
// http://www.pgpool.net/pgpool-web/pgpool-II/doc/pgpool-ja.html#pcp_node_info
define('NODE_ACTIVE_NO_CONNECT', 1);
define('NODE_ACTIVE_CONNECTED',  2);
define('NODE_DOWN',              3);
define('NODE_NOT_LOADED',       -1); // only for pgpoolAdmin

// watchdog status in "pcp_watchdog_info" result (- 3.4)
// (defined in $src/inclucde/watchdog/watchdog.h
$g_watchdog_status_str_arr = array();
if (defined('_PGPOOL2_VERSION') && _PGPOOL2_VERSION < 3.5) {
    define('WATCHDOG_END',     0);
    define('WATCHDOG_INIT',    1);
    define('WATCHDOG_NORMAL',  2);
    define('WATCHDOG_MASTER',  3);
    define('WATCHDOG_DOWN',    4);
    $g_watchdog_status_str_arr = array(
        WATCHDOG_END    => 'END',
        WATCHDOG_INIT   => 'INIT',
        WATCHDOG_NORMAL => 'NORMAL',
        WATCHDOG_MASTER => 'MASTER',
        WATCHDOG_DOWN   => 'DOWN',
    );
}

// timeout seconds
// (The parameter "pcp_timeout" existed till V3.0.)
define('PCP_TIMEOUT', 10);

define('PGPOOL_WAIT_SECONDS', 10);
define('REFRESH_LOG_SECONDS', 2000);
define('EACH_LOG_LINES', 50);
define('NO_ARGS', ' ');
