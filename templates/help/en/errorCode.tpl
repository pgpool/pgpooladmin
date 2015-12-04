<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>{$message.strNodeStatus|escape}</title>
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
<div id="help"><a href="#" onclick="history.back()"><img src="images/back.gif" />{$message.strBack|escape}</a></div>
<h2>{$message.strHelp|escape}({$message.strErrorCode|escape})</h2>
<h3>{$message.strCommon|escape}</h3>
<table>
<thead>
  <tr>
    <th class="right_border"><label>{$message.strErrorCode|escape}</label></th>
    <th class="right_border"><label>{$message.strErrorMessage|escape}</label></th>
    <th><label>{$message.strMeasures|escape}</label></th>
  </tr>
</thead>
<tbody>
<tr><th class="right_border"><label>e1</label></th><td  class="right_border">No found pgmgt.conf.php.</td><td>Please confirm whether the pgmgt.conf.php file is in the conf directory. Moreover, please confirm whether there is an appropriate right of access. </td></tr>
<tr><th class="right_border"><label>e2</label></th><td  class="right_border">No found message catalog.</td><td>Please confirm whether the message catalog file is in the lang directory. </td></tr>
<tr><th class="right_border"><label>e3</label></th><td  class="right_border">PCP command error occurred.</td><td>Please confirm whether in the place that the Pcp command specified by a set </td></tr>
<tr><th class="right_border"><label>e4</label></th><td  class="right_border">No found pgpool.conf.</td><td>Please confirm whether in the place that the Pcp command specified by a set menu.</td></tr>
<tr><th class="right_border"><label>e5</label></th><td  class="right_border">No found Smarty template file.</td><td>Please confirm whether the template file for the display is in the template directory. </td></tr>
<tr><th class="right_border"><label>e6</label></th><td  class="right_border">No found help.</td><td>Please confirm whether the Help file is in template/help or less. </td></tr>
<tr><th class="right_border"><label>e7</label></th><td  class="right_border">No found Parameter in pgpmgt.conf.php</td><td>Please confirm whether the parameter to be specified to pgmgt.conf.php. </td></tr>
<tr><th class="right_border"><label>e8</label></th><td  class="right_border">No found pcp_timeout in pgpool.conf</td><td>Please confirm whether pcp_timeout to be specified with pgpool.conf. </td></tr>
<tr><th class="right_border"><label>e9</label></th><td  class="right_border">No found pcp_port in pgpool.conf</td><td>Please confirm whether pcp_port to be specified with pgpool.conf. </td></tr>
</tbody>
<tfoot><tr><td colspan="3"></td></tr></tfoot>
</table>

<h3>{$message.strPgpoolStatus|escape}</h3>
<table>
<thead>
  <tr>
    <th class="right_border"><label>{$message.strErrorCode|escape}</label></th>
    <th class="right_border"><label>{$message.strErrorMessage|escape}</label></th>
    <th><label>{$message.strMeasures|escape}</label></th>
  </tr>
