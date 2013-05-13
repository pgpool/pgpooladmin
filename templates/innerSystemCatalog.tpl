<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>{$message.strNodeStatus|escape}</title>
<link href="screen.css" rel="stylesheet" type="text/css" />
</head>
<body>
<h2>{$message.strSystemCatalog|escape} (node {$nodeNum})</h2>
<table>
  <thead>
  <tr>
    <th><label>{$message.strIPaddress|escape}</label></th>
    <th><label>{$message.strPort|escape}</label></th>
    <th><label>{$message.strTable|escape}</label></th>
  </tr>
  </thead>
  <tbody>
  <tr><td>{$hostname|escape}</td><td>{$port|escape}</td><td>{$catalog|escape}</td></tr>
  </tbody>
</table>
<p>
<table>
  <thead>
  <tr>
  {foreach from=$results[0] key=column item=value}
    <th><label>{$column|escape}</label></th>
    {/foreach}
  </tr>
  </thead>
  <tbody>
    {section name=num loop=$results}
    {if ($smarty.section.num.index + 1) % 2 == 0}
    <tr class="even">
    {else}
    <tr class="odd">
    {/if}
    {foreach from=$results[num] item=value}
    <td class="input">{$value|escape}</td>
  {/foreach}
  </tr>
  {/section}
  </tbody>
</table>
</body>
</html>
