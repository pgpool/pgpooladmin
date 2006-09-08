<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>{$message.strNodeStatus|escape}</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="screen.css" rel="stylesheet" type="text/css" />
</head>
<body>
<table>
  <thead>
  </thead>
  <tbody>
  {section name=num loop=$logFile}
    {if $logFile[num][2] == 'ERROR:' }
    <tr class="error">
    {elseif  ($smarty.section.num.index+1) % 2 == 0}
    <tr class="even">
    {else}
    <tr class="odd">
    {/if}
    <td>{$logFile[num][0]|escape}</td>
    <td>{$logFile[num][1]|escape}</td>
    <td>{$logFile[num][2]|escape}</td>
    <td>{$logFile[num][3]|escape}</td>
    <td>{$logFile[num][4]|escape}</td>
    <td>{$logFile[num][5]|escape}</td>
    <td></td>
  {/section}
  </tbody>
</table>
</body>
</html>
