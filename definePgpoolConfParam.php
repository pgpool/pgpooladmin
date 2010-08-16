<?php

/* vim: set expandtab tabstop=4 shiftwidth=4 softtabstop=4: */

/**
 * Definition of pgpool variable
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

$pgpoolConfigParam = array();
$pgpoolConfigBackendParam = array();

$strreg = '^[0-9a-zA-Z_\-]+$';
$dirreg = '^\/[0-9a-zA-Z\._\/\-]+$';
$hostreg = "^[0-9a-zA-Z\._\-]*$";

$key = 'listen_addresses';
$pgpoolConfigParam[$key]['type'] ='C';
$pgpoolConfigParam[$key]['default'] ='localhost';
$pgpoolConfigParam[$key]['regexp'] = '^([0-9a-zA-Z\._\-]+|[\*]{1})$';

$key = 'port';
$pgpoolConfigParam[$key]['type'] ='N';
$pgpoolConfigParam[$key]['default'] ='9999';
$pgpoolConfigParam[$key]['max'] = 65535;
$pgpoolConfigParam[$key]['min'] = 1024;

$key = 'socket_dir';
$pgpoolConfigParam[$key]['type'] ='C';
$pgpoolConfigParam[$key]['default'] ='/tmp';
$pgpoolConfigParam[$key]['regexp'] = "$dirreg";

$key = 'backend_socket_dir';
$pgpoolConfigParam[$key]['type'] ='C';
$pgpoolConfigParam[$key]['default'] ='/tmp';
$pgpoolConfigParam[$key]['regexp'] = "$dirreg";

$key = 'num_init_children';
$pgpoolConfigParam[$key]['type'] ='N';
$pgpoolConfigParam[$key]['default'] ='32';
$pgpoolConfigParam[$key]['min'] = 1;
$pgpoolConfigParam[$key]['max'] = 65535;

$key = 'max_pool';
$pgpoolConfigParam[$key]['type'] ='N';
$pgpoolConfigParam[$key]['default'] ='4';
$pgpoolConfigParam[$key]['min'] = 1;
$pgpoolConfigParam[$key]['max'] = 65535;

$key = 'child_life_time';
$pgpoolConfigParam[$key]['type'] ='N';
$pgpoolConfigParam[$key]['default'] ='300';
$pgpoolConfigParam[$key]['min'] = 0;
$pgpoolConfigParam[$key]['max'] = 65535;

$key = 'connection_life_time';
$pgpoolConfigParam[$key]['type'] ='N';
$pgpoolConfigParam[$key]['default'] ='0';
$pgpoolConfigParam[$key]['min'] = 0;
$pgpoolConfigParam[$key]['max'] = 65535;

$key = 'child_max_connections';
$pgpoolConfigParam[$key]['type'] ='N';
$pgpoolConfigParam[$key]['default'] ='0';
$pgpoolConfigParam[$key]['min'] = 0;
$pgpoolConfigParam[$key]['max'] = 65535;

$key = 'client_idle_limit';
$pgpoolConfigParam[$key]['type'] ='N';
$pgpoolConfigParam[$key]['default'] ='0';
$pgpoolConfigParam[$key]['min'] = 0;
$pgpoolConfigParam[$key]['max'] = 65535;

$key = 'authentication_timeout';
$pgpoolConfigParam[$key]['type'] ='N';
$pgpoolConfigParam[$key]['default'] ='60';
$pgpoolConfigParam[$key]['min'] = 0;
$pgpoolConfigParam[$key]['max'] = 10000;

$key = 'logdir';
$pgpoolConfigParam[$key]['type'] ='C';
$pgpoolConfigParam[$key]['default'] ='/tmp';
$pgpoolConfigParam[$key]['regexp'] = "$dirreg";

$key = 'pid_file_name';
$pgpoolConfigParam[$key]['type'] ='C';
$pgpoolConfigParam[$key]['default'] ='/var/run/pgpool/pgpool.pid';
$pgpoolConfigParam[$key]['regexp'] = "$dirreg";

$key = 'pcp_timeout';
$pgpoolConfigParam[$key]['type'] ='N';
$pgpoolConfigParam[$key]['default'] ='10';
$pgpoolConfigParam[$key]['min'] = 0;
$pgpoolConfigParam[$key]['max'] = 65535;

$key = 'replication_mode';
$pgpoolConfigParam[$key]['type'] ='B';
$pgpoolConfigParam[$key]['default'] =false;

$key = 'replication_timeout';
$pgpoolConfigParam[$key]['type'] ='N';
$pgpoolConfigParam[$key]['default'] =5000;
$pgpoolConfigParam[$key]['min'] = 0;
$pgpoolConfigParam[$key]['max'] = 65535;

$key = 'load_balance_mode';
$pgpoolConfigParam[$key]['type'] ='B';
$pgpoolConfigParam[$key]['default'] =false;

$key = 'replication_stop_on_mismatch';
$pgpoolConfigParam[$key]['type'] ='B';
$pgpoolConfigParam[$key]['default'] =false;

$key = 'replicate_select';
$pgpoolConfigParam[$key]['type'] ='B';
$pgpoolConfigParam[$key]['default'] =false;

$key = 'reset_query_list';
$pgpoolConfigParam[$key]['type'] ='C';
$pgpoolConfigParam[$key]['default'] ='ABORT; DISCARD ALL';
$pgpoolConfigParam[$key]['regexp'] = "^[0-9a-zA-Z; ]+$";

$key = 'white_function_list';
$pgpoolConfigParam[$key]['type'] ='C';
$pgpoolConfigParam[$key]['default'] ='';
$pgpoolConfigParam[$key]['regexp'] = "^[0-9a-zA-Z,]*$";

$key = 'black_function_list';
$pgpoolConfigParam[$key]['type'] ='C';
$pgpoolConfigParam[$key]['default'] ='';
$pgpoolConfigParam[$key]['regexp'] = "^[0-9a-zA-Z,]*$";

$key = 'print_timestamp';
$pgpoolConfigParam[$key]['type'] ='B';
$pgpoolConfigParam[$key]['default'] =true;

$key = 'master_slave_mode';
$pgpoolConfigParam[$key]['type'] ='B';
$pgpoolConfigParam[$key]['default'] =false;

$key = 'master_slave_sub_mode';
$pgpoolConfigParam[$key]['type'] ='C';
$pgpoolConfigParam[$key]['default'] ='slony';
$pgpoolConfigParam[$key]['regexp'] = "^[slony|stream]+$";

$key = 'delay_threshold';
$pgpoolConfigParam[$key]['type'] ='N';
$pgpoolConfigParam[$key]['default'] = 0;
$pgpoolConfigParam[$key]['min'] = 0;
$pgpoolConfigParam[$key]['max'] = 65535;

$key = 'log_standby_delay';
$pgpoolConfigParam[$key]['type'] ='C';
$pgpoolConfigParam[$key]['default'] ='none';
$pgpoolConfigParam[$key]['regexp'] = "^[always|if_over_threshold|none]+$";

$key = 'connection_cache';
$pgpoolConfigParam[$key]['type'] ='B';
$pgpoolConfigParam[$key]['default'] =true;

$key = 'health_check_timeout';
$pgpoolConfigParam[$key]['type'] ='N';
$pgpoolConfigParam[$key]['default'] =20;
$pgpoolConfigParam[$key]['min'] = 0;
$pgpoolConfigParam[$key]['max'] = 65535;

$key = 'health_check_period';
$pgpoolConfigParam[$key]['type'] ='N';
$pgpoolConfigParam[$key]['default'] =0;
$pgpoolConfigParam[$key]['min'] = 0;
$pgpoolConfigParam[$key]['max'] = 65535;

$key = 'health_check_user';
$pgpoolConfigParam[$key]['type'] ='C';
$pgpoolConfigParam[$key]['default'] ='nodoby';
$pgpoolConfigParam[$key]['regexp'] = "^[0-9a-zA-Z_\.\-]+$";

$key = 'insert_lock';
$pgpoolConfigParam[$key]['type'] ='B';
$pgpoolConfigParam[$key]['default'] =false;

$key = 'ignore_leading_white_space';
$pgpoolConfigParam[$key]['type'] ='B';
$pgpoolConfigParam[$key]['default'] =true;

$key = 'parallel_mode';
$pgpoolConfigParam[$key]['type'] ='B';
$pgpoolConfigParam[$key]['default'] =false;

$key = 'log_connections';
$pgpoolConfigParam[$key]['type'] = 'B';
$pgpoolConfigParam[$key]['default'] = false;

$key = 'log_hostname';
$pgpoolConfigParam[$key]['type'] = 'B';
$pgpoolConfigParam[$key]['default'] = false;

$key = 'log_statement';
$pgpoolConfigParam[$key]['type'] ='B';
$pgpoolConfigParam[$key]['default'] =false;

$key = 'enable_query_cache';
$pgpoolConfigParam[$key]['type'] ='B';
$pgpoolConfigParam[$key]['default'] =false;

$key = 'enable_pool_hba';
$pgpoolConfigParam[$key]['type'] ='B';
$pgpoolConfigParam[$key]['default'] =false;

$key = 'system_db_hostname';
$pgpoolConfigParam[$key]['type'] ='C';
$pgpoolConfigParam[$key]['default'] ='system_db_hostname';
$pgpoolConfigParam[$key]['regexp'] = $hostreg;

$key = 'system_db_port';
$pgpoolConfigParam[$key]['type'] ='N';
$pgpoolConfigParam[$key]['default'] =5432;
$pgpoolConfigParam[$key]['min'] = 1024;
$pgpoolConfigParam[$key]['max'] = 65535;

$key = 'system_db_dbname';
$pgpoolConfigParam[$key]['type'] ='C';
$pgpoolConfigParam[$key]['default'] ='pgpool';
$pgpoolConfigParam[$key]['regexp'] = "$strreg";

$key = 'system_db_schema';
$pgpoolConfigParam[$key]['type'] ='C';
$pgpoolConfigParam[$key]['default'] ='pgpool_catalog';
$pgpoolConfigParam[$key]['regexp'] = "$strreg";

$key = 'system_db_user';
$pgpoolConfigParam[$key]['type'] ='C';
$pgpoolConfigParam[$key]['default'] ='pgpool';
$pgpoolConfigParam[$key]['regexp'] =  "^[0-9a-zA-Z_\.\-]*$";

$key = 'system_db_password';
$pgpoolConfigParam[$key]['type'] ='C';
$pgpoolConfigParam[$key]['default'] ='';
$pgpoolConfigParam[$key]['regexp'] = ".*";

$key = 'pcp_port';
$pgpoolConfigParam[$key]['type'] ='N';
$pgpoolConfigParam[$key]['default'] =9898;
$pgpoolConfigParam[$key]['min'] = 1024;
$pgpoolConfigParam[$key]['max'] = 65535;

$key = 'pcp_socket_dir';
$pgpoolConfigParam[$key]['type'] ='C';
$pgpoolConfigParam[$key]['default'] ='/tmp';
$pgpoolConfigParam[$key]['regexp'] = "$dirreg";

$key = 'pgpool2_hostname';
$pgpoolConfigParam[$key]['type'] ='C';
$pgpoolConfigParam[$key]['default'] = 'localhost';
$pgpoolConfigParam[$key]['regexp'] = $hostreg;

$key = 'backend_hostname';
$pgpoolConfigBackendParam[$key]['type'] ='C';
$pgpoolConfigBackendParam[$key]['default'] ='';
$pgpoolConfigBackendParam[$key]['regexp'] = "^[0-9a-zA-Z\._\-]*$";

$key = 'backend_port';
$pgpoolConfigBackendParam[$key]['type'] ='N';
$pgpoolConfigBackendParam[$key]['default'] ='5432';
$pgpoolConfigBackendParam[$key]['min'] = 1024;
$pgpoolConfigBackendParam[$key]['max'] = 65535;

$key = 'backend_data_directory';
$pgpoolConfigBackendParam[$key]['type'] ='C';
$pgpoolConfigBackendParam[$key]['default'] ='';
$pgpoolConfigBackendParam[$key]['regexp'] = ".*";

$key = 'backend_weight';
$pgpoolConfigBackendParam[$key]['type'] ='F';
$pgpoolConfigBackendParam[$key]['default'] ='1';
$pgpoolConfigBackendParam[$key]['min'] = 0.0;
$pgpoolConfigBackendParam[$key]['max'] = 100.0;

$key = 'recovery_user';
$pgpoolConfigParam[$key]['type'] ='C';
$pgpoolConfigParam[$key]['default'] ='nodoby';
$pgpoolConfigParam[$key]['regexp'] = ".*";

$key = 'recovery_password';
$pgpoolConfigParam[$key]['type'] ='C';
$pgpoolConfigParam[$key]['default'] ='';
$pgpoolConfigParam[$key]['regexp'] = ".*";

$key = 'recovery_1st_stage_command';
$pgpoolConfigParam[$key]['type'] ='C';
$pgpoolConfigParam[$key]['default'] ='';
$pgpoolConfigParam[$key]['regexp'] = "^[0-9a-zA-Z_\/\.\-]*$";

$key = 'recovery_2nd_stage_command';
$pgpoolConfigParam[$key]['type'] ='C';
$pgpoolConfigParam[$key]['default'] ='';
$pgpoolConfigParam[$key]['regexp'] = "^[0-9a-zA-Z_\/\.\-]*$";

$key = 'recovery_timeout';
$pgpoolConfigParam[$key]['type'] ='N';
$pgpoolConfigParam[$key]['default'] = 90;
$pgpoolConfigParam[$key]['min'] = 0;
$pgpoolConfigParam[$key]['max'] = 65535;

$key = 'failover_command';
$pgpoolConfigParam[$key]['type'] ='C';
$pgpoolConfigParam[$key]['default'] ='';
$pgpoolConfigParam[$key]['regexp'] = ".*";

$key = 'failback_command';
$pgpoolConfigParam[$key]['type'] ='C';
$pgpoolConfigParam[$key]['default'] ='';
$pgpoolConfigParam[$key]['regexp'] = ".*";

$key = 'client_idle_limit_in_recovery';
$pgpoolConfigParam[$key]['type'] ='N';
$pgpoolConfigParam[$key]['default'] ='0';
$pgpoolConfigParam[$key]['min'] = -1;
$pgpoolConfigParam[$key]['max'] = 65535;

$key = 'fail_over_on_backend_error';
$pgpoolConfigParam[$key]['type'] ='B';
$pgpoolConfigParam[$key]['default'] =true;

$key = 'failover_if_affected_tuples_mismatch';
$pgpoolConfigParam[$key]['type'] ='B';
$pgpoolConfigParam[$key]['default'] =false;

$key = 'log_per_node_statement';
$pgpoolConfigParam[$key]['type'] ='B';
$pgpoolConfigParam[$key]['default'] =false;

$key = 'lobj_lock_table';
$pgpoolConfigParam[$key]['type'] ='C';
$pgpoolConfigParam[$key]['default'] ='';
$pgpoolConfigParam[$key]['regexp'] = ".*";

$key = 'ssl';
$pgpoolConfigParam[$key]['type'] ='B';
$pgpoolConfigParam[$key]['default'] = false;

$key = 'ssl_key';
$pgpoolConfigParam[$key]['type'] ='C';
$pgpoolConfigParam[$key]['default'] ='';
$pgpoolConfigParam[$key]['regexp'] = "^(|\/[0-9a-zA-Z_\/\.\-]*)$";

$key = 'ssl_cert';
$pgpoolConfigParam[$key]['type'] ='C';
$pgpoolConfigParam[$key]['default'] ='';
$pgpoolConfigParam[$key]['regexp'] = "^(|\/[0-9a-zA-Z_\/\.\-]*)$";

$key = 'ssl_ca_cert';
$pgpoolConfigParam[$key]['type'] ='C';
$pgpoolConfigParam[$key]['default'] ='';
$pgpoolConfigParam[$key]['regexp'] = "^(|\/[0-9a-zA-Z_\/\.\-]*)$";

$key = 'ssl_ca_cert_dir';
$pgpoolConfigParam[$key]['type'] ='C';
$pgpoolConfigParam[$key]['default'] ='';
$pgpoolConfigParam[$key]['regexp'] = "^(|\/[0-9a-zA-Z_\/\.\-]*)$";
?>