</thead>
<tbody>
<tr><th class="right_border"><label>e1001</label></th><td  class="right_border">PCP command error occurred.</td><td>It is displayed when failing in the call of the pcp command. Please confirm whether in the place that the Pcp command specified by a set menu. </td></tr>
<tr><th class="right_border"><label>e1002</label></th><td  class="right_border">pcp_node_count command error occurred.</td><td>It is an execution of pcp_node_count error. Please confirm whether pcp_node_count can be normally executed. </td></tr>
<tr><th class="right_border"><label>e1003</label></th><td  class="right_border">pcp_node_info command error occurred.</td><td>It is an execution of pcp_node_info error. Please confirm whether pcp_node_infot can be normally executed. </td></tr>
<tr><th class="right_border"><label>e1004</label></th><td  class="right_border">pcp_proc_count command error occurred.</td><td>It is an execution of pcp_proc_count error. Please confirm whether pcp_proc_count can be normally executed. </td></tr>
<tr><th class="right_border"><label>e1005</label></th><td  class="right_border">pcp_proc_info command error occurred.</td><td>It is an execution of pcp_proc_info error. Please confirm whether pcp_proc_info can be normally executed. </td></tr>
<tr><th class="right_border"><label>e1006</label></th><td  class="right_border">pcp_stop_pgpool command error occurred.</td><td>It is an execution of pcp_stop_pgpool error. Please confirm whether pcp_stop_pgpool can be normally executed. </td></tr>
<tr><th class="right_border"><label>e1007</label></th><td  class="right_border">pcp_detach_node command error occurred.</td><td>It is an execution of pcp_detach_node error. Please confirm whether pcp_detach_node can be normally executed. </td></tr>
<tr><th class="right_border"><label>e1008</label></th><td  class="right_border">No found pgpool.conf.</td><td>Please confirm whether in the place that pgpool.conf specified by a set menu. Moreover, please confirm whether there is an appropriate right of access to pgpool.conf. </td></tr>
<tr><th class="right_border"><label>e1009</label></th><td  class="right_border">No found pcp.conf.</td><td>Please confirm whether in the place that pcp.conf specified by a set menu. Moreover, please confirm whether there is an appropriate right of access to pcp.conf. </td></tr>
<tr><th class="right_border"><label>e1010</label></th><td  class="right_border">pcp_attach_node command error occurred.</td><td>It is an execution of pcp_attach_node error. Please confirm whether pcp_detach_node can be normally executed. </td></tr>
<tr><th class="right_border"><label>e1011</label></th><td  class="right_border">No found log ifle.</td><td>Please confirm whether in the place that the pgpool log file specified by a set menu. Moreover, please confirm whether there is an appropriate right of access to the specified log file. It is made for the directory specified with logdir of pgpool.conf by the file name of pgpool.log when not specifying it. </td></tr>
<tr><th class="right_border"><label>e1012</label></th><td  class="right_border">pcp_recovery_node command error occurred.</td><td>It is an execution of pcp_recovery_node error. Please confirm whether pcp_recovery_node can be normally executed. </td></tr>
<tr><th class="right_border"><label>e1013</label></th><td  class="right_border">pcp_watchdog_info command error occurred.</td><td>It is an execution of pcp_watchdog_info error. Please confirm whether pcp_watchdog_info can be normally executed. </td></tr>
<tr><th class="right_border"><label>e1014</label></th><td  class="right_border">Could not read .pcppass file</td><td>[V3.5 - ] It is an execution of .pcppass file. PgpoolAdmin looks for the file in Apache process user's home directgory. If file is not found, or its owner or permission is invalid, this error occurs.</td></tr>
</tbody>
<tfoot><tr><td colspan="3"></td></tr></tfoot>
</table>

<h3>{$message.strNodeStatus|escape}</h3>
<table>
<thead>
  <tr>
    <th class="right_border"><label>{$message.strErrorCode|escape}</label></th>
    <th class="right_border"><label>{$message.strErrorMessage|escape}</label></th>
    <th><label>{$message.strMeasures|escape}</label></th>
  </tr>
</thead>
<tbody>
<tr><th class="right_border"><label>e8001</label></th><td  class="right_border">Detailed information cannot be acquired.</td><td>Please confirm whether to connect it with the node by the psql command. </td></tr>
</tbody>
<tfoot><tr><td colspan="3"></td></tr></tfoot>
</table>

<h3>{$message.strQueryCache|escape}</h3>
<table>
<thead>
  <tr>
    <th class="right_border"><label>{$message.strErrorCode|escape}</label></th>
    <th class="right_border"><label>{$message.strErrorMessage|escape}</label></th>
    <th><label>{$message.strMeasures|escape}</label></th>
  </tr>
</thead>
<tbody>
<tr><th class="right_border"><label>e2001</label></th><td  class="right_border">Database connection error occurred.</td><td>Please confirm whether to connect it with the data base specified with system DB of pgpool.conf. </td></tr>
<tr><th class="right_border"><label>e2002</label></th><td  class="right_border">The error occurred when SELECT was executed</td><td>Please confirm whether the record of Cericasshutabl can be normally acquired. </td></tr>
<tr><th class="right_border"><label>e2003</label></th><td  class="right_border">No found pgpool.conf.</td><td>Please confirm whether in the place that pcp.conf specified by a set menu. Moreover, please confirm whether there is an appropriate right of access to pcp.conf. </td></tr>
</tbody>
<tfoot><tr><td colspan="3"></td></tr></tfoot>
</table>

<h3>{$message.strSystemDb|escape}</h3>
<table>
<thead>
  <tr>
    <th class="right_border"><label>{$message.strErrorCode|escape}</label></th>
    <th class="right_border"><label>{$message.strErrorMessage|escape}</label></th>
    <th><label>{$message.strMeasures|escape}</label></th>
  </tr>
</thead>
<tbody>
<tr><th class="right_border"><label>e3001</label></th><td  class="right_border">Database connection error occurred.</td><td>Please confirm whether to connect it with the data base specified with system DB of pgpool.conf. </td></tr>
<tr><th class="right_border"><label>e3002</label></th><td  class="right_border">The SQL error occurred when SELECT was executed</td><td>Please confirm whether the record of system DB table can be normally acquired. </td></tr>
<tr><th class="right_border"><label>e3003</label></th><td  class="right_border">The SQL error occurred when INSERT was executed</td><td>Please confirm whether the record can be normally inserted in system DB table. </td></tr>
<tr><th class="right_border"><label>e3004</label></th><td  class="right_border">The SQL error occurred when UPDATE was executed</td><td>Please confirm whether the record of system DB table can be normally renewed. </td></tr>
<tr><th class="right_border"><label>e3005</label></th><td  class="right_border">The SQL error occurred when DELETE was executed</td><td>Please confirm whether the record of system DB table can be normally deleted. </td></tr>
<tr><th class="right_border"><label>e3006</label></th><td  class="right_border">No found pgpool.conf.</td><td>Please confirm whether in the place that pcp.conf specified by a set menu. Moreover, please confirm whether there is an appropriate right of access to pcp.conf. </td></tr>
</tbody>
<tfoot><tr><td colspan="3"></td></tr></tfoot>
</table>

