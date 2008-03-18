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
<div id="help"><a href="{$help|escape}.php"><img src="images/back.gif" />{$message.strBack|escape}</a></div>
<h2>{$message.strHelp|escape}({$message.strNodeStatus|escape})</h2>
<h3>{$message.strSummary|escape}</h3>
ノードステータスでは、各ノードについて
<ul><li>IPアドレス</li>
  <li>ポート</li>
  <li>ステータス</li>
  <li>詳細情報</li>
  </ul>
<p>を取得することができます。</p>
<h3>{$message.strFeature|escape}</h3>
<table>
  <tr>
    <th class="right_border"><label>IPアドレス</label></th>
    <td>ノードのIPアドレス</td>
  </tr>
  <tr>
    <th class="right_border"><label>ポート</label></th>
    <td>Postmasterが稼働しているポート番号</td>
  </tr>
  <tr>
    <th class="right_border"><label>ステータス</label></th>
    <td>Postmasterが稼働状態であるかどうかを表示します。</td>
  </tr>
  <tr>
    <th class="right_border"><label>詳細</label></th>
    <td>Postmasterが稼働状態の場合にのみ表示されます。<br />
PostgreSQLの場合にはpg_settings情報、pgpoolの場合にはpool_statusを取得します。
    </td>
  </tr>
</table>
</div>
<div id="footer">
{include file='footer.tpl'}
</div>
</body>
</html>
