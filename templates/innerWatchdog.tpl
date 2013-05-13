<h3>Watchdog
{if $params.delegate_IP != NULL}(VIP: {$params.delegate_IP}){/if}</h3>

{if $smarty.const._PGPOOL2_STATUS_REFRESH_TIME > 0}
    <div class="auto_reloading">
    <span><img src="images/refresh.png">
          Refresh info: {$smarty.const._PGPOOL2_STATUS_REFRESH_TIME} seconds
    </span>
    </div>
    <br clear="all">
{/if}

<div id="watchdog">
<table>
<thead>
<tr>
    <th></th>
    <th><label>{$message.strIPaddress|escape}</label></th>
    <th><label>{$message.strPort|escape}(pgpool-II)</label></th>
    <th><label>{$message.strPort|escape}(Watchdog)</label></th>
    <th><label>{$message.strStatus|escape}</label></th>
</tr>
</thead>
<tbody>
<tr>
    <td>local</td>
    <td>{$params.wd_hostname}</td>
    <td>{$params.port}</td>
    <td>{$params.wd_port}</td>
    <td> ( XXX: no way exists to get status )</td>
</tr>
{section name=num loop=$params.other_pgpool_hostname}
{if ($smarty.section.num.index) % 2 == 0}<tr class="even">{else}<tr class="odd">{/if}
    <td>other {$smarty.section.num.index}</td>
    <td>{$params.other_pgpool_hostname[num]}</td>
    <td>{$params.other_pgpool_port[num]}</td>
    <td>{$params.other_wd_port[num]}</td>
    <td></td>
</tr>
{/section}
</tbody>
<tfoot>
<tr><th colspan="5"></th></tr>
</tfoot>
</table>

<p>[ lifecheck ]
    every{$params.wd_interval} seconds /
    retry upto {$params.wd_life_point} counts /
    by "{$params.wd_lifecheck_query}"</p>
</div>
