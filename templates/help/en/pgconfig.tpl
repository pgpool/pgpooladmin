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
  <h3>{$message.strSummary|escape}</h3>
  The content of pgpool.conf that is the configuration file of pgpool set can be displayed and be changed. 
  <h3>{$message.strFeature|escape}</h3>
  Please input the value that wants to change and push the update button.
  <h3>Addition of A backend host</h3>
  Please push the add button when you want to add a new back end host. <br />
  It inputs in back end host's item and a new input column can be done, and input information on a new back end host there, please.<br />
  Please push the update button when input ends. 
  <h3>Deletion of backend host</h3>
  Please push the delete button at the right of the host setting when you want to delete the back end host who has registered. <br />
  <div id="submenu">
    <h3>Table of Contents</h3>
    <ul>
      <li><a href="#connections">Connections</a></li>
      <li><a href="#backends">Backends</a></li>
      <li><a href="#pcp">PCP</a></li>
      <li><a href="#logging">Logging</a></li>
      <li><a href="#replication">Replication</a></li>
      <li><a href="#health-check">Health Check</a></li>
	  <li><a href="#online-recovery">Online Recovery</a></li>
      <li><a href="#system-database">System Database</a></li>
      <li><a href="#others">Others</a></li>
    </ul>
  </div>
    <h3><a name="connections">Connections</a></h3>
    <table>
      <thead>
        <tr>
          <th>{$message.strParameter|escape}</th>
          <th>{$message.strDetail|escape}</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <th><label>{$message.descListen_addresses|escape}</label>
          <br>listen_addresses (string)</th>
          <td>
Specifies the addresses to listen on for TCP/IP connections.  Set to '*' for all configured IP interfaces, '' for no TCP/IP connections, or else to a specific IP address or host name.  The default is 'localhost'.  Note that connections via UNIX domain sockets are always allowed.
          </td>
        </tr>
        <tr>
          <th><label>{$message.descPort|escape}</label>
          <br>port (integer)</th>
          <td>The port number where pgpool is running on. Default value is 9999.</td>
        </tr>
        <tr>
          <th><label>{$message.descSocket_dir|escape}</label>
          <br>socket_dir (string)</th>
          <td>The directory of unix domain socket for PostgreSQL server. Default value is '/tmp'.</td>
        </tr>
        <tr>
          <th><label>{$message.descNum_init_children|escape}</label>
          <br>num_init_children (integer)</th>
          <td>number of pgpool process initially forked. Default value is 32.</td>
        </tr>
        <tr>
          <th><label>{$message.descMax_pool|escape}</label>
          <br>max_pool (integer)</th>
          <td>
