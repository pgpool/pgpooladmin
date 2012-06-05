<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>{$message.strPgConfSetting|escape}</title>
<link href="screen.css" rel="stylesheet" type="text/css" />
</head>
<body>
<div id="header">
  <h1><img src="images/logo.gif" alt="pgpoolAdmin" /></h1>
</div>
<div id="menu">
{include file="menu.tpl"}
</div>
<div id="content">
<div id="help"><a href="{$help}.php"><img src="images/back.gif" />{$message.strBack}</a></div>

<h2>{$message.strHelp|escape}({$message.strPgConfSetting|escape})</h2>

<div id="submenu">
    <h3>Table of Contents</h3>
    <ul>
      <li><a href="#connections">Connections</a></li>
      <li><a href="#pools">Pools</a></li>
      <li><a href="#backends">Backends</a></li>
      <li><a href="#logs">Logs</a></li>
      <li><a href="#file_locations">File Locations</a></li>
      <li><a href="#connection_pooling">Connection Pooling</a></li>
      <li><a href="#replication">Replication</a></li>
      <li><a href="#load_balancing_mode">Load Balancing Mode</a></li>
      <li><a href="#master_slave_mode">Master/Slave Mode</a></li>
      <li><a href="#parallel_mode">Parallel Mode and Query Cache</a></li>
      <li><a href="#health-check">Health Check</a></li>
      <li><a href="#failover">Failover and Failback</a></li>
      <li><a href="#online-recovery">Online Recovery</a></li>
      <li><a href="#memqcache">On Memory Query Cache</a></li>
      <li><a href="#others">Others</a></li>
    </ul>
</div>

<h3>{$message.strSummary|escape}</h3>
The content of pgpool.conf that is the configuration file of pgpool set can be displayed and be changed. 

<h3>{$message.strFeature|escape}</h3>
Please input the value that wants to change and push the update button.

<h4>Addition of A backend host</h4>
Please push the add button when you want to add a new back end host. <br />
It inputs in back end host's item and a new input column can be done, and input information on a new back end host there, please.<br />
Please push the update button when input ends.

<h4>Deletion of backend host</h4>
Please push the delete button at the right of the host setting when you want to delete the back end host who has registered. <br />

<h3><a name="connections">Connections</a></h3>

<table>
  <thead>
    <tr>
      <th width="240">{$message.strParameter|escape}</th>
      <th>{$message.strDetail|escape}</th>
    </tr>
  </thead>
  <tbody>
    <tr><th class="category" colspan="2">pgpool Connection Settings</th></tr>

    <tr>
      <th id="LISTEN_ADDRESSES"><label>{$message.descListen_addresses|escape}</label>
      <p>listen_addresses (string) *</th>
      <td>
        <p>Specifies the hostname or IP address, on which pgpool-II will accept
        TCP/IP connections. <code>'*'</code> accepts
        all incoming connections. <code>''</code> disables TCP/IP
        connections.
        </p>
        <p>
        Default is <code>'localhost'</code>.
        Connections via UNIX domain socket are always accepted.
        </p>
      </td>
    </tr>

    <tr>
      <th id="PORT"><label>{$message.descPort|escape}</label>
      <p>port (integer) *</th>
      <td>
      <p>
      The port number used by pgpool-II to listen for connections. Default is 9999.
      </p>
      </td>
    </tr>

    <tr>
      <th id="SOCKET_DIR"><label>{$message.descSocket_dir|escape}</label>
      <p>socket_dir (string) *</th>
      <td>
        <p>The directory where the UNIX domain socket accepting connections for
        pgpool-II will be created. Default is <code>'/tmp'</code>.
        Be aware that this socket might be deleted by a cron job.
        We recommend to set this value to <code>'/var/run'</code> or such directory.
        </p>
      </td>
    </tr>

    <tr><th class="category" colspan="2">pgpool Communication Manager Connection Settings</th></tr>

    <tr>
      <th id="PCP_PORT"><label>{$message.descPcp_port|escape}</label>
      <p>pcp_port (integer) *</th>
      <td>
      <p>
      The port number where PCP process accepts connections. Default is 9898.
      </p>
      </td>
    </tr>

    <tr>
      <th id="PCP_SOCKET_DIR"><label>{$message.descPcp_socket_dir|escape}</label>
      <p>pcp_socket_dir (string) *</th>
      <td>
        <p>The directory path of the UNIX domain socket accepting
        connections for the PCP process. Default is <code>'/tmp'</code>.
        Be aware that the socket might be deleted by cron.
        We recommend to set this value to <code>'/var/run'</code> or such directory.
        </p>
      </td>
    </tr>

    <tr><th class="category" colspan="2">Authentication</th></tr>
    <tr>
      <th id="ENABLE_POOL_HBA"><label>{$message.descEnable_pool_hba|escape}</label>
      <p>enable_pool_hba (bool) *</th>
      <td>
        <p>
        If true, use pool_hba.conf for client authentication.
        </p>
      </td>
    </tr>

    <tr>
      <th id="AUTHENTICATION_TIMEOUT"><label>{$message.descAuthentication_timeout|escape}</label>
      <p>authentication_timeout (integer) *</th>
      <td>
        <p>Specify the timeout for pgpool authentication. 0 disables the time out.
        Default value is 60.
        </p>
      </td>
    </tr>

    {if paramExists('ssl')}
    <tr><th class="category" colspan="2">SSL Connections</th></tr>

    <tr>
      <th id="SSL"><label>{$message.descSsl|escape}</label>
      <p>ssl (bool) *</th>
      <td>
        <p>
        If true, enable SSL support for both the frontend and backend connections.
        Note that <code>ssl_key</code> and <code>ssl_cert</code>
        must also be set in order for SSL to work with frontend connections.
        </p>
        <p>
        SSL is off by default.  Note that OpenSSL support must also have been configured at compilation time.
        </p>
      </td>
    </tr>

    <tr>
      <th><label>{$message.descSsl_key|escape}</label>
      <p id="SSL_KEY">ssl_key (string)</th>
      <td>
        <p>
        The path to the private key file to use for incoming frontend connections.
        </p>
        <p>
        There is no default value for this option, and if left unset SSL will
        be disabled for incoming frontend connections.
        </p>
      </td>
    </tr>

    <tr>
      <th><label>{$message.descSsl_cert|escape}</label>
      <p id="SSL_CERT">ssl_cert (string)</th>
      <td>
        <p>
        The path to the public x509 certificate file to use for incoming
        frontend connections.
        </p>
        <p>
        There is no default value for this option, and if left unset SSL will
        be disabled for incoming frontend connections.
        </p>
      </td>
    </tr>

    <tr>
      <th id="SSL_CA_CERT"><label>{$message.descSsl_ca_cert|escape}</label>
      <p>ssl_ca_cert (string)</th>
      <td>
      </td>
    </tr>

    <tr>
      <th id="SSL_CA_CERT_DIR"><label>{$message.descSsl_ca_cert_dir|escape}</label>
      <p>ssl_ca_cert_dir (string)</th>
      <td>
      </td>
    </tr>
    {/if}

  </tbody>
  <tfoot>
    <tr>
      <td colspan="2"></td>
    </tr>
  </tfoot>
</table>


