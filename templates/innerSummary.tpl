<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>{$message.strNodeStatus|escape}</title>
<link href="screen.css" rel="stylesheet" type="text/css" />
</head>
<body>
<h3>{$message.strPgpoolSummary|escape}</h3>
<table>
  <tbody>
    <tr><td>{$message.strParallelMode|escape}</td>
    <td>
    {if $params.parallel_mode == 'true'}
    {$message.strPgpool2|escape}
    {else}
    {$message.strPgpool1|escape}
    {/if}
    </td></tr>
    <tr><td>{$message.strQueryCache|escape}</td>
    <td>
    {if $params.enable_query_cache == 'true'}
    {$message.strOn|escape}
    {else}
    {$message.strOff|escape}
    {/if}
    </td></tr>
    <tr><td>{$message.strReplicationMode|escape}</td>
    <td>
    {if $params.parallel_mode == 'true'}
    {$message.strInvalidation|escape}
    {elseif $params.replication_mode == 'true'}
    {$message.strOn|escape}
    {else}
    {$message.strOff|escape}
    {/if}
    </td></tr>
    <tr><td>{$message.strLoadBalanceMode|escape}</td>
    <td>
    {if $params.parallel_mode == 'true'}
    {$message.strInvalidation|escape}
    {elseif $params.load_balance_mode == 'true'}
    {$message.strOn|escape}
    {else}
    {$message.strOff|escape}
    {/if}
    </td></tr>
    <tr><td>{$message.strHealthCheck|escape}</td>
    <td>
    {if $params.health_check_period == 0}
    {$message.strInvalidation|escape}
    {else}
    {$message.strOn|escape}
    {/if}
    </td></tr>
  </tbody>
</table>
</body>
</html>
