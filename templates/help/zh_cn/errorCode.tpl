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
<tr><th class="right_border"><label>e1</label></th><td  class="right_border">pgmgt.conf.php 未找到</td><td>请确认conf 目录下是否存在pgmgt.conf.php文件，并且是否有此文件的访问权限。</td></tr>
<tr><th class="right_border"><label>e2</label></th><td  class="right_border">消息 catalog 未找到</td><td>请确认lang目录下是否存在消息 catalog 文件。</td></tr>
<tr><th class="right_border"><label>e3</label></th><td  class="right_border">PCP 命令发生错误</td><td>请确认在设置菜单中指定的目录里是否存在Pcp命令。</td></tr>
<tr><th class="right_border"><label>e4</label></th><td  class="right_border">pgpool.conf 未找到</td><td>请确认在设置菜单中指定的路径里是否存在pgpool.conf文件。并且、是否有pgpool.conf文件的访问权限。</td></tr>
<tr><th class="right_border"><label>e5</label></th><td  class="right_border">Smarty 模板文件未找到</td><td>请确认template目录下是否存在页面显示用的模板文件。</td></tr>
<tr><th class="right_border"><label>e6</label></th><td  class="right_border">帮助文件未找到</td><td>请确认template/help目录下是否存在帮助文件。</td></tr>
<tr><th class="right_border"><label>e7</label></th><td  class="right_border">pgpmgt.conf.php 中的配置项缺失</td><td>请确认pgmgt.conf.php文件中是否有此配置项。</td></tr>
<tr><th class="right_border"><label>e8</label></th><td  class="right_border">pgpool.conf 未找到 pcp_timeout 配置项</td><td>请确认在pgmgt.conf.php文件中是否设置了pcp_timeout。</td></tr>
<tr><th class="right_border"><label>e9</label></th><td  class="right_border">pgpool.conf 未找到 pcp_port 配置项</td><td>请确认在pgmgt.conf.php文件中是否设置pcp_port。</td></tr>
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
<tr><th class="right_border"><label>e1001</label></th><td  class="right_border">PCP 命令错误</td><td>PCP命令执行失败时显示。请确认在设置菜单中指定的目录里是否存在Pcp命令。</td></tr>
<tr><th class="right_border"><label>e1002</label></th><td  class="right_border">pcp_node_count 命令错误</td><td>pcp_node_count命令执行错误。请确认是否能正常执行pcp_node_count命令。</td></tr>
<tr><th class="right_border"><label>e1003</label></th><td  class="right_border">pcp_node_info 命令错误</td><td>pcp_node_info命令执行错误。请确认是否能正常执行pcp_node_info命令。</td></tr>
<tr><th class="right_border"><label>e1004</label></th><td  class="right_border">pcp_proc_count 命令错误</td><td>pcp_proc_count命令执行错误。请确认是否能正常执行pcp_proc_count命令。</td></tr>
<tr><th class="right_border"><label>e1005</label></th><td  class="right_border">pcp_proc_info 命令错误</td><td>pcp_proc_info命令执行错误。请确认是否能正常执行pcp_proc_info命令。</td></tr>
<tr><th class="right_border"><label>e1006</label></th><td  class="right_border">pcp_stop_pgpool 命令错误</td><td>pcp_stop_pgpool命令执行错误。请确认是否能正常执行pcp_stop_pgpool命令。</td></tr>
<tr><th class="right_border"><label>e1007</label></th><td  class="right_border">pcp_detach_node 命令错误</td><td>pcp_detach_node命令执行错误。请确认是否能正常执行pcp_detach_node命令。</td></tr>
<tr><th class="right_border"><label>e1008</label></th><td  class="right_border">pgpool.conf 未找到</td><td>请确认在设置菜单中指定的路径里是否存在pgpool.conf文件。并且、是否有pgpool.conf文件的访问权限</td></tr>
<tr><th class="right_border"><label>e1009</label></th><td  class="right_border">pcp.conf 未找到</td><td>请确认在设置菜单中指定的路径里是否存在pcp.conf文件。并且、是否有pcp.conf文件的访问权限</td></tr>
<tr><th class="right_border"><label>e1010</label></th><td  class="right_border">pcp_attach_node 命令错误</td><td>pcp_detach_node命令执行错误。请确认是否能正常执行pcp_attach_node命令。</td></tr>
<tr><th class="right_border"><label>e1011</label></th><td  class="right_border">日志文件未找到</td><td>请确认在设置菜单中指定的目录下是否存在pgpool日志文件。并且、是否有此日志文件的访问权限。如果没有设置，将会在pgpool.conf文件里logdir指定的目录里生成pgpool.log文件。</td></tr>
<tr><th class="right_border"><label>e1012</label></th><td  class="right_border">pcp_recovery_node 命令错误</td><td>pcp_recovery_node命令执行错误。请确认是否能正常执行pcp_recovery_node命令。</td></tr>
<tr><th class="right_border"><label>e1013</label></th><td  class="right_border">pcp_watchdog_info 命令错误</td><td>pcp_watchdog_info命令执行错误。请确认是否能正常执行pcp_watchdog_info命令。</td></tr>
<tr><th class="right_border"><label>e1014</label></th><td  class="right_border">无法读取 .pcppass 文件</td><td>（V3.5以后） 执行PCP命令时，读取.pcppass 文件失败时的错误。参照 Apache 的启动用户的家目录里 .pcppass 文件（/home/apache/.pcppass など）。也许是因为文件不存在，文件的所有者不是 apache ，或者权限不是 600 等等的原因。</td></tr>
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
<tr><th class="right_border"><label>e8001</label></th><td  class="right_border">无法获得详细信息</td><td>请确认是否能用psql命令来连接节点。</td></tr>
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
<tr><th class="right_border"><label>e2001</label></th><td  class="right_border">数据库连接发生错误</td><td>请确认是否能够连接pgpool.conf里指定的System DB。</td></tr>
<tr><th class="right_border"><label>e2002</label></th><td  class="right_border">执行 SELECT 时发生错误</td><td>请确认是否能够成功读取查询缓存表中的记录。</td></tr>
<tr><th class="right_border"><label>e2003</label></th><td  class="right_border">pgpool.conf 不存在</td><td>请确认在设置菜单中指定的路径里是否存在pcp.conf文件。并且,是否有pcp.conf文件的访问权限。</td></tr>
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
<tr><th class="right_border"><label>e3001</label></th><td  class="right_border">数据库连接发生错误</td><td>请确认是否能够连接pgpool.conf里指定的System DB。</td></tr>
<tr><th class="right_border"><label>e3002</label></th><td  class="right_border">执行 SELECT 时发生错误</td><td>请确认是否能够成功读取System BD表中的记录。</td></tr>
<tr><th class="right_border"><label>e3003</label></th><td  class="right_border">执行 INSERT 时发生错误</td><td>请确认是否能够成功向System BD表中插入记录。</td></tr>
<tr><th class="right_border"><label>e3004</label></th><td  class="right_border">执行 UPDATE 时发生错误</td><td>请确认是否能够成功更新System BD表中的记录。</td></tr>
<tr><th class="right_border"><label>e3005</label></th><td  class="right_border">执行 DELETE 时发生错误</td><td>请确认是否能够成功删除System BD表中的记录。</td></tr>
<tr><th class="right_border"><label>e3006</label></th><td  class="right_border">pgpool.conf 未找到</td><td>请确认在设置菜单中指定的路径里是否存在pcp.conf文件。并且，
是否有pcp.conf文件的访问权限。</td></tr>
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
<tr><th class="right_border"><label>e4001</label></th><td  class="right_border">pgpool.conf 未找到</td><td>请确认在设置菜单中指定的路径里是否存在pcp.conf文件。并且，是否有pcp.conf文件的访问权限。</td></tr>
<tr><th class="right_border"><label>e4002</label></th><td  class="right_border">无法读取 pgpool.conf</td><td>请确认是否拥有pgpool.conf文件的读取权。</td></tr>
<tr><th class="right_border"><label>e4003</label></th><td  class="right_border">无法写入 pgpool.conf</td><td>请确认是否拥有pgpool.conf文件的写入权。</td></tr>
<tr><th class="right_border"><label>e4004</label></th><td  class="right_border">pgpool.conf 没找到配置项</td><td>请确认是否在pgpool.conf文件里有设置所有配置项。</td></tr>
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
<tr><th class="right_border"><label>e5001</label></th><td  class="right_border">pgmgt.conf.php 未找到</td><td>请确认在conf目录里是否存在pgmgt.conf.php文件。并且，是否有pgmgt.conf.php文件的访问权限。</td></tr>
<tr><th class="right_border"><label>e5002</label></th><td  class="right_border">无法读取 pgmgt.conf.php</td><td>请确认是否拥有pgmgt.conf.php文件的读取权。</td></tr>
<tr><th class="right_border"><label>e5003</label></th><td  class="right_border">无法写入 pgmgt.conf.php</td><td>请确认是否拥有pgmgt.conf.php文件的写入权。</td></tr>
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
<tr><th class="right_border"><label>e6001</label></th><td  class="right_border">pcp.conf 未找到</td><td>请确认在设置菜单中指定的路径里是否存在pcp.conf文件。</td></tr>
<tr><th class="right_border"><label>e6002</label></th><td  class="right_border">无法读取 pcp.conf</td><td>请确认是否拥有pcp.conf文件的读取权。</td></tr>
<tr><th class="right_border"><label>e6003</label></th><td  class="right_border">无法写入 pcp.conf</td><td>请确认是否拥有pcp.conf文件的写入权。</td></tr>
</tbody>
<tfoot><tr><td colspan="3"></td></tr></tfoot>
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
<tr><th class="right_border"><label>e7001</label></th><td  class="right_border">pcp.conf 未找到</td><td>请确认在设置菜单中指定的路径里是否存在pcp.conf文件。</td></tr>
</tbody>
<tfoot><tr><td colspan="3"></td></tr></tfoot>
</table>


</div>
<div id="footer">
{include file='footer.tpl'}
</div>
</body>
</html>
