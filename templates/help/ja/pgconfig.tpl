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
<p>pgpoolの設定ファイルであるpgpool.confの設定内容を表示・変更することができます</p>
<p>
公式ドキュメント:<br>
<a href="http://www.pgpool.net/docs/latest/pgpool-ja.html" target="_blank">
http://www.pgpool.net/docs/latest/pgpool-ja.html</a>
</p>

<h3>{$message.strFeature|escape}</h3>
<p>変更したい値を入力して更新ボタンを押してください。</p>
<p>
更新した設定を反映させるには、設定のリロードが必要です。
また、[*]が付いている項目は、設定を反映させるために pgpool の再起動が必要となります。
</p>
　
<h4>バックエンドホストの追加</h4>
<p>新しいバックエンドホストを追加したい場合には、追加ボタンを押してください。</p>
<p>
バックエンドホストの項目に新しい入力欄ができますので、
そこに新しいバックエンドホストの情報を入力してください。
入力が終わりましたら、更新ボタンを押してください。
</p>

<h4>バックエンドホストの削除</h4>
<p>登録してあるバックエンドホストを削除したい場合には、そのホスト設定の右側にある
削除ボタンを押してください。</p>

</div>
<hr class="hidden" />
<div id="footer">
{include file='footer.tpl'}
</div>
</body>
</html>
