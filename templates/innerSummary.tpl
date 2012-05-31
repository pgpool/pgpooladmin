<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>{$message.strNodeStatus|escape}</title>
<link href="screen.css" rel="stylesheet" type="text/css" />
<style type="text/css">
{literal}
td > img {
    vertical-align: middle;
}
{/literal}
</style>
</head>

<body>
<h3>{$message.strPgpoolSummary|escape}</h3>
<table>
  <tbody>
    <tr><td>{$message.strReplicationMode|escape}</td>
    <td>
    {if $params.parallel_mode == 'on'}
    {$message.strInvalidation|escape}
    {elseif $params.replication_mode == 'on'}
    <img src="images/check.png"> {$message.strOn|escape}
    {else}
    <img src="images/no.png"> {$message.strOff|escape}
    {/if}
    </td></tr>

    <tr><td>{$message.strMasterSlaveMode|escape}</td>
    <td>
    {if $params.master_slave_mode == 'on'}
    <img src="images/check.png"> {$message.strOn|escape} / {$params.master_slave_sub_mode|escape}
    {else}
    <img src="images/no.png"> {$message.strOff|escape}
    {/if}
    </td></tr>

    <tr><td>{$message.strParallelMode|escape}</td>
    <td>
    {if $params.parallel_mode == 'on'}
    <img src="images/check.png"> {$message.strOn|escape}
    {else}
    <img src="images/no.png"> {$message.strOff|escape}
    {/if}
    </td></tr>

    <tr><td>{$message.strLoadBalanceMode|escape}</td>
    <td>
    {if $params.parallel_mode == 'on'}
    {$message.strInvalidation|escape}
    {elseif $params.load_balance_mode == 'on'}
    <img src="images/check.png"> {$message.strOn|escape}
    {else}
    <img src="images/no.png"> {$message.strOff|escape}
    {/if}
    </td></tr>
    <tr><td>{$message.strHealthCheck|escape}</td>
    <td>
    {if $params.health_check_period == 0}
    {$message.strInvalidation|escape}
    {else}
    <img src="images/check.png"> {$message.strOn|escape}
    {/if}
    </td></tr>

    <tr><td>{$message.strQueryCache|escape}</td>
    <td>
    {if hasMemqcache()}
        {if $params.memory_cache_enabled == 'on'}
        <img src="images/check.png"> {$message.strOn|escape} / {$params.memqcache_method}
        {else}
        <img src="images/no.png"> {$message.strOff|escape}
        {/if}
    {else}
        {if $params.enable_query_cache == 'on'}
        <img src="images/check.png"> {$message.strOn|escape}
        {else}
        <img src="images/no.png"> {$message.strOff|escape}
        {/if}
    {/if}
    </td></tr>

  </tbody>
</table>
</body>
</html>
