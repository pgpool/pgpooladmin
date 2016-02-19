<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>{$message.strSetting|escape}</title>
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
  <h2>{$message.strHelp|escape}({$message.strSetting|escape})</h2>
  <h3>{$message.strSummary|escape}</h3>
  可以显示以及更改pgpool管理工具的配置。
  <h3>{$message.strFeature|escape}</h3>
    <table>
      <tbody>
        <tr>
          <th><label>{$message.strLanguage|escape}</label>
            (string)</th>
          <td class="input">选择显示语言。在选择了「auto」的情况下，浏览器里设置的语言将被优先选择。</td>
        </tr>
        <tr>
          <th><label>{$message.strPgConfFile|escape}</label>
            (string)</th>
          <td>指定到pgpool.conf的相对路径。</td></tr>
        <tr>
          <th><label>{$message.strPasswordFile|escape}</label>
            (string)</th>
          <td>指定到pcp.conf的相对路径。</td></tr>
        <tr>
          <th><label>{$message.strPgpoolCommand|escape}</label>
            (string)</th>
          <td>指定到pgpool的相对路径。</td></tr>
        <tr>
          <th colspan="2"><label>{$message.strPgpoolCommandOption|escape}</label>
            (string)</th></tr>
          <tr><td>{$message.strCmdC|escape}(-c)</td>
          <td>启动时清空查询缓存。</td>
          </tr>
          <tr><td>{$message.strCmdN|escape}(-n)</td>
          <td>用非守护进程模式启动pgpool。如果要在管理工具中显示pgpool的日志，需要把这个参数设置为 on。</td>
          </tr>
          <tr><td>{$message.strCmdD|escape}(-d)</td>
          <td>用调试模式启动pgpool。需要调试日志的情况下，把此参数设置为 on。</td>
          </tr>
          <tr><td>{$message.strCmdM|escape}(-m)</td>
          <td>终止pgpool的所有进程。点击pgpool停止按钮后、将显示关闭模式选项。可选的关闭模式如下：
          <ul>
          <li>smart</li>
          <li>fast</li>
          <li>immediate</li>
          </ul>
          停止后、pgpool状态将变为「pgpool停止」、并显示启动用页面。</td>
          </tr>
          <tr><td>{$message.strCmdPgpoolFile|escape}(-f)</td>
          <td>pgpool启动时需要设置pgpool.conf文件。pgpool.conf文件的路径可以用「{$message.strPgConfFile|escape}」来指定。</td>
          </tr>
          <tr><td>{$message.strCmdPcpFile|escape}(-F)</td>
          <td>pgpool启动时需要设置pcp.conf文件。pcp.conf文件的路径可以用「{$message.strPasswordFile|escape}」来指定。</td>
          </tr>
        <tr>
          <th><label>{$message.strPgpoolLogFile|escape}</label>
            (string)</th>
          <td>非守护进程模式启动的情况下，可以指定日志文件或者管道命令。指定日志文件时需要用相对路径。使用管道命令是时需要以("|")开始。如果用非守护进程模式启动并且什么都不指定的情况下，将会在pgpool.conf里用logdir设置的路径里生成pgpool.log文件。</td></tr>
        <tr>
          <th><label>{$message.strPcpDir|escape}</label>
            (string)</th>
          <td>设置PCP命令的安装目录。</td></tr>
        <tr>
          <th><label>{$message.strPcpHostName|escape}</label>
            (string)</th>
          <td>执行PCP命令的主机名。一般为「localhost」。</td>
        </tr>
        <tr>
          <th><label>{$message.strPcpRefreshTime|escape}</label>
            (integer)
            </td>
          <td>用秒单位来指定状态更新的间隔时间。设置为0时不自动更新。
        </td></tr>
      </tbody>
    </table>
  <p>最后按更新按钮进行更新。</p>
</div>
<div id="footer">
{include file='footer.tpl'}
</div>
</body>
</html>
