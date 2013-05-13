<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>{$message.strNodeStatus|escape}</title>
<link href="screen.css" rel="stylesheet" type="text/css" />
</head>
<body>

<h3>{$message.strLog|escape}</h3>

{if $smarty.const._PGPOOL2_STATUS_REFRESH_TIME > 0}
    <div class="auto_reloading">
    <span><img src="images/refresh.png">
          Refresh info: {$refreshTimeLog} seconds
    </span>
    </div>
    <br clear="all">
{/if}

<table>
  <thead>
  </thead>
  <tbody>
  {section name=num loop=$logFile}
    {if $logFile[num]['level'] == 'ERROR:' }
    <tr class="error">
    {elseif  ($smarty.section.num.index + 1) % 2 == 0}
    <tr class="even">
    {else}
    <tr class="odd">
    {/if}
    <td>{$logFile[num].timestamp|escape}</td>
    <td>{$logFile[num].level|escape}</td>
    <td>{$logFile[num].pid|escape}</td>
    <td>{$logFile[num].message|escape}</td>
  {/section}
  </tbody>
</table>
</body>
</html>