<h3>{$message.strPgConfSetting|escape}</h3>
<table>
<thead>
  <tr>
    <th class="right_border"><label>{$message.strErrorCode|escape}</label></th>
    <th class="right_border"><label>{$message.strErrorMessage|escape}</label></th>
    <th><label>{$message.strMeasures|escape}</label></th>
  </tr>
</thead>
<tbody>
<tr><th class="right_border"><label>e4001</label></th><td  class="right_border">No found pgpool.conf.</td><td>Please confirm whether in the place that pcp.conf specified by a set menu. Moreover, please confirm whether there is an appropriate right of access to pcp.conf. </td></tr>
<tr><th class="right_border"><label>e4002</label></th><td  class="right_border">It is not possible to read to pgpool.conf. </td><td>Please confirm whether there is a reading right of access in pgpool.conf. </td></tr>
<tr><th class="right_border"><label>e4003</label></th><td  class="right_border">It is not possible to write to pgpool.conf. </td><td>Please confirm whether there is a writing right of access in pgpool.conf. </td></tr>
<tr><th class="right_border"><label>e4004</label></th><td  class="right_border">There is not required parameter in pgpool.conf</td><td>Please confirm whether there are all parameters in pgpool.conf. </td></tr>
</tbody>
<tfoot><tr><td colspan="3"></td></tr></tfoot>
</table>

<h3>{$message.strSetting|escape}</h3>
<table>
<thead>
  <tr>
    <th class="right_border"><label>{$message.strErrorCode|escape}</label></th>
    <th class="right_border"><label>{$message.strErrorMessage|escape}</label></th>
    <th><label>{$message.strMeasures|escape}</label></th>
  </tr>
</thead>
<tbody>
<tr><th class="right_border"><label>e5001</label></th><td  class="right_border">No found pgmgt.conf.php.</td><td>Please confirm whether the pgmgt.conf.php file is in the conf directory. Moreover, please confirm whether there is an appropriate right of access. </td></tr>
<tr><th class="right_border"><label>e5002</label></th><td  class="right_border">It is not possible to read to pgmgt.conf.php.</td><td>Please confirm whether there is a reading right of access in the pgmgt.conf.php file. </td></tr>
<tr><th class="right_border"><label>e5003</label></th><td  class="right_border">It is not possible to write to pgmgt.conf.php.</td><td>Please confirm whether there is a writing right of access in the pgmgt.conf.php file. </td></tr>
</tbody>
<tfoot><tr><td colspan="3"></td></tr></tfoot>
</table>

<h3>{$message.strChangePassword|escape}</h3>
<table>
<thead>
  <tr>
    <th class="right_border"><label>{$message.strErrorCode|escape}</label></th>
    <th class="right_border"><label>{$message.strErrorMessage|escape}</label></th>
    <th><label>{$message.strMeasures|escape}</label></th>
  </tr>
</thead>
<tbody>
<tr><th class="right_border"><label>e6001</label></th><td  class="right_border">No found pcp.conf</td><td>Please confirm whether in the place that pcp.conf specified by a set </td></tr>
<tr><th class="right_border"><label>e6002</label></th><td  class="right_border">It is not possible to read to pcp.conf. </td><td>menu. </td></tr>
<tr><th class="right_border"><label>e6003</label></th><td  class="right_border">It is not possible to write to pcp.conf. </td><td>Please confirm whether there is a reading right of access in the pcp.conf file. </td></tr>
</tbody>
</table>

<h3>{$message.strLogout|escape}</h3>
<table>
<thead>
  <tr>
    <th class="right_border"><label>{$message.strErrorCode|escape}</label></th>
    <th class="right_border"><label>{$message.strErrorMessage|escape}</label></th>
    <th><label>{$message.strMeasures|escape}</label></th>
  </tr>
</thead>
<tbody>
<tr><th class="right_border"><label>e7001</label></th><td  class="right_border">No found pcp.conf.</td><td>Please confirm whether in the place that pcp.conf specified by a set menu. </td></tr>
</tbody>
<tfoot><tr><td colspan="3"></td></tr></tfoot>
</table>


</div>
<div id="footer">
{include file='footer.tpl'}
</div>
</body>
</html>