<h3><a name="pools">Pools</a></h3>
<table>
  <thead>
    <tr>
      <th width="240">{$message.strParameter|escape}</th>
      <th>{$message.strDetail|escape}</th>
    </tr>
  </thead>
  <tbody>
    <tr><th class="category" colspan="2">Pool size</th></tr>

    <tr>
      <th id="NUM_INIT_CHILDREN"><label>{$message.descNum_init_children|escape}</label>
      <p>num_init_children (integer) *</th>
      <td>
        <p>The number of preforked pgpool-II server processes. Default is 32.
        num_init_children is also the concurrent connections limit to pgpool-II from clients.
        If more than num_init_children clients try to connect to pgpool-II,
        they are blocked (not rejected) until a connection to any pgpool-II process is closed.
        Up to 2 * num_init_children can be queued.
        Number of connections to each PostgreSQL is roughly max_pool*num_init_children</p>

        <p>Some hints in addition to above:</p>
        <ul>
            <li>Canceling a query creates another
                connection to the backend; thus, a query cannot be canceled if
                all the connections are in use. If you want to ensure that queries can
                be canceled, set this value to twice the expected connections.</li>

            <li>PostgreSQL allows concurrent connections for non superusers up
                to max_connections - superuser_reserved_connections.</li>
        </ul>

        <p>In summary, max_pool, num_init_children, max_connections,
        superuser_reserved_connections must satisfy the following formula:
        </p>

        <table>
        <thead><tr><td colspan="2"></td></tr></thead>
        <tr><th>no query canceling needed</th>
            <td>max_pool*num_init_children &lt;= (max_connections - superuser_reserved_connections)</td>
        </tr>
        <tr><th>query canceling needed</th>
            <td>max_pool*num_init_children*2 &lt;= (max_connections - superuser_reserved_connections</td>
        </tr>
        <tfoot><tr><td colspan="2"></td></tr></tfoot>
        </table>

        <p>
        This parameter can only be set at server start.
        </p>
      </td>
    </tr>

    <tr>
      <th id="MAX_POOL"><label>{$message.descMax_pool|escape}</label>
      <p>max_pool (integer) *</th>
      <td>
        <p>The maximum number of cached connections in pgpool-II children processes.
        pgpool-II reuses the cached connection if an incoming connection is
        connecting to the same database with the same username.
        If not, pgpool-II creates a new connection to the backend.
        If the number of cached connections exceeds max_pool,
        the oldest connection will be discarded, and uses that slot for the new connection.
        </p>
        <p>
        Default value is 4. Please be aware that the number of
        connections from pgpool-II processes to the backends may reach
        <code><a href="#NUM_INIT_CHILDREN">num_init_children</a></code> *
        <code><a href="#MAX_POOL">max_pool</a></code>.
        </p>
      </td>
    </tr>

    <tr><th class="category" colspan="2">Life time</th></tr>

    <tr>
      <th id="CHILD_LIFE_TIME"><label>{$message.descChild_life_time|escape}</label>
      <p>child_life_time (integer)</th>
      <td>
        <p>A pgpool-II child process' life time in seconds.
        When a child is idle for that many seconds, it is terminated and a new child is created.
        This parameter is a measure to prevent memory leaks and other unexpected errors.
        Default value is 300 (5 minutes).
        0 disables this feature. Note that this doesn't apply for processes
        that have not accepted any connection yet.
        </p>
      </td>
    </tr>

    <tr>
      <th id="CHILD_MAX_CONNECTIONS"><label>{$message.descChild_max_connections|escape}</label>
      <p>child_max_connections (integer)</th>
      <td>
        <p>A pgpool-II child process will be terminated after this many connections from clients.
        This parameter is useful on a server
        if it is so busy that <a href=#CHILD_LIFE_TIME">child_life_time</a> and
        <a href="#CONNECTION_LIFE_TIME">connection_life_time</a> are never triggered.
        Thus this is also usefull to prevent PostgreSQL servers from getting too big.
        </p>
      </td>
    </tr>

    <tr>
      <th id="CONNECTION_LIFE_TIME"><label>{$message.descConnection_life_time|escape}</label>
      <p>connection_life_time (integer)</th>
      <td>
        <p>Cached connections expiration time in seconds. An expired
        cached connection will be disconnected. Default is 0, which
        means the cached connections will not be disconnected.</p>
      </td>
    </tr>

    <tr>
      <th id="CLIENT_IDLE_LIMIT"><label>{$message.descClient_idle_limit|escape}</label>
      <p>client_idle_limit (integer)</th>
      <td>
       <p> Similar to client_idle_limit but only takes effect in the second
        stage of recovery. A client being idle for client_idle_limit_in_recovery
        seconds since its last query will get disconnected.
        This is useful for preventing the pgpool recovery from being
        disturbed by a lazy client or if the TCP/IP connection between the client
        and pgpool is accidentally down (a cut cable for instance).
        If set to -1, disconnect the client immediately.
        The default value for client_idle_limit_in_recovery is 0,
        which means the feature is turned off.
        </p>
        <p>
        If your clients are very busy, pgpool-II cannot enter the second stage of
        recovery whatever value of client_idle_limit_in_recovery you may choose.
        In this case, you can set client_idle_limit_in_recovery to - 1
        so that pgpool-II immediately disconnects such busy clients before entering the second stage.
        </p>
      </td>
    </tr>
  </tbody>
  <tfoot>
    <tr>
      <td colspan="2"></td>
    </tr>
  </tfoot>
</table>


<h3><a name="backends">Backends</a></h3>
<table>
  <thead>
    <tr>
      <th width="240">{$message.strParameter|escape}</th>
      <th>{$message.strDetail|escape}</th>
      <td></td>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th id="BACKEND_HOSTNAME"><label>{$message.descBackend_hostname|escape}</label>
      <p>backend_hostname (string)</th>
      <td>
        <p>Specifies where to connect with the PostgreSQL backend.
        It is used by pgpool-II to communicate with the server.
        </p>
        <p>
        For TCP/IP communication, this parameter can take a hostname or an IP address.
        If this begins with a slash, it specifies Unix-domain communication
        rather than TCP/IP; the value is the name of the directory
        in which the socket file is stored. The default behavior when backend_hostname
        is empty (<code>''</code>) is to connect to a Unix-domain socket in <code>/tmp</code>.
        </p>
        <p>
        Multiple backends can be specified by adding a number at the end
        of the parameter name (e.g.<code>backend_hostname0</code>).
        This number is referred to as "DB node ID", and it starts from 0.
        The backend which was given the DB node ID of 0 will be called "Master DB".
        When multiple backends are defined, the service can be continued
        even if the Master DB is down (not true in some modes).
        In this case, the youngest DB node ID alive will be the new Master DB.</p>
        <p>
        Please note that the DB node which has id 0 has no special meaming
        if operated in streaming replication mode.
        Rather, you should care about if the DB node is the "primary node" or not.
        </p>
        <p>If you plan to use only one PostgreSQL server, specify it by
        <code>backend_hostname0</code>.</p>
      </td>
    </tr>

    <tr>
      <th id="BACKEND_PORT"><label>{$message.descBackend_port|escape}</label>
      <p>backend_port (integer)</th>
      <td>
        <p>Specifies the port number of the backends.
        Multiple backends can be specified by adding a number at the end of the parameter name
        (e.g. <code>backend_port0</code>).
        If you plan to use only one PostgreSQL server, specify it by <code>backend_port0</code>.</p>
      </td>
    </tr>

    <tr>
      <th id="BACKEND_WEIGHT"><label>{$message.descBackend_weight|escape}</label>
      <p>backend_weight (integer)</th>
      <td>
        <p>Specifies the load balance ratio for the backends. Multiple
        backends can be specified by adding a number at the end of the
        parameter name (e.g. <code>backend_weight0</code>). If you plan
        to use only one PostgreSQL server, specify it by
        <code>backend_weight0</code>. In the raw mode, set to 1.</p>
        <p>
        New backend weights can be added in this parameter by reloading a configuration file.
        </p>
        <p>
        From pgpool-II 2.2.6/2.3 or later, you can change this value by re-loading the configuration file.
        This will take effect only for new established client sessions.
        This is useful if you want to prevent any query sent to slaves to perform
        some administrative work in master/slave mode.
        </p>
      </td>
    </tr>

    <tr>
      <th id="BACKEND_DATA_DIRECTORY"><label>{$message.descBackend_data_directory|escape}</label>
      <p>backend_data_directory (string) *</th>
      <td>
        <p>Specifies the database cluster directory of the backends.
        Multiple backends can be specified by adding a number
        at the end of the parameter name
        (e.g. <code>backend_data_directory0</code>).
        If you don't plan to use online recovery, you do not need to specify this parameter.
        </p>
      </td>
    </tr>

    {if paramExists('backend_flag')}
    <tr>
      <th id="BACKEND_FLAG"><label>{$message.descBackend_flag|escape}</label>
      <p>backend_flag (string) *</th>
      <td>
        <p>Controls various backend behavior.
        Multiple backends can be specified by adding a number at the end of the parameter name
        (e.g. <code>backend_flag0</code>).
        </p>
        <p>
        Currently followings are allowed.
        Multiple falgs can be specified by using "|".
        </p>

        <table>
        <thead><tr><td colspan="2"></td></tr></thead>
        <tr><th class="nodec">ALLOW_TO_FAILOVER</th>
            <td>Allow to failover or detaching backend. This is the default.
                <p>You cannot specify with DISALLOW_TO_FAILOVER at a same time.</p>
            </td></tr>
        <tr><th class="nodec">DISALLOW_TO_FAILOVER</th>
        <td>Disallow to failover or detaching backend.
            This is usefull when you protect backend by using HA(High Availability) softwares
            such as Heartbeat or Pacemaker.
            <p>You cannot specify with ALLOW_TO_FAILOVER at a same time.</p>
        </td></tr>
        <tfoot><tr><td colspan="2"></td></tr></tfoot>
        </table>
      </td>
    </tr>
    {/if}

  </tbody>
  <tfoot>
    <tr>
      <td colspan="2"></td>
    </tr>
  </tfoot>
</table>


<h3><a name="logs">Logs</a></h3>
<table>
  <thead>
    <tr>
      <th width="240">{$message.strParameter|escape}</th>
      <th>{$message.strDetail|escape}</th>
    </tr>
  </thead>
  <tbody>
    {if paramExists('log_destination')}
    <tr><th class="category" colspan="2">Where to log</th></tr>

    <tr>
      <th id="LOG_DESTINATION"><label>{$message.descLog_destination|escape}</label>
      <p>log_destination (string) *</th>
      <td>
        <p>PgPool II supports several methods for logging server messages,
        including stderr and syslog. The default is to log to stderr.
        </p>
        <p>Note: you will need to alter the configuration of your system's syslog daemon
        in order to make use of the syslog option for log_destination.
        PgPool can log to syslog facilities LOCAL0 through LOCAL7
        (see <a href="#SYSLOG_FACILITY">syslog_facility</a>),
        but the default syslog configuration on most platforms will discard all such messages.
        You will need to add something like
        </p>
<pre>
local0.*    /var/log/pgpool.log
</pre>
          <p>to the syslog daemon's configuration file to make it work.</p>
      </td>
    </tr>
    {/if}

    <tr><th class="category" colspan="2">What to log</th></tr>

    <tr>
      <th id="PRINT_TIMESTAMP"><label>{$message.descPrint_timestamp|escape}</label>
      <p>print_timestamp (string) *</th>
      <td>
        <p>Add timestamps to the logs when set to true. Default is true.</p>
      </td>
    </tr>

    <tr>
      <th id="LOG_CONNECTIONS"><label>{$message.descLog_connections|escape}</label>
      <p>log_connections (bool)</th>
      <td>
        <p>If true, all incoming connections will be printed to the log.</p>
      </td>
    </tr>

    <tr>
      <th id="LOG_HOSTNAME"><label>{$message.descLog_hostname|escape}</label>
      <p>log_hostname (bool)</th>
      <td>
        <p>
        If true, ps command status will show the client's hostname instead
        of an IP address. Also, if <a href="#LOG_CONNECTIONS">log_connections</a> is enabled,
        hostname will be logged.
        </p>
      </td>
    </tr>

    <tr>
      <th id="LOG_STATEMENT"><label>{$message.descLog_statement|escape}</label>
      <p>log_statement (bool)</th>
      <td>
        <p>Produces SQL log messages when true. This is similar to the
        log_statement parameter in PostgreSQL. It produces logs even if the
        debug option was not passed to pgpool-II at startup.
        </p>
      </td>
    </tr>

    {if paramExists('log_per_node_statement')}
    <tr>
      <th id~"LOG_PER_NODE_STATEMENT"><label>{$message.descLog_per_node_statement|escape}</label>
      <p>log_per_node_statement (bool)</th>
      <td>
        <p>Similar to <a href="#LOG_PER_NODE_STATEMENT">log_statement</a>,
        except that it prints logs for each DB node separately.
        It can be useful to make sure that replication is working, for example.
        </p>
      </td>
    </tr>
    {/if}

    {if paramExists('log_standby_delay')}
    <tr>
      <th id="LOG_STANDBY_DELAY"><label>{$message.descLog_standby_delay|escape}</label>
      <p>log_standby_delay (string)</th>
      <td>
        <p>
        Specifies how to log the replication delay.
        If 'none' is specified, no log is written.
        If 'always', log the delay every time health checking is performed.
        If 'if_over_threshold' is specified, the log is written when the delay
        exceeds <a href="#DELAY_THRESHOLD">delay_threshold</a>.
        The default value for log_standby_delay is 'none'.
        You need to reload pgpool.conf if you change this directive.
        </p>
      </td>
    </tr>
    {/if}

    {if paramExists('syslog_facility')}
    <tr><th class="category" colspan="2">Syslog specific</th></tr>

    <tr>
      <th><label>{$message.descSyslog_facility|escape}</label>
      <p id="SYSLOG_FACILITY">syslog_facility (string) *</th>
      <td>
        <p>When logging to syslog is enabled, this parameter determines the syslog "facility" to be used.
        You can choose from LOCAL0, LOCAL1, LOCAL2, LOCAL3, LOCAL4, LOCAL5, LOCAL6, LOCAL7;
        the default is LOCAL0. See also the documentation of your system's syslog daemon.
        </p>
      </td>
    </tr>

    <tr>
      <th id="SYSLOG_IDENT"><label>{$message.descSyslog_ident|escape}</label>
      <p>syslog_ident (string) *</th>
      <td>
        <p>When logging to syslog is enabled, this parameter determines the program name
        used to identify PgPool messages in syslog logs. The default is pgpool.
        </p>
      </td>
    </tr>
    {/if}

    {if paramExists('debug_level')}
    <tr><th class="category" colspan="2">Debug</th></tr>

    <tr>
      <th id="DEBUG_LEVEL"><label>{$message.descDebug_level|escape}</label>
      <p>debug_level (integer)</th>
      <td>
        <p>
        Debug message verbosity level. 0 means no message, greater than 1
        means more verbose message. Default value is 0.
        </p>
      </td>
    </tr>
    {/if}

  </tbody>
  <tfoot>
    <tr>
      <td colspan="2"></td>
    </tr>
  </tfoot>
</table>


<h3><a name="file_locations">File Locations</a></h3>

<table>
  <thead>
    <tr>
      <th width="240">{$message.strParameter|escape}</th>
      <th>{$message.strDetail|escape}</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th id="LOGDIR"><label>{$message.descLogdir|escape}</label>
      <p>logdir (string) *</th>
      <td>
      <p>pgpool_status is written into this directory.</p>
      </td>
    </tr>

    {if paramExists('pid_file_name')}
    <tr>
      <th id="PID_FILE_NAME"><label>{$message.descPid_file_name|escape}</label>
      <p>pid_file_name (string) *</th>
      <td>
        <p>Full path to a file which contains pgpool's process id.
        Default is "/var/run/pgpool/pgpool.pid".
        </p>
      </td>
    </tr>
    {/if}

  </tbody>
  <tfoot>
    <tr>
      <td colspan="2"></td>
    </tr>
  </tfoot>
</table>


<h3><a name="connection_pooling">Connection Pooling</a></h3>
<table>
  <thead>
    <tr>
      <th width="240">{$message.strParameter|escape}</th>
      <th>{$message.strDetail|escape}</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th id="CONNECTION_CACHE"><label>{$message.descConnection_cache|escape}</label>
      <p>connection_cache (bool) *</th>
      <td>Caches connections to backends when set to true. Default is true.</td>
    </tr>

    <tr>
      <th id="RESET_QUERY_LIST"><label>{$message.descReset_query_list|escape}</label>
      <p>reset_query_list (string)</th>
      <td>
        <p>Specifies the SQL commands sent to reset the connection
        to the backend when exiting a session. Multiple commands can be
        specified by delimiting each by ";".
        Default is the following, but can be changed to suit your system.
<pre>
reset_query_list = 'ABORT; DISCARD ALL'
</pre>
        <p>
        Commands differ in each PostgreSQL versions. Here are the recommended settings.
        </p>

        <table>
        <thead><tr><th>PostgreSQL version</th><th>reset_query_list value</th></tr></thead>
        <tr><th>7.1 or before</th><td>ABORT</td></tr>
        <tr><th>7.2 to 8.2</th><td>ABORT; RESET ALL; SET SESSION AUTHORIZATION DEFAULT</td></tr>
        <tr><th>8.3 or later</th><td>ABORT; DISCARD ALL</td></tr>
        <tfoot><tr><td colspan="2"></td></tr></tfoot>
        </table>
        <p>"ABORT" is not issued when not in a transaction block for 7.4 or later.</p>
      </td>
    </tr>

  </tbody>
  <tfoot>
    <tr>
      <td colspan="2"></td>
    </tr>
  </tfoot>
</table>


<h3><a name="replication">Replication</a></h3>
<table>
  <thead>
    <tr>
      <th width="240">{$message.strParameter|escape}</th>
      <th>{$message.strDetail|escape}</th>
    </tr>
  </thead>
  <tbody>

    <tr>
      <th id="REPLICATION_MODE"><label>{$message.descReplication_mode|escape}</label>
      <p>replication_mode (bool) *</th>
      <td>
      <p>Setting to true enables replication mode. Default is false.</p>
      </td>
    </tr>

    <tr>
      <th id="REPLICATE_SELECT"><label>{$message.descReplicate_select|escape}</label>
      <p>replicate_select (bool)</th>
      <td>
        <p>When set to true, pgpool-II replicates SELECTs in replication mode. If false,
        pgpool-II only sends them to the Master DB. Default is false.
        </p>
        <p>
        If a SELECT query is inside an explicit transaction block, replicate_select and
        <a href="#LOAD_BALANCE_MODE">load_balance_mode</a> will have an effect on how replication works.
        Details are shown below.
        </p>

        <table>
        <thead><tr><td colspan="9"></td></tr></thead>

        <tr>
        <th class="nodec">SELECT is inside a transaction block</th>
        <td>Y</td><td>Y</td><td>Y</td><td>N</td><td>N</td><td>N</td><td>Y</td><td>N</td>
        </tr>

        <tr>
        <th class="nodec">replicate_select is true</th>
        <td>Y</td><td>Y</td><td>N</td><td>N</td><td>Y</td><td>Y</td><td>N</td><td>N</td>
        </tr>

        <tr>
        <th class="nodec">load_balance_mode is true</th>
        <td>Y</td><td>N</td><td>N</td><td>N</td><td>Y</td><td>N</td><td>Y</td><td>Y</td>
        </tr>

        <tr>
        <th class="nodec">results(R:replication, M: send only to master, L: load balance)</th>
        <td>R</td><td>R</td><td>M</td><td>M</td><td>R</td><td>R</td><td>M</td><td>L</td>
        </tr>

        <tfoot><tr><td colspan="9"></td></tr></tfoot>
        </table>
      </td>
    </tr>

    <tr>
      <th><label>{$message.descInsert_lock|escape}</label>
      <p>insert_lock (bool)</th>
      <td>
        <p>If replicating a table with SERIAL data type, the SERIAL column value may differ between the backends.
        This problem is avoidable by locking the table explicitly
        (although, transactions' parallelism will be severely degraded).
        To achieve this, however, the following change must be made:
        </p>
<pre>
INSERT INTO ...
</pre>
        <p>
        to
        </p>
<pre>
BEGIN;
LOCK TABLE ...
INSERT INTO ...
COMMIT;
</pre>
        <p>When <code>insert_lock</code> is true, pgpool-II automatically adds
        the above queries each time an INSERT is executed
        (if already in transaction, it simply adds LOCK TABLE ....).
        </p>
        <p>pgpool-II 2.2 or later, it automatically detects whether the table
        has a SERIAL columns or not, so it will never lock the table if it does not use SERIAL columns.
        </p>
        <p>Default value is false.</p>
      </td>
    </tr>

    {if paramExists('lobj_lock_table')}
    <tr>
      <th id="LOBJ_LOCK_TABLE"><label>{$message.descLobj_lock_table|escape}</label>
      <p>lobj_lock_table (string)</th>
      <td>
        <p>
        This parameter specifies a table name used for large object replication control.
        If it is specified, pgpool will lock the table specified by
        lobj_lock_table and generate a large object id by looking into
        pg_largeobject system catalog and then call lo_create to create the large object.
        This procedure guarantees that pgpool will get the same large object id in all DB
        nodes in replication mode.
        </p>
        <p>
        The table specified by lobj_lock_table must be created beforehand. If
        you create the table in template1, any database created afterward will have it.
        </p>
        <p>
        If lobj_lock_table has empty string(''), the feature is disabled
        (thus large object replication will not work). The default value for
        lobj_lock_table is ''.
        </p>
      </td>
    </tr>
    {/if}

   <tr><th class="category" colspan="2">Degenerate handling</th></tr>

    <tr>
      <th id="REPLICATION_STOP_ON_MISMATCH"><label>{$message.descReplication_stop_on_mismatch|escape}</label>
      <p>replication_stop_on_mismatch (bool)</th>
      <td>
        <p>When set to true, if all backends don't return the same packet kind,
        the backends that differ from most frequent result set are degenerated.
        </p>
        <p>
        A typical use case is a SELECT statement being part of a transaction,
        <a href="#REPLICATE_SELECT">replicate_select</a> set to true,
        and SELECT returning a different number of rows among backends.
        Non-SELECT statements might trigger this though.
        For example, a backend succeeded in an UPDATE, while others failed.
        Note that pgpool does NOT examine the content of records returned by SELECT.
        </p>
        <p>
        If set to false, the session is terminated and the backends are not degenerated.
        Default is false.</p>
      </td>
    </tr>

    {if paramExists('failover_if_affected_tuples_mismatch')}
    <tr>
      <th id="FAILOVER_IF_AFFECTED_TUPLES_MISMATCH"><label>{$message.descFailover_if_affected_tuples_mismatch|escape}</label>
      <p>failover_if_affected_tuples_mismatch (bool)</th>
      <td>
        <p>When set to true, if backends don't return the same number of affected
        tuples during an INSERT/UPDATE/DELETE,
        the backends that differ from most frequent result set are degenerated.
        If the frequencies are same, the group which includes master DB node
        (a DB node having the youngest node id) is remained and other groups are degenerated.
        </p>
        <p>
        If set to false, the session is terminated and the backends are not
        degenerated. Default is false.</p>
      </td>
    </tr>
    {/if}

    {if paramExists('fail_over_on_backend_error')}
    <tr>
      <th id="FAIL_OVER_ON_BACKEND_ERROR"><label>{$message.descFail_over_on_backend_error|escape}</label>
      <p>fail_over_on_backend_error</th>
      <td>
        <p>
        If true, and an error occurs when reading/writing to the backend communication,
        pgpool-II will trigger the fail over procedure.
        If set to false, pgpool will report an error and disconnect the session.
        If you set this parameter to off, it is recommended that you turn on health checking.
        Please note that even if this parameter is set to off, however, pgpool will also do the fail over when
        pgpool detects the administrative shutdown of postmaster.
        </p>
      </td>
    </tr>
    {/if}

  </tbody>
  <tfoot>
    <tr>
      <td colspan="2"></td>
    </tr>
  </tfoot>
</table>


<h3><a name="load_balancing_mode" id="load_balancing_mode">Load Balancing Mode</a></h3>

<table>
  <thead>
    <tr>
      <th width="240">{$message.strParameter|escape}</th>
      <th>{$message.strDetail|escape}</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th id="LOAD_BALANCE_MODE"><label>{$message.descLoad_balance_mode|escape}</label>
      <p>load_balance_mode (bool) *</th>
      <td>
        <p>When set to true, SELECT queries will be
        distributed to each backend for load balancing. Default is false.</p>
      </td>
    </tr>

    <tr>
      <th id="IGNORE_LEADING_WHITE_SPACE"><label>{$message.descIgnore_leading_white_space|escape}</label>
      <p>ignore_leading_white_space (bool)</th>
      <td>
        <p>pgpool-II ignores white spaces at the beginning of SQL
        queries while in the load balance mode. It is useful if used with
        APIs like DBI/DBD:Pg which adds white spaces against the user's will.
        </p>
      </td>
    </tr>

    {if paramExists('white_function_list')}
    <tr>
      <th id="WHITE_FUNCTION_LIST"><label>{$message.descWhite_function_list|escape}</label>
      <p>white_function_list (string)</th>
      <td>
        <p>
        Specify a comma separated list of function names that <strong>do not</strong>
        update the database. SELECTs using functions not specified in this list are
        neither load balanced, nor replicated if in replication mode.
        In master slave mode, such SELECTs are sent to master (primary) only.
        </p>
        <p>You can use regular expression into the list to match function name,
        for example if you have prefixed all your read only function with 'get_' or 'select_'
        </p>
<pre>
white_function_list = 'get_.*,select_.*'
</pre>
      </td>
    </tr>

    <tr>
      <th id="BLACK_FUNCTION_LIST"><label>{$message.descBlack_function_list|escape}</label>
      <p>black_function_list (string)</th>
      <td>
        <p>
        Specify a comma separated list of function names that <strong>do</strong>
        update the database. SELECTs using functions specified in this list are neither
        load balanced, nor replicated if in replication mode.
        In master slave mode, such SELECTs are sent to master(primary) only.
        </p>
        <p>You can use regular expression into the list to match function name,
        for example if you have prefixed all your updating functions with 'set_', 'update_', 'delete_' or 'insert_':
        </p>
<pre>
black_function_list = 'nextval,setval,set_.*,update_.*,delete_.*,insert_.*'
</pre>
        <p>
        Only one of these two lists can be filled in a configuration.
        </p>
        <p>
        Prior to pgpool-II 3.0, nextval() and setval() were known to do
        writes to the database. You can emulate this by using white_function_list and
        black_function_list:
        </p>
<pre>
white_function_list = ''
black_function_list = 'nextval,setval,lastval,currval'
</pre>
        <p>
        Please note that we have lastval and currval in addition to nextval and setval.
        Though lastval() and currval() are not writing functions,
        it is wise to add lastval() and currval() to avoid errors
        in the case when these functions are accidentaly load balanced to other DB node.
        Because adding to black_function_list will prevent load balancing.
        </p>
      </td>
    </tr>
    {/if}

  </tbody>
  <tfoot>
    <tr>
      <td colspan="2"></td>
    </tr>
  </tfoot>
</table>


<h3><a name="master_slave_mode" id="master_slave_mode">Master/Slave Mode</a></h3>

<table>
  <thead>
    <tr>
      <th width="240">{$message.strParameter|escape}</th>
      <th>{$message.strDetail|escape}</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th id="MASTER_SLAVE_MODE"><label>{$message.descMaster_slave_mode|escape}</label>
      <p>master_slave_mode *</th>
      <td>
      <p>
      If true, use to couple pgpool-II with another master/slave
      replication software (like Slony-I and Streaming replication), which is responsible
      for doing the actual data replication.
      </p>
      </td>
      </td>
    </tr>

    {if paramExists('sr_check_period')}
    <tr><th class="category" colspan="2">Streaming</th></tr>

    <tr>
     <th id="SR_CHECK_PERIOD"><label>{$message.descSr_check_period|escape}</label>
      <p>sr_check_period (integer) *</th>
      <td>
        <p>
        This parameter specifies the interval between the streaming replication
        delay checks in seconds. Default is 0, which means the check is disabled.
        </p>
      </td>
    </tr>

    <tr>
     <th id="SR_CHECK_USER"><label>{$message.descSr_check_user|escape}</label>
      <p>sr_check_user (string) *</th>
      <td>
        <p>
        The user name to perform streaming replication check. This user must
        exist in all the PostgreSQL backends.
        Otherwise, the check causes an error.
        Note that sr_check_user and sr_check_password are used even sr_check_period is 0.
        To identify the primary server, pgpool-II sends function call request to each backend.
        sr_check_user and sr_check_password are used for this session.
        </p>
      </td>
    </tr>

    <tr>
     <th id="SR_CHECK_PASSWORD"><label>{$message.descSr_check_password|escape}</label>
      <p>sr_check_password (string) *</th>
      <td>
        <p>
        The password of the user to perform streaming replication check.
        If no password is required, specify empty string('').
        </p>
      </td>
    </tr>
    {/if}

    {if paramExists('delay_threshold')}
    <tr>
     <th id="DELAY_THRESHOLD"><label>{$message.descDelay_threshold|escape}</label>
      <p>delay_threshold (integer)</th>
      <td>
        <p>
        Specifies how to log the replication delay.
        If 'none' is specified, no log is written.
        If 'always', log the delay every time health checking is performed.
        If 'if_over_threshold' is specified, the log is written when the delay
        exceeds <a href="#DELAY_THRESHOLD">delay_threshold</a>.
        The default value for log_standby_delay is 'none'.
        You need to reload pgpool.conf if you change this directive.
        </p>
      </td>
    </tr>
    {/if}

    {if paramExists('follow_master_command')}
    <tr><th class="category" colspan="2">Special commands</th></tr>
    <tr>
     <th id="FOLLOW_MASTER_COMMAND"><label>{$message.descFollow_master_command|escape}</label>
      <p>follow_master_command (string) *</th>
      <td>
        <p>
        This parameter specifies a command to run in master/slave streaming replication mode 
        only after a master failover.
        pgpool-II replaces the following special characters with backend specific information.
        </p>

        <table>
        <thead><tr><th>Special character</th><th>Description</th></tr></thead>
        <tr><td>%d</td><td>Backend ID of a detached node.</td></tr>
        <tr><td>%h</td><td>Hostname of a detached node.</td></tr>
        <tr><td>%p</td><td>Port number of a detached node.</td></tr>
        <tr><td>%D</td><td>Database cluster directory of a detached node.</td></tr>
        <tr><td>%M</td><td>Old master node ID.</td></tr>
        <tr><td>%m</td><td>New master node ID.</td></tr>
        <tr><td>%H</td><td>Hostname of the new master node.</td></tr>
        <tr><td>%P</td><td>Old primary node ID.</td></tr>
        <tr><td>%%</td><td>'%' character</td></tr>
        <tfoot><tr><td colspan="2"></td></tr></tfoot>
        </table>

        <p>
        You need to reload pgpool.conf if you change follow_master_command.
        </p>
        <p>
        If follow_master_command is not empty, when a master failover is
        completed in master/slave streaming replication,
        pgpool degenerate all nodes excepted the new master and starts new child processes
        to be ready again to accept connections from clients.
        After this, pgpool run the command set into the 'follow_master_command' for each 
        degenerated nodes. Typically the command should be used to recover the slave from the new master
        by call the <a href="#pcp_recovery_node">pcp_recovery_node</a> command for example.
        </p>
      </td>
     </tr>
     {/if}
  </tbody>
  <tfoot>
    <tr>
      <td colspan="2"></td>
    </tr>
  </tfoot>
</table>



<h3><a name="parallel_mode" id="parallel_mode">Parallel Mode and Query Cache</a></h3>

<table>
  <thead>
    <tr>
      <th width="240">{$message.strParameter|escape}</th>
      <th>{$message.strDetail|escape}</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th id="PARALLEL_MODE"><label>{$message.descParallel_mode|escape}</label>
      <p>parallel_mode *</th>
      <td>
      <p>
      If true, activate parallel execution of queries.
      Tables can be split, and data distributed to each node.
      Moreover, the replication and the load balancing features can be used at the same time.
      </p>
      </td>
    </tr>

    {if paramExists('enable_query_cache')}
    <tr>
      <th id="ENABLE_QUERY_CACHE"><label>{$message.descEnable_query_cache|escape}</label>
      <p>enable_query_cache *</th>
      <td>
        <p>
        If true, the Query cache can be used in all modes in pgpool-II.
        The query cache allow to reuse the SELECT result to boost the performance.
        </p>
      </td>
    </tr>
    {/if}

    <tr>
      <th id="PGPOOL2_HOSTNAME"><label>{$message.descPgpool2_hostname|escape}</label>
      <p>pgpool2_hostname (string) *</th>
      <td>
      <p>Where pgpool works.</p>
      </td>
    </tr>

   <tr><th class="category" colspan="2">System DB info</th></tr>

    <tr>
      <th id="SYSTEM_DB_HOSTNAME"><label>{$message.descSystem_db_hostname|escape}</label>
      <p>system_db_hostname (string) *</th>
      <td>
        <p>The hostname where the System DB is.
        Specifying the empty string ('') means the System DB is on the same host as
        pgpool-II, and will be accessed via a UNIX domain socket.
        Default is 'localhost'.</p>
      </td>
    </tr>

    <tr>
      <th id="SYSTEM_DB_PORT"><label>{$message.descSystem_db_port|escape}</label>
      <p>system_db_port (integer) *</th>
      <td>
      <p>The port number for the System DB. Default is 5432.</p>
      </td>
    </tr>

    <tr>
      <th id="SYSTEM_DB_DBNAME"><label>{$message.descSystem_db_dbname|escape}</label>
      <p>system_db_dbname (string) *</th>
      <td>
        <p>The partitioning rules and other information will be defined
        in the database specified here.
        Default is 'pgpool'.
      </td>
    </tr>

    <tr>
      <th id="SYSTEM_DB_SCHEMA"><label>{$message.descSystem_db_schema|escape}</label>
      <p>system_db_schema (string) *</th>
      <td>
        <p>The partitioning rules and other information will be defined
        in the schema specified here. Default value is:
        <code>'pgpool_catalog'</code>.</p>
      </td>
    </tr>

    <tr>
      <th id="SYSTEM_DB_USER"><label>{$message.descSystem_db_user|escape}</label>
      <p>system_db_user (string) *</th>
      <td>
      <p>The username to connect to the System DB. Default is 'pgpool'.</p>
      </td>
    </tr>

    <tr>
      <th id="SYSTEM_DB_PASSWORD"><label>{$message.descSystem_db_password|escape}</label>
      <p>system_db_password (string) *</th>
      <td>
        <p>The password for the System DB. If no password is necessary,
        set the empty string ('').</p>
      </td>
    </tr>
  </tbody>
  <tfoot>
    <tr>
      <td colspan="2"></td>
    </tr>
  </tfoot>
</table>


<h3><a name="health-check">Health Check</a></h3>

<table>
  <thead>
    <tr>
      <th width="240">{$message.strParameter|escape}</th>
      <th>{$message.strDetail|escape}</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th id="HEALTH_CHECK_TIMEOUT"><label>{$message.descHealth_check_timeout|escape}</label>
      <p>health_check_timeout (integer)</th>
      <td>
        <p>pgpool-II periodically tries to connect to the backends
        to detect any error on the servers or networks.
        This error check procedure is called "health check".
        If an error is detected, pgpool-II tries to perform failover or degeneration.
        </p>
        <p>
        This parameter serves to prevent the health check from waiting for a long
        time in a case such as un unplugged network cable.
        The timeout value is in seconds. Default value is 20.
        0 disables timeout (waits until TCP/IP timeout).
        </p>
        <p>
        This health check requires one extra connection to each backend,
        so <code>max_connections</code> in the
        <code>postgresql.conf</code> needs to be incremented as needed.
        </p>
      </td>
    </tr>

    <tr>
      <th id="HEALTH_CHECK_PERIOD"><label>{$message.descHealth_check_period|escape}</label>
      <p>health_check_period (integer)</th>
      <td>
        <p>This parameter specifies the interval between the health
        checks in seconds. Default is 0, which means health check is disabled.
        </p>
      </td>
   </tr>

    <tr>
      <th id="HEALTH_CHECK_USER"><label>{$message.descHealth_check_user|escape}</label>
      <p>health_check_user (string)</th>
      <td>
        <p>The user name to perform health check.
        This user must exist in all the PostgreSQL backends.
        Otherwise, health check causes an error.
        </p>
      </td>
    </tr>

    {if paramExists('health_check_password')}
    <tr>
      <th id="HEALTH_CHECK_PASSWORD"><label>{$message.descHealth_check_password|escape}</label>
      <p>health_check_password (string)</th>
      <td>
        <p>The password of the user to perform health check.</p>
      </td>
    </tr>
    {/if}

    {if paramExists('health_check_max_retries')}
    <tr>
      <th id="HEALTH_CHECK_MAX_RETRIES"><label>{$message.descHealth_check_max_retries|escape}</label>
      <p>health_check_max_retries (integer)</th>
      <td>
        <p>The maximum number of times to retry a failed health check
        before giving up and initiating failover.
        This setting can be useful in spotty networks, when it is expected that health
        checks will fail occasionally even when the master is fine.
        Default is 0, which means do not retry.
        It is advised that you disable <a href="#FAIL_OVER_ON_BACKEND_ERROR">fail_over_on_backend_error</a>
        if you want to enable health_check_max_retries</dt>.
        </p>
      </td>
    </tr>
    {/if}

    {if paramExists('health_check_retry_delay')}
    <tr>
      <th id="HEALTH_CHECK_RETRY_DELAY"><label>{$message.descHealth_check_retry_delay|escape}</label>
      <p>health_check_retry_delay (integer)</th>
      <td>
        <p>
        The amount of time (in seconds) to sleep between failed health check
        retries (not used unless health_check_max_retries is &gt; 0).
        If 0, then retries are immediate (no delay).
        </p>
      </td>
    </tr>
    {/if}
  </tbody>
  <tfoot>
    <tr>
      <td colspan="2"></td>
    </tr>
  </tfoot>
</table>


<h3><a name="failover" id="failover">Failover and Failback</a></h3>

<table>
  <thead>
    <tr>
      <th width="240">{$message.strParameter|escape}</th>
      <th>{$message.strDetail|escape}</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th id="FAILOVER_COMMAND"><label>{$message.descFailover_command|escape}</label>
      <p>failover_command</th>
      <td>
        <p>
        This parameter specifies a command to run when a node is detached.
        pgpool-II replaces the following special characters with backend specific
        information.
        </p>

        <table>
        <thead><tr><th>Special character</th><th>Description</th></tr></thead>
        <tr><td>%d</td><td>Backend ID of a detached node.</td></tr>
        <tr><td>%h</td><td>Hostname of a detached node.</td></tr>
        <tr><td>%p</td><td>Port number of a detached node.</td></tr>
        <tr><td>%D</td><td>Database cluster directory of a detached node.</td></tr>
        <tr><td>%M</td><td>Old master node ID.</td></tr>
        <tr><td>%m</td><td>New master node ID.</td></tr>
        <tr><td>%H</td><td>Hostname of the new master node.</td></tr>
        <tr><td>%P</td><td>Old primary node ID.</td></tr>
        <tr><td>%%</td><td>'%' character</td></tr>
        <tfoot><tr><td colspan="2"></td></tr></tfoot>
        </table>

        <p>
        When a failover is performed, pgpool kills all its child processes, which
        will in turn terminate all active sessions to pgpool. Then pgpool invokes
        the failover_command and waits for its completion.
        After this, pgpool starts new child processes and is ready again to accept
        connections from clients.
        </p>
      </td>
    </tr>

    <tr>
      <th id="FAILBACK_COMMAND"><label>{$message.descFailback_command|escape}</label>
      <p>failback_command</th>
      <td>
        <p>
        This parameter specifies a command to run when a node is attached.
        pgpool-II replaces special the following characters with backend specific
        information.
        </p>

        <table>
        <thead><tr><th>Special character</th><th>Description</th></tr></thead>
        <tr><td>%d</td><td>Backend ID of an attached node.</td></tr>
        <tr><td>%h</td><td>Hostname of an attached node.</td></tr>
        <tr><td>%p</td><td>Port number of an attached node.</td></tr>
        <tr><td>%D</td><td>Database cluster path of an attached node.</td></tr>
        <tr><td>%M</td><td>Old master node</td></tr>
        <tr><td>%m</td><td>New master node</td></tr>
        <tr><td>%H</td><td>Hostname of the new master node.</td></tr>
        <tr><td>%P</td><td>Old primary node ID.</td></tr>
        <tr><td>%%</td><td>'%' character</td></tr>
        <tfoot><tr><td colspan="2"></td></tr></tfoot>
        </table>
      </td>
    </tr>
  </tbody>
  <tfoot>
    <tr>
      <td colspan="2"></td>
    </tr>
  </tfoot>
</table>



<h3><a name="online-recovery">Online Recovery</a></h3>
<table>
  <thead>
    <tr>
      <th width="240">{$message.strParameter|escape}</th>
      <th>{$message.strDetail|escape}</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th id="RECOVERY_USER"><label>{$message.descRecovery_user|escape}</label>
      <p>recovery_user (string)</th>
      <td>
      <p>
      This parameter specifies a PostgreSQL username for online recovery.
      Default is 'nobody'.
      </p>
      </td>
    </tr>

    <tr>
      <th id~"RECOVERY_PASSWORD"><label>{$message.descRecovery_password|escape}</label>
      <p>recovery_password (string)</th>
      <td>
      <p>
      This parameter specifies a PostgreSQL password for online recovery.
      </p>
      </td>
   </tr>

    <tr>
      <th id="RECOVERY_1ST_STAGE"><label>{$message.descRecovery_1st_stage_command|escape}</label>
      <p>recovery_1st_stage_command (string)</th>
      <td>
        <p>
        This parameter specifies a command to be run by master(primary) PostgreSQL server
        at the first stage of online recovery.
        The command file must be put in the database cluster directory for security reasons.
        For example, if recovery_1st_stage_command = 'sync-command',
        then pgpool-II executes $PGDATA/sync-command.
        </p>
        <p>
        recovery_1st_stage_command will receive 3 parameters as follows:
        </p>
        <ol>
            <li>path to master(primary) database cluster</li>
            <li>PostgreSQL host name to be recovered</li>
            <li>path to database cluster to be recovered</li>
        </ol>
        <p>
        Note that pgpool-II <b>accepts</b> connections and queries while
        recovery_1st_stage command is executed. You can retrieve and update data during this stage.
        </p>
      </td>
    </tr>

    <tr>
      <th id="RECOVERY_2ND_STAGE"><label>{$message.descRecovery_2nd_stage_command|escape}</label>
      <p>recovery_2nd_stage_command (string)</th>
      <td>
        <p>
        This parameter specifies a command to be run by master(primary) PostgreSQL server
        at the second stage of online recovery.
        The command file must be put in the database cluster directory for security reasons.
        For example, if recovery_2nd_stage_command = 'sync-command', then
        pgpool-II executes $PGDATA/sync-command.
        </p>
        <p>
        recovery_2nd_stage_command will receive 3 parameters as follows:
        </p>
        <ol>
            <li>path to master(primary) database cluster</li>
            <li>PostgreSQL host name to be recovered</li>
            <li>path to database cluster to be recovered</li>
        </ol>
        </p>
        <p>
        Note that pgpool-II <b>does not accept</b> connections and queries while
        recovery_2nd_stage_command is running.
        Thus if a client stays connected for a long time,
        the recovery command won't be executed. pgpool-II waits
        until all clients have closed their connections. The command is only executed
        when no client is connected to pgpool-II anymore.
        </p>
      </td>
    </tr>

    <tr>
      <th id="RECOVERY_TIMEOUT"><label>{$message.descRecovery_timeout|escape}</label>
      <p>recovery_timeout (integer)</th>
      <td>
        <p>
        pgpool does not accept new connections during the second stage. If a client
        connects to pgpool during recovery processing, it will have to wait for the end  of the recovery.
        </p>
        <p>
        This parameter specifies recovery timeout in sec. If this timeout is reached,
        pgpool cancels online recovery and accepts connections. 0 means no wait.
        </p>
      </td>
    </tr>

    {if paramExists('client_idle_limit_in_recovery')}
    <tr>
      <th id="CLIENT_IDLE_LIMIT_IN_RECOVERY"><label>{$message.descClient_idle_limit_in_recovery|escape}</label>
      <p>client_idle_limit_in_recovery (integer)</th>
      <td>
        <p> Similar to client_idle_limit but only takes effect in the second
        stage of recovery. A client being idle for client_idle_limit_in_recovery
        seconds since its last query will get disconnected.
        This is useful for preventing the pgpool recovery from being
        disturbed by a lazy client or if the TCP/IP connection between the client
        and pgpool is accidentally down (a cut cable for instance).
        If set to -1, disconnect the client immediately.
        The default value for client_idle_limit_in_recovery is 0,
        which means the feature is turned off.
        </p>
        <p>
        If your clients are very busy, pgpool-II cannot enter the second stage of
        recovery whatever value of client_idle_limit_in_recovery you may choose.
        In this case, you can set client_idle_limit_in_recovery to -1
        so that pgpool-II immediately disconnects such busy clients before entering the second stage.
        </p>
      </td>
    </tr>
    {/if}

  </tbody>
  <tfoot>
    <tr>
      <td colspan="2"></td>
    </tr>
  </tfoot>
</table>


{if hasMemqcache()}
<h3><a name="memqcache" id="memqcache">On Memory Query Cache</a></h3>

<table>
  <thead>
    <tr>
      <th width="240">{$message.strParameter|escape}</th>
      <th>{$message.strDetail|escape}</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th id="MEMORY_CACHE_ENABLED"><label>{$message.descMemory_cache_enabled|escape}</label>
      <p>memory_cache_enabled (bool)</th>
      <td>
        <p>
        To enable the memory cache functionality, set this to on (default is off).
        </p>
      </td>
    </tr>

    <tr>
      <th id="MEMQCACHE_METHOD"><label>{$message.descMemqcache_method|escape}</label>
      <p>memqcache_method (string) *</th>
      <td>
        <p>
        You can choose a cache strage: shared memory or <a href="http://memcached.org">memcached</a>
        (you can't use the both).
        Query cache with shared memory is fast and easy because you don't have to install and config memcached,
        but restricted the max size of cache by the one of shared memory.
        Query cache with memcached needs a overhead to access network, but you can set the size as you like.
        </p>
        <p>
        Memory cache behavior can be specified by memqcache_method directive.
        Either "shmem"(shared memory) or "memcached". Default is shmem.
        </p>
      </td>
    </tr>

    <tr><th class="category" colspan="2">Memcached specific</th></tr>

    <tr>
      <th id="MEMQCACHE_MEMCACHED_HOST"><label>{$message.descMemqcache_memcached_host|escape}</label>
      <p>memqcache_memcached_host (string) *</th>
      <td>
        <p>
        Specify the host name or the IP adddress in which memcached works.
        If it is the same one as pgpool-II, set 'localhost'.
        </p>
      </td>
    </tr>

    <tr>
      <th id="MEMQCACHE_MEMCACHED_PORT"><label>{$message.descMemqcache_memcached_port|escape}</label>
      <p>memqcache_memcached_port (integer) *</th>
      <td>
        <p>
        Specify the port number of memcached. Default is 11211.
        </p>
      </td>
    </tr>

    <tr><th class="category" colspan="2">Shared memory specific</th></tr>

    <tr>
      <th id="MEMQCACHE_TOTAL_SIZE"><label>{$message.descMemqcache_total_size|escape}</label>
      <p>memqcache_total_size (integer) *</th>
      <td>
        <p>
        Specify the size of shared memory as cache strage in bytes.
        </p>
      </td>
    </tr>

    <tr>
      <th id="MEMQCACHE_MAX_NUM_CACHE"><label>{$message.descMemqcache_max_num_cache|escape}</label>
      <p>memqcache_max_num_cache (integer) *</th>
      <td>
        <p>
        Specify the number of cache entries.
        This is used to define the size of cache management space
        (you need this in addition to <a href="#MEMQCACHE_TOTAL_SIZE">memqcache_total_size</a>).
        The management space size can be calculated by:
        <a href="#MEMQCACHE_MAX_NUM_CACHE">memqcache_max_num_cache</a> * 48 bytes.
        Too small number will cause an error while registering cache.
        On the other hand too large number is just a waste of space.
        </p>
      </td>
    </tr>

    <tr>
      <th id="MEMQCACHE_CACHE_BLOCK_SIZE"><label>{$message.descMemqcache_cache_block_size|escape}</label>
      <p>memqcache_cache_block_size (integer) *</th>
      <td>
        <p>
        If cache storage is shared memory, pgpool uses the memory devided by memqcache_cache_block_size.
        SELECT result is packed into the block.
        However because the SELECT result cannot be placed in several blocks, it cannot be cached if it is larger
        than memqcache_cache_block_size.
        memqcache_cache_block_size must be greater or equal to 512.
        </p>
      </td>
    </tr>

    <tr><th class="category" colspan="2">Common</th></tr>

    <tr>
      <th id="MEMQCACHE_EXPIRE"><label>{$message.descMemqcache_expire|escape}</label>
      <p>memqcache_expire (integer) *</th>
      <td>
        <p>
        If the size of a SELECT result is larger than memqcache_maxcache bytes,
        </p>
        <p>
        To avoid this problem, you have to set memqcache_maxcache larger.
        But if you use shared memory as the cache strage,
        it must be lower than <a href="#MEMQCACHE_CACHE_BLOCK_SIZE">memqcache_cache_block_size</a>.
        If memqcached, it must be lower than the size of slab (default is 1 MB).
        </p>
      </td>
    </tr>

    <tr>
      <th id="MEMQCACHE_MAXCACHE"><label>{$message.descMemqcache_maxcache|escape}</label>
      <p>memqcache_maxcache (integer) *</th>
      <td>
        <p>
        If the size of a SELECT result is larger than memqcache_maxcache bytes.
        </p>
        <p>
        To avoid this problem, you have to set memqcache_maxcache larger.
        But if you use shared memory as the cache strage,
        it must be lower than <a href="#MEMQCACHE_CACHE_BLOCK_SIZE">memqcache_cache_block_size</a>.
        If memqcached, it must be lower than the size of slab (default is 1 MB).
        </p>
      </td>
    </tr>

    <tr>
      <th id="MEMQCACHE_AUTO_CACHE_INVALIDATION"><label>{$message.descMemqcache_auto_cache_invalidation|escape}</label>
      <p>memqcache_auto_cache_invalidation (bool) *</th>
      <td>
        <p>
        If on, automatically deletes cache realted to the updated tables.
        If off, does not delete caches. Default is on.
        This parameter and <a href="#MEMQCACHE_EXPIRE">memqcache_expire</a>. are orthogonal.
        </p>
      </td>
    </tr>

    <tr>
      <th id="MEMQCACHE_OIDDIR"><label>{$message.descMemqcache_oiddir|escape}</label>
      <p>memqcache_oiddir (string) *</th>
      <td>
        <p>
        Full path to the directory where oids of tables used by SELECTs are stored.
        Under memqcache_oiddir there are directories named database oids,
        and under each of them there are files named table oids used by SELECTs.
        In the file pointers to query cache are stored.
        They are used as keys to delete caches.
        </p>
        <p>
        Directories and files under memqcache_oiddir are deleted whenever pgpool-II restarts.
        </p>
      </td>
    </tr>

    <tr>
      <th id="WHITE_MEMQCACHE_TABLE_LIST"><label>{$message.descWhite_memqcache_table_list|escape}</label>
      <p>white_memqcache_table_list (string)</th>
      <td>
        <p>
        Specify a comma separated list of table names whose SELECT results are to be cached even if
        they are VIEWs or unlogged tables. You can use regular expression.
        </p>
        <p>
        TABLEs and VIEWs in both of white_memqcache_table_list and
        <a href="#BLACK_MEMQCACHE_TABLE_LIST">black_memqcache_table_list</a> are cached.
        </p>
      </td>
    </tr>

    <tr>
      <th id="BLACK_MEMQCACHE_TABLE_LIST"><label>{$message.descBlack_memqcache_table_list|escape}</label>
      <p>black_memqcache_table_list(string)</th>
      <td>
        <p>
        Specify a comma separated list of table names whose SELECT results are <strong>NOT</strong> to be cached.
        You can use regular expression.
        </p>
      </td>
    </tr>

  </tbody>
  <tfoot>
    <tr>
      <td colspan="2"></td>
    </tr>
  </tfoot>
</table>
{/if}


{if paramExists('relcache_expire')}
<h3><a name="others">Others</a></h3>

<table>
  <thead>
    <tr>
      <th width="240">{$message.strParameter|escape}</th>
      <th>{$message.strDetail|escape}</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th id="RELCACHE_EXPIRE"><label>{$message.descRelcache_expire|escape}</label>
      <p>relcache_expire (integer)</th>
      <td>
        <p>
         Life time of relation cache in seconds. 0 means no cache
         expiration(the default).
         The relation cache is used for cache the query result against PostgreSQL
         system catalog to obtain various information including table structures
         or if it's a temporary table or not. The cache is maintained in a pgpool
         child local memory and being kept as long as it survives.
         </p>
         <p>
         If someone modify the table by using ALTER TABLE or some such, the relcache
         is not consistent anymore.
         </p>
         <p>
         For this purpose, relcache_expiration controls the life time of the cache.
        </p>
      </td>
    </tr>

    {if paramExists('relcache_size')}
        <tr>
          <th id="RELCACHE_SIZE"><label>{$message.descRelcache_size|escape}</label>
          <p>relcache_size (integer)</th>
          <td>
          <p>Size of relation cache in seconds. Default is 256.
          If you see following message frequently, increase the number. </p>
<pre>
"pool_search_relcache: cache replacement happend"
</pre>
          </td>
        </tr>
    {/if}
  </tbody>
  <tfoot>
    <tr>
      <td colspan="2"></td>
    </tr>
  </tfoot>
</table>
{/if}

</div>
<hr class="hidden" />
<div id="footer">
{include file='footer.tpl'}
</div>
</body>
</html>
