  <ul>
  {if $isLogin == 'true'}
    <li><strong><a href="status.php">{$message.strPgpoolStatus|escape}</a></strong></li>
    <li><a href="nodeServerStatus.php">{$message.strNodeStatus|escape}</a></li>
    {if hasMemqCache() == false}
    <li><a href="queryCache.php">{$message.strQueryCache|escape}</a></li>
    {/if}
    <li><a href="systemDb.php">{$message.strSystemDb|escape}</a></li>
    <li><a href="pgconfig.php">{$message.strPgConfSetting|escape}</a></li>
    <li><a href="config.php">{$message.strSetting|escape}</a></li>
    <li><a href="changePassword.php">{$message.strChangePassword|escape}</a></li>
    <li><a href="logout.php">{$message.strLogout|escape}</a></li>
  {/if}
  {if $isHelp == 'true'}
    <li><a href="help.php?help=errorCode">{$message.strErrorCode|escape}</a></li>
  {/if}
  </ul>
