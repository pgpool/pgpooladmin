<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>{$message.strStatus|escape}</title>
<link href="screen.css" rel="stylesheet" type="text/css" />
</head>
<body>
<h3>{$message.strProcInfo|escape}</h3>
<table>
  <tr>
    <td><label>{$message.strProcId|escape}</label></td>
    <td><label>{$message.strDbName|escape}</label><br /><label>{$message.strConnUser|escape}</label></td>
    <td><label>{$message.strProcTime|escape}</label><br /><label>{$message.strConnTime|escape}</label></td>
    <td><label>{$message.strProtocolMajorVersion|escape}</label><br /><label>{$message.strProtocolNinorVersion|escape}</label></td>
    <td><label>{$message.strConnUsed|escape}</label></td>
  </tr>
  {foreach name=proc key=num item=value from=$procInfo}
    {foreach name=data item=data from=$value}
    {if $smarty.foreach.data.first == true}
      {if $smarty.foreach.proc.iteration % 2 == 0}
      <tr class="even">
      {else}
      <tr class="odd">
      {/if}
        <td rowspan="{$smarty.foreach.data.total}">{$num|escape}</td>
        <td>{$data.0|escape}<br />{$data.1|escape}</td>
        <td>{$data.2|escape}<br />{$data.3|escape}</td>
        <td>{$data.4|escape}<br />{$data.5|escape}</td>
        <td>{$data.6|escape}</td>
      </tr>
    {else}
      {if $smarty.foreach.proc.iteration % 2 == 0}
      <tr class="even">
      {else}
      <tr class="odd">
      {/if}
        <td>{$data.0|escape}<br />{$data.1|escape}</td>
        <td>{$data.2|escape}<br />{$data.3|escape}</td>
        <td>{$data.4|escape}<br />{$data.5|escape}</td>
        <td>{$data.6|escape}</td>
      </tr>
    {/if}    
  {/foreach}
{/foreach}
</table>
</body>
</html>
