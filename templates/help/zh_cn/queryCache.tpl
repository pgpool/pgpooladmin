<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>{$message.strQueryCache|escape}</title>
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
  <h2>{$message.strHelp|escape}({$message.strQueryCache|escape})</h2>
    <h3>{$message.strSummary|escape}</h3>
    <p>enable_query_cache = true 的情况下、SELECT 的结果将被缓存。</p>
	<h3>{$message.strFeature|escape}</h3>
	<p>可以对查询缓存进行搜索。搜索的对象可以是查询字串和数据库名，也可以进行部分一致搜索。查询字串和数据库名搜索将被作为AND搜索。</p>
    <table>
      <tbody>
        <tr> {if isset($deleteRow) && $deleteRow > 0}
        <tr>
          <td colspan="5">{$deleteRow|escape}{$message.strDeleted|escape}</td>
        </tr>
      {/if}
      <tr>
        <td nowrap="nowrap" class="column">{$message.strQueryStr|escape}</td>
        <td>{if isset($qQueryStr)}
            <input name="qQueryStr" type="text" id="qQueryStr" size="50" value="{$qQueryStr|escape}"/>
            {else}
            <input name="qQueryStr" type="text" id="qQueryStr" size="50" value=""/>
            {/if}
        </td>
      </tr>
      <tr>
        <td nowrap="nowrap" class="column">{$message.strDb|escape}</td>
        <td>{if isset($qDb)}
            <input name="qDb" type="text" id="qDb" size="50" value="{$qDb|escape}"/></td>
            {else}
            <input name="qDb" type="text" id="qDb" size="50" value=""/></td>
            {/if}
      </tr>
      </tbody>
      <tfoot>
      <tr><td colspan="2">
      <input type="submit" name="search" value="{$message.strSearch|escape}" />
      <input type="submit" name="clear" value="{$message.strClear|escape}" />
      </td></tr>
    </table>
    <h3>查询缓存列表</h3>
    <p>目前被缓存的查询字串，数据库名，建立时间将被作为结果显示。每次点击「查询字串」、「数据库」以及「建立时间」后、可以分别进行升序或者降序排序。</p>
	<p>点击在想要删除的数据的左侧的复选框，并按下删除键后，所选的数据将被删除。如果选择最上面的复选框，将选中所有记录。</p>
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
