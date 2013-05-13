<input type="button" onClick="stopPgsqlButtonHandler({$node_num})"
       {if $nodeInfo.$node_num.is_active == false}disabled{/if}
       value="{$message.strStopPgsql|escape}">

<input type="button" onClick="restartPgsqlHandler({$node_num})"
       {if $nodeInfo.$node_num.is_active == false}disabled{/if}
       value="{$message.strRestartPgsql|escape}">

<input type="button" onClick="sendCommand('reloadPgsql', {$node_num}, '{$message.msgReloadPgpool|escape}')"
       {if $nodeInfo.$node_num.is_active == false}disabled{/if}
       value="{$message.strReloadPgsql|escape}">
|
<input type="button" onClick="sendCommand('removeBackend', {$node_num}, '{$message.msgRemoveBackend|escape}')"
       {if $pgpoolIsActive && $nodeInfo.$node_num.is_active}disabled{/if}
       value="{$message.strRemoveBackend|escape}">
