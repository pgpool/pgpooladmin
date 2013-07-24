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

<div id="div_log">
    <form action="status.php" name="logForm" method="post" />
      <input type="hidden" name="action" value="log"/>

      <input type="hidden" name="logAction" />
      <input type="hidden" name="logOffset" value="{$logOffset}"/>
      <input type="hidden" name="logEnd" value="{$logEnd}"/>

      <p>
      <input type="button" onClick="reloadLog()"
             value="{$message.strLogReload|escape}"/>
      {if $logAction == 'all'}
      <input type="button" onClick="execLogAction('latest')"
             value="{$message.strLogLatest|escape} {$eachLogLines} {$message.strLogShowLines|escape}"/>
      {else}
      <input type="button" onClick="execLogAction('all')"
             value="{$message.strLogShowAll|escape}"/>
      {/if}
      </p>
      <p>
      <br />
      {if $logAction != 'all'}
          <span>
          {if $logOffset != 0}
          <a href="javascript:void(0)"
             onClick="execLogAction('prev')">{$message.strLogPrev|escape}</a>
          {/if}
          {if $logEnd < $logTotalLines}
          <a href="javascript:void(0)"
             onClick="execLogAction('next')">{$message.strLogNext|escape}</a>
          {/if}
          </span>
      {/if}
      <span>
      {if $logAction == 'all'}
      (Total {$logTotalLines} lines)
      {else}
      ({$logOffset + 1} - {$logEnd}
      of {$logTotalLines} lines)
      {/if}
      </span>
      </p>
    </form>
</div>

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
