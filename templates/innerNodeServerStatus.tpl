<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>{$message.strNodeStatus|escape}</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="screen.css" rel="stylesheet" type="text/css" />
</head>
<body>
{if $nodeCount > 0}
<table>
  <thead>
  <tr>
    <th><label>{$message.strIPaddress|escape}</label></th>
    <th><label>{$message.strPort|escape}</label></th>
    <th><label>{$message.strStatus|escape}</label></th>
    <th></th>
  </thead>
  <tbody>
  {section name=num loop=$nodeServerStatus}
    {if ($smarty.section.num.index+1) % 2 == 0}
    <tr class="even">
    {else}
    <tr class="odd">
    {/if}
    <td class="input">{$nodeServerStatus[num].hostname|escape}</td>
    <td class="input">{$nodeServerStatus[num].port|escape}</td>
    <td class="input">
    {if $nodeServerStatus[num].status == true}
    {$message.strUp|escape}
    </td>
    <td><input type="button" name="detail" value="{$message.strDetail}" onclick="showDetail({$smarty.section.num.index})" /></td>
    {else}
    {$message.strDown|escape}
    </td>
    <td></td>
    {/if}
  {/section}
  </tbody>
</table>
{else}
{$message.strNoNode|escape}
{/if}
</body>
</html>