number of connection pools each pgpool server process are keeping. pgpool will make a new connection if there's no user name and database name pair yet. Thus it is recommended that max_pool exceeds the number of such that possible pairs. If it exceeds, the oldest connection is discarded and the new connection uses the slot. The default value is 4.
		  </td>
        </tr>
        <tr>
          <th><label>{$message.descChild_life_time|escape}</label>
          <br>child_life_time (integer)</th>
          <td>Life of a idle child process in seconds. This will prevent unwanted memory leaks or other problems. Default is 300. Set it to 0 disables this feature.</td>
        </tr>
        <tr>
          <th><label>{$message.descConnection_life_time|escape}</label>
          <br>connection_life_time (integer)</th>
          <td>Life time for each idle connection in seconds. 0 means the life time is forever. The default value is 0.</td>
        <tr>
          <th><label>{$message.descChild_max_connections|escape}</label>
          <br>child_max_connections (integer)</th>
          <td> If child_max_connections connections were received, child exits. 0 means no exit. The default value is 0.</td>
        </tr>
        <tr>
          <th><label>{$message.descConnection_cache|escape}</label>
					<br>connection_cache</th>
          <td>If true, cache connections to PostgreSQL. Default value is true.</td>
        </tr>
        <tr>
          <th><label>{$message.descPgpool2_hostname|escape}</label>
          <br>pgpool2_hostname (string)</th>
		  <td>The host name that pgpool2 runs is specified.</td>
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
          <th>{$message.strParameter|escape}</th>
          <th>{$message.strDetail|escape}</th>
          <td></td>
        </tr>
      </thead>
      <tbody>
        <tr>
          <th><label>{$message.descBackend_socket_dir|escape}</label>
          <br>backend_socket_dir (string)</th>
          <td>The directory of unix domain socket for PostgreSQL server. Default value is '/tmp'.</td>
        </tr>
        <tr>
		  <th><label>{$message.descBackend_hostname|escape}</label><br />backend_hostname (string)</th>
		  <td>The host name that PostgreSQL runs is specified.</td>
        </tr>
		<tr>
    <th><label>{$message.descBackend_port|escape}</label>
    <br />backend_port (integer)</th>
		<td>It is a port number that postmaster is running.</td>
      </tr>
      <tr>
        <th><label>{$message.descBackend_weight|escape}</label><br />backend_weight (integer)</th>
		<td>The weight at the load balance mode is set by the value from 0 to 1. Relative weight is calculated and distributed from the value specified with all the back end servers. </td>
      </tr>
	  </tbody>
    </table>
    <h3><a name="pcp">PCP (pgpool Control Port)</a></h3>
    <table>
      <thead>
        <tr>
          <th>{$message.strParameter|escape}</th>
          <th>{$message.strDetail|escape}</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <th><label>{$message.descPcp_port|escape}</label>
          <br>pcp_port (integer)</th>
          <td>It is a port number to connect it with PCP. Default is 9898.</td>
        </tr>
        <tr>
          <th><label>{$message.descPcp_socket_dir|escape}</label>
          <br>pcp_socket_dir (string)</th>
		  <td>The directory of unix domain socket for PCP. Default value is '/tmp'.</td>
        </tr>
        <tr>
          <th><label>{$message.descPcp_timeout|escape}</label>
          <br>pcp_timeout (integer)</th>
		  <td>The time-out of the PCP command is set. The connection disconnect when there will not be response in this time. </td>
        </tr>
      </tbody>
      <tfoot>
        <tr>
          <td colspan="2"></td>
        </tr>
      </tfoot>
    </table>
    <h3><a name="logging">Logging</a></h3>
    <table>
      <thead>
        <tr>
          <th>{$message.strParameter|escape}</th>
          <th>{$message.strDetail|escape}</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <th><label>{$message.descLogdir|escape}</label>
          <br>logdir (string)</th>
		  <td>The directory name to store pgpool's log files. Currently only a file named pgpool.pid(has pgpool's process id) is stored. The default value for logdir is '/tmp'.</td>
        </tr>
        <tr>
          <th><label>{$message.descPrint_timestamp|escape}</label>
					<br>print_timestamp</th>
		  <td>If true timestamp is added to each log line. Default value is true.</td>
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
          <th>{$message.strParameter|escape}</th>
          <th>{$message.strDetail|escape}</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <th><label>{$message.descReplication_mode|escape}</label>
					<br>replication_mode</th>
		  <td>Set this true if you are going to use replication functionality. Default is false.</td>
        </tr>
        <tr>
          <th><label>{$message.descReplication_timeout|escape}</label>
          <br>replication_timeout (integer)</th>
		  <td>pgpool will abort the session if a node does not respond (due to a inter-node deadlock) within this milli seconds. if set to 0, timeout is disabled.</td>
        </tr>
        <tr>
          <th><label>{$message.descReplication_stop_on_mismatch|escape}</label>
					<br>replication_stop_on_mismatch</th>
		  <td>Stop replication mode on data mismatch between master and secondary. Default is false.</td>
		</tr>
        <tr>
          <th><label>{$message.descReset_query_list|escape}</label>
          <br>reset_query_list (string)</th>
		  <td>SQL command to initialize the connection when the session ends is delimited by ";".</td>
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
          <th>{$message.strParameter|escape}</th>
          <th>{$message.strDetail|escape}</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <th><label>{$message.descHealth_check_timeout|escape}</label>
          <br>health_check_timeout (integer)</th>
		  <td>pgpool does "health check" periodically to detect PostgreSQL servers down, network communication problems or as such. If something is going wrong, pgpool will automatically run into fail over or degeneration mode.</td>
        </tr>
        <tr>
          <th><label>{$message.descHealth_check_period|escape}</label>
          <br>health_check_period (integer)</th>
		  <td>Specifies the interval for next health checking. 0 means no health checking. The default is 0(i.e. no health checking).</td>
        </tr>
        <tr>
          <th><label>{$message.descHealth_check_user|escape}</label>
          <br>health_check_user (string)</th>
		  <td>PostgreSQL user name for the health checking.</td>
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
          <th>{$message.strParameter|escape}</th>
          <th>{$message.strDetail|escape}</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <th><label>{$message.descRecovery_user|escape}</label>
          <br>recovery_user (string)</th>
		  <td>A PostgreSQL user name to be used during online recovery process.</td>
        </tr>
        <tr>
          <th><label>{$message.descRecovery_password|escape}</label>
          <br>recovery_password (string)</th>
		  <td>"recovery_user"'s password to be used during online recovery process.</td>
        </tr>
        <tr>
          <th><label>{$message.descRecovery_1st_stage_command|escape}</label>
          <br>recovery_1st_stage_command (string)</th>
		  <td>Specifies a script name to be executed for the first stage of an online recovery process. The script needs to be placed in master node's database cluster($PGDATA) due to security issues.</td>
        </tr>
        <tr>
          <th><label>{$message.descRecovery_2nd_stage_command|escape}</label>
          <br>recovery_2nd_stage_command (string)</th>
		  <td>Specifies a script name to be executed for the second stage of an online recovery process. The script needs to be placed in master node's database cluster ($PGDATA) due to security issues.</td>
        </tr>
        <tr>
          <th><label>{$message.descRecovery_timeout|escape}</label>
          <br>recovery_timeout (integer)</th>
		  <td>Number of seconds to wait for online recovery to complete. Note that 0 means NO WAIT; not no timeout.</td>
        </tr>
      </tbody>
      <tfoot>
        <tr>
          <td colspan="2"></td>
        </tr>
      </tfoot>
    </table>
    <h3><a name="system-database">System Database</a></h3>
    <table>
      <thead>
        <tr>
          <th>{$message.strParameter|escape}</th>
          <th>{$message.strDetail|escape}</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <th><label>{$message.descSystem_db_hostname|escape}</label>
          <br>system_db_hostname (string)</th>
		  <td>The host name that system DB is operating is specified. It connects with Unix domain socket when not specifying it. </td>
        </tr>
        <tr>
          <th><label>{$message.descSystem_db_port|escape}</label>
          <br>system_db_port (integer)</th>
		  <td>The port number to connect system DB is specified.</td>
        </tr>
        <tr>
          <th><label>{$message.descSystem_db_dbname|escape}</label>
          <br>system_db_dbname (string)</th>
		  <td>The data base name of system DB is specified.</td>
        </tr>
        <tr>
          <th><label>{$message.descSystem_db_schema|escape}</label>
          <br>system_db_schema (string)</th>
		  <td>The schema name of system DB is specified.</td>
        </tr>
        <tr>
          <th><label>{$message.descSystem_db_user|escape}</label>
          <br>system_db_user (string)</th>
		  <td>The username connected with system DB is specified.</td>
        </tr>
        <tr>
          <th><label>{$message.descSystem_db_password|escape}</label>
          <br>system_db_password (string)</th>
		  <td>The password connected with system DB is specified. </td>
        </tr>
      </tbody>
      <tfoot>
        <tr>
          <td colspan="2"></td>
        </tr>
      </tfoot>
    </table>
    <h3><a name="others">Others</a></h3>
    <table>
      <thead>
        <tr>
          <th>{$message.strParameter|escape}</th>
          <th>{$message.strDetail|escape}</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <th><label>{$message.descLoad_balance_mode|escape}</label>
					<br>load_balance_mode</th>
		  <td>Perform load balancing for SELECT. Default is false.</td>
		</tr>
        <tr>
          <th><label>{$message.descMaster_slave_mode|escape}</label>
					<br>master_slave_mode</th>
		  <td>Run in master/slave mode. See 14 for more details. Default value is false. This mode is not compatible with replication_mode.</td>
		</tr>
        <tr>
          <th><label>{$message.descInsert_lock|escape}</label>
					<br>insert_lock</th>
		  <td>
