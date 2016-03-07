<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>{$message.strPgpoolStatus|escape}</title>
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
<div id="help"><a href="{$help|escape}.php"><img src="images/back.gif" />{$message.strBack|escape}</a></div>
<h2>{$message.strHelp|escape}({$message.strStatus|escape})</h2>
<h3>{$message.strSummary|escape}</h3>
用 pgpool 状态，可以显示 pgpool 的如下信息。
<ul>
  <li>摘要</li>
  <li>进程信息</li>
  <li>节点信息</li>
  <li>日志</li>
</ul>
并且可以对 pgpool 进行如下操作。
<ul>
  <li>启动</li>
  <li>停止</li>
  <li>重启</li>
</ul>
<h3>説明</h3>

<table>
  <tr>
    <th class="right_border"><label>摘要</label></th>
    <td>显示 pgpool.conf 的内容。</td>
  </tr>
  <tr>
    <th class="right_border"><label>进程信息</label></th>
    <td><p>显示每个 pgppol 进程的如下信息。</p>
      <ul>
        <li>进程ID</li>
        <li>数据库名</li>
        <li>连接用户名</li>
        <li>进程启动的时间戳</li>
        <li>连接创建的时间和日期</li>
        <li>协议主版本号</li>
        <li>协议副版本号</li>
        <li>连接使用次数</li>
        </ul>
      最多可以显示的进程数为 pgpool.conf 文件中设置的 max_pool 的值。
      </p></td>
  </tr>
  <tr>
    <th class="right_border"><label>节点信息</label></th>
    <td><p>显示每个节点的如下信息。</p>
        <ul>
          <li>IP地址</li>
          <li>端口号</li>
          <li>状态</li>
          <li>负载均衡度</li>
          <li>切断按钮</li>
        </ul>
      <p>但是，pgpool在并行模式运行的情况下，不显示切断按钮。</p>
      <p>关于状态，有如下3种。</p>
      <ul>
        <li>节点运行中。没有连接</li>
        <li>节点运行中。连接中</li>
        <li>节点停止运行</li>
      </ul>
    </td>
  </tr>
  <tr>
    <th class="right_border"><label>日志</label></th>
    <td>用非守护进程模式(-n) 启动pgpool后，可以显示pgpool的日志。</td>
  </tr>
  <tr>
    <th class="right_border"><label>启动</label></th>
    <td>pgpool处于停止状态时，可以启动pgpool。可以指定如下启动选项。
    <ul>
    <li>清空查询缓存</li>
    <li>非守护进程模式</li>
    <li>调式模式</li>
    <li>pgpool.conf</li>
    <li>pcp.conf</li>
    </ul>
    </td>
  </tr>
  <tr>
    <th class="right_border"><label>停止</label></th>
    <td>终止 pgpool 的全部进程。按下停止 pgpool 按钮后、会显示停止模式。可选的停止模式如下所示。
    <ul>
    <li>smart</li>
    <li>fast</li>
    <li>immediate</li>
    </ul>
    停止后、pgpool 的状态变为「pgpool停止」、并显示启动页面。</td>
  </tr>
  <tr>
    <th class="right_border"><label>重启</label></th>
    <td>终止 pgpool 的全部进程后，并且重新启动 pgpool。上面介绍的启动和停止的选项可以同时指定。</td>
  </tr>
</table>
</div>
<div id="footer">
{include file='footer.tpl'}
</div>
</body>
</html>
