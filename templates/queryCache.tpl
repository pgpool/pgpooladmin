<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>{$message.strQueryCache|escape}</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="screen.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">
{literal}
<!--
var count;
function checkboxChange(chkBox){
  for(count = 0; count < document.queryCache.elements.length; count++){
    document.queryCache.elements[count].checked = chkBox.checked;
  }
}

function sendAction(action) {
    document.queryCache.action = 'queryCache.php?action=' + action;
    document.queryCache.submit();
}
// -->
{/literal}
</script>
<!-- InstanceEndEditable -->
</head>
<body>
<div id="header">
  <h1><img src="images/logo.gif" alt="pgpoolAdmin" /></h1>
</div>
<div id="menu">
{include file="menu.tpl"}
</div>
<div id="content">
<div id="help"><a href="help.php?help={$help|escape}"><img src="images/question.gif" alt="help"/>{$message.strHelp|escape}</a></div>
  <h2>{$message.strQueryCache|escape}</h2>
  <form action="queryCache.php" method="post" name="queryCache" id="queryCache">
    <h3>{$message.strSearch|escape}</h3>
    <table>
      <tfoot>
      <tr><td colspan="2">
      <input type="submit" name="search" value="{$message.strSearch|escape}" onclick="sendAction('search')"/>
      <input type="submit" name="clear" value="{$message.strClear|escape}" onclick="sendAction('clear')"/>
      </td></tr>
      </tfoot>
      <tbody>
        {if $deleteRow > 0}
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
    </table>
    <p>
    <table>
      <tfoot>
      <tr><td colspan="4">
      <input type="submit" name="ButtonName" value="{$message.strDelete|escape}" onclick="sendAction('delete')"/>
      </td></tr>
      </tfoot>
      <tbody>
        <tr>
          <th><input type="checkbox" name="all" onclick="checkboxChange(this)" value="" /></th>
          <th> {if $col == "query" && $sort == "ascending"} <a href="queryCache.php?col=query&sort=descending"><img src="images/ascending.gif" alt="ascending" />{$message.strQueryStr|escape}</a> {elseif $col == "query" && $sort == "descending"} <a href="queryCache.php?col=query&sort=ascending"><img src="images/descending.gif" alt="descending" />{$message.strQueryStr|escape}</a> {else} <img src="images/spacer.gif" width="8" height="8" alt="spacer" /><a href="queryCache.php?col=query&sort=ascending">{$message.strQueryStr|escape}</a> {/if} </th>
          <th> {if $col == "dbname" && $sort == "ascending"} <a href="queryCache.php?col=dbname&sort=descending"><img src="images/ascending.gif" alt="ascending" />{$message.strDb|escape}</a> {elseif $col == "dbname" && $sort == "descending"} <a href="queryCache.php?col=dbname&sort=ascending"><img src="images/descending.gif" alt="descending" />{$message.strDb|escape}</a> {else} <img src="images/spacer.gif" width="8" height="8" alt="spacer" /><a href="queryCache.php?col=dbname&sort=ascending">{$message.strDb|escape}</a> {/if} </th>
          <th> {if $col == "create_time" && $sort == "ascending"} <a href="queryCache.php?col=create_time&sort=descending"><img src="images/ascending.gif" alt="ascending" />{$message.strCreateTime|escape}</a> {elseif $col == "create_time" && $sort == "descending"} <a href="queryCache.php?col=create_time&sort=ascending"><img src="images/descending.gif" alt="descending" />{$message.strCreateTime|escape}</a> {else} <img src="images/spacer.gif" width="8" height="8" alt="spacer" /><a href="queryCache.php?col=create_time&sort=ascending">{$message.strCreateTime|escape}</a> {/if} </th>
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
    </table>
    </p>
  </form>
</div>
<div id="footer">
{include file='footer.tpl'}
</div>
</body>
</html>