If you replicate a table having SERIAL data type column, sometimes the serial value does not match between servers. You can avoid the problem by using a table lock (with a performance penalty due to
less currency in transactions). For this you need to rewrite you query:
<p>
INSERT INTO ....
</p>
<p>
to:
</p>
<p>
BEGIN;<br />
LOCK TABLE ...<br />
INSERT INTO ...<br />
COMMIT;
</p>
<p>
This is painfull. If you turn on insert_lock, pgpool will
automatically do the rewriting for you.
</p>
		  </td>
		</tr>
        <tr>
          <th><label>{$message.descIgnore_leading_white_space|escape}</label>
					<br>ignore_leading_white_space</th>
		  <td>If true, ignore leading white spaces of each query while pgpool judges if the query is a SELECT so that it can be load balanced. This is usefull for certain APIs such as DBI/DBD which is
   know as adding an extra leading white space.</td>
		</tr>
        <tr>
          <th><label>{$message.descParallel_mode|escape}</label>
					<br>parallel_mode</th>
		  <td>When pgpool runs on parallel mode, true is specified. It is necessary to specify a partitioning rule in this case. </td>
		</tr>
        <tr>
          <th><label>{$message.descLog_statement|escape}</label>
					<br>log_statement</th>
		  <td>If true, print all statements to the log.  Like the log_statement option to PostgreSQL, this allows for observing queries without engaging in full debugging.</td>
		</tr>
        <tr>
          <th><label>{$message.descEnable_query_cache|escape}</label>
					<br>enable_query_cache</th>
		  <td>When the result of SELECT is cached, it makes it to true.</td>
		</tr>
      </tbody>
      <tfoot>
        <tr>
          <td colspan="2"></td>
        </tr>
      </tfoot>
    </table>
</div>
<hr class="hidden" />
<div id="footer">
{include file='footer.tpl'}
</div>
</body>
</html>
