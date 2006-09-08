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
  <h2>{$message.strHelp|escape}({$message.strQueryCache})</h2>
    <h3>{$message.strSummary|escape}</h3>
    <p>It is possible to cache the query executed on pgpool, if enable_query_cache of pgpool.conf is true.</p>
    <h3>{$message.strFeature|escape}</h3>
	<p>It is possible to search for the data that exists in the query cache. It searches for the query string and the database name, and it processes it by the partial agreement retrieval. It becomes a search for the logical product with the query string and the database name. 
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
    <h3>Query cache list</h3>
	<p>
The query string, database name and create time which existing in cache is displayed. When "Query", "Database" and "Create Time" clicked, the records is sorted. Whenever clicking, it is sorted in the ascending order or the descending order. </p>

	<p>When the check is put in the check box in the left of the data that wants to be deleted, and the deletion button is pushed, it is deleted.
</p>
    <table>
      <tbody>
        <tr>
          <th><input type="checkbox" name="all" value="" /></th>
          <th>{$message.strQueryStr|escape}</th>
          <th>{$message.strDb|escape}</th>
          <th>{$message.strCreateTime|escape}</th>
        </tr>
      {foreach name=querycache from=$queryCache item=cache}
      {if $smarty.foreach.querycache.iteration % 2 == 0}
      <tr class="even">
      {else}
      <tr class="odd">
      {/if}
        <td><input type="checkbox" name="hash[]" value="{$cache.hash|escape}" /></td>
        <td>{$cache.query|escape}</td>
        <td>{$cache.dbname|escape}</td>
        <td>{$cache.create_time|escape}</td>
      </tr>
      {/foreach}
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
