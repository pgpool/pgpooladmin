<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>{$message.strSystemDb|escape}</title>
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
  <h2>{$message.strHelp|escape}({$message.strSystemDb|escape})</h2>
  <h3>{$message.strSummary|escape}</h3>
pgpool.confのparallel_mode=trueの場合に並列問い合わせの設定を定義します。
  <h3>{$message.strFeature|escape}</h3>
各カラムのデータ型は以下のとおりです。<p />
<table>
  <tr>
    <th class="right_border"><label>カラム名</label></th>
    <th class="right_border"><label>データ型</label></th>
    <th><label>説明</label></th>
  </tr>
  <tr>
    <th class="right_border"><label>{$message.strDbName|escape}</label></th>
    <td class="right_border">TEXT</td>
    <td>分散を行うデータベース名</td>
  </tr>
  <tr>
    <th class="right_border"><label>{$message.strSchemaName|escape}</label></th>
    <td class="right_border">TEXT</td>
    <td>データベースのスキーマ名</td>
  </tr>
  <tr>
    <th class="right_border"><label>{$message.strTable|escape}</label></th>
    <td class="right_border">TEXT</td>
    <td>分散を行うテープル</td>
  </tr>
  <tr>
    <th class="right_border"><label>{$message.strColName|escape}</label></th>
    <td class="right_border">TEXT</td>
    <td>分散キーとなる列名</td>
  </tr>
  <tr>
    <th class="right_border"><label>{$message.strColList|escape}</label></th>
    <td class="right_border">TEXT[]</td>
    <td>データを分散させるテーブルの列名リスト</td>
  </tr>
  <tr>
    <th class="right_border"><label>{$message.strTypeList|escape}</label></th>
    <td class="right_border">TEXT[]</td>
    <td>列名に対する型のリスト</td>
  </tr>
  <tr>
    <th class="right_border"><label>{$message.strDistDefFunc|escape}</label></th>
    <td class="right_border">TEXT</td>
    <td>分散ルールを定義した関数名</td>
  </tr>
</table>
<p />
<h3>追加</h3>
すべてのカラムに値を入力して「追加」ボタンを押します。<br />
列名リストと列データ型リストについては、各要素をシングルクォーテーションで囲み、各要素をカンマで区切ってください。
<h3>更新</h3>
更新したい定義のデータベース名をクリックしてください。入力フィールドに値が表示されますので修正して「更新」ボタンを押してください。ただし、データベース名、スキーマ名、テーブル名は変更できません。
<h3>削除</h3>
削除したい定義のデータベース名をクリックしてください。「削除」ボタンを押してください。確認ダイアログが表示されますので「OK」ボタンを押してください。
</div>
<div id="footer">
{include file='footer.tpl'}
</div>
</body>
</html>
