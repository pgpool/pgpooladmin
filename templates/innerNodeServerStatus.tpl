<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>{$message.strNodeStatus|escape}</title>
<link href="screen.css" rel="stylesheet" type="text/css" />
</head>
<body>
{if $nodeCount > 0}
<table>
  <thead>
  <tr>
    <th></th>
    <th><label>{$message.strIPaddress|escape}</label></th>
    <th><label>{$message.strPort|escape}</label></th>
    <th colspan="2"><label>{$message.strStatus|escape}</label></th>
    <th></th>
  </thead>
  <tbody>
  {$i = 0}
  {foreach from=$nodeServerStatus key=node_num item=v}
    {$i = $i + 1}
    <tr class="{if $i % 2 == 0}even{else}odd{/if}">
    <td class="input">node {$node_num}</td>
    <td class="input">{$nodeServerStatus.$node_num.hostname|escape}</td>
    <td class="input">{$nodeServerStatus.$node_num.port|escape}</td>
    <td>
    {if $pgpoolIsActive}
        {if $nodeServerStatus.$node_num.status == $smarty.const.NODE_ACTIVE_NO_CONNECT}
          {$message.strNodeStatus1|escape}
        {elseif $nodeServerStatus.$node_num.status == $smarty.const.NODE_ACTIVE_CONNECTED}
          {$message.strNodeStatus2|escape}
        {elseif $nodeServerStatus.$node_num.status == $smarty.const.NODE_DOWN}
          {$message.strNodeStatus3|escape}
        {/if}
    {/if}
    </td>
    {if $nodeServerStatus.$node_num.is_active}
        <td class="input">
        postgres: {$message.strUp|escape}
        </td>
        <td>
        <input type="button" name="detail" value="{$message.strSystemCatalog|escape}"
               {if $smarty.section.num.index == $nodeNum}class="active_command"{/if}
               onclick="showDetail({$node_num})" /></td>
    {else}
        <td class="input">
        postgres: {$message.strDown|escape}
        </td>
        <td>
        <input type="button" name="detail" value="{$message.strSystemCatalog|escape}" disabled /></td>
        </td>
    {/if}
  {/foreach}
  </tbody>
</table>
{else}
    {$message.strNoNode|escape}
{/if}
</body>
</html>
