<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>{$message.strQueryCache|escape}</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
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
  <h2>ヘルプ({$message.strQueryCache|escape})</h2>
    <h3>{$message.strSummary|escape}</h3>
    <p>enable_query_cache = true の場合に、SELECT 文の結果をキャッシュさせます。</p>
	<h3>{$message.strFeature|escape}</h3>
	<p>クエリキャッシュのデータを検索することができます。検索対象は、クエリ文字列とデータベース名で、部分一致検索を行うことができます。クエリ文字列とデータベース名はAND検索になります。</p>
    <table>
      <tbody>
        <tr> {if $deleteRow > 0}
        <tr>
          <td colspan="5">{$deleteRow|escape}{$message.strDeleted|escape}</td>
        </tr>
      {/if}
      <tr>
        <td nowrap="nowrap" class="column">{$message.strQueryStr|escape}</td>
        <td><input name="qQueryStr" type="text" id="qQueryStr" size="50" value="{$qQueryStr|escape}"/>
        </td>
      </tr>
      <tr>
        <td nowrap="nowrap" class="column">{$message.strDb|escape}</td>
        <td><input name="qDb" type="text" id="qDb" size="50" value="{$qDb|escape}"/></td>
      </tr>
      </tbody>
      <tfoot>
      <tr><td colspan="2">
      <input type="submit" name="search" value="{$message.strSearch|escape}" />
      <input type="submit" name="clear" value="{$message.strClear|escape}" />
      </td></tr>
    </table>
    <h3>クエリキャッシュリスト</h3>
	<p>現在キャッシュされているクエリ文字列、データベース名、作成時刻が表示されます。「クエリ文字列」、「データベース名」および「作成時刻」をクリックすると、並べ替えが行われます。クリックするたびに、昇順または降順で並べ替えが行われます。</p>
	<p>削除したいデータの左にあるチェックボックスにチェックを入れて、削除ボタンを押すと削除されます。一番上のチェックボックスにチェックするとすべてのレコードが選択されます。</p>
    <table>
      <tbody>
        <tr>
          <th><input type="checkbox" name="all" value="" /></th>
          <th>{$message.strQueryStr|escape}</th>
          <th>{$message.strDb|escape}</th>
          <th>{$message.strCreateTime|escape}</th>
        </tr>
      </tbody>
      <tfoot>
      <tr><td colspan="4">
      <input type="submit" name="ButtonName" value="{$message.strDelete|escape}" />
      </td></tr>
    </table>
</div>
<div id="footer">
{include file='footer.tpl'}
</div>
</html>
