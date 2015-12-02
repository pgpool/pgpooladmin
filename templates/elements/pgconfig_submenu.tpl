<div id="submenu">
  <h3>{$message.strPgConfSetting|escape}</h3>
  <ul>
    <li><a href="#connections">Connections</a></li>
    <li><a href="#pools">Pools</a></li>
    <li><a href="#backends">Backends</a></li>
    <li><a href="#logs">Logs</a></li>
    <li><a href="#file_locations">File Locations</a></li>
    <li><a href="#connection_pooling">Connection Pooling</a></li>
    <li><a href="#replication_mode">Replication Mode</a></li>
    <li><a href="#load_balancing_mode">Load Balancing Mode</a></li>
    <li><a href="#master_slave_mode">Mater/Slave Mode</a></li>
    {if paramExists('parallel_mode')}
    <li><a href="#parallel_mode">{if hasMemqcache()}Parallel Mode
    {else}Parallel Mode and Query Cache{/if}</a></li>
    {/if}
    <li><a href="#health-check">Health Check</a></li>
    <li><a href="#failover">Failover and Failback</a></li>
    <li><a href="#recovery">Online Recovery</a></li>
    {if hasWatchdog()}
    <li><a href="#watchdog">Watchdog</a></li>
    {/if}
    {if hasMemqcache()}
    <li><a href="#memqcache">In Memory Query Cache</a></li>
    {/if}
    {if paramExists('relcache_expire')}
    <li><a href="#others">Others</a></li>
    {/if}
  </ul>
</div>
