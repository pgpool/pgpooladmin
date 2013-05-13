{* --------------------------------------------------------------------- *}
{* Start Options                                                         *}
{* --------------------------------------------------------------------- *}

{if $pgpoolIsActive == false}
    <h3>{$message.strStartOption|escape}</h3>

    <form action="status.php" name="startPgpoolForm" method="post">
    <input type="hidden" name="action" value="startPgpool" />
    <input type="hidden" name="nodeNumber" value="" />

    <table>
    <thead><tr><th colspan="2">{$message.strStartOption|escape}</th></tr></thead>
    <tbody>
    {include file="elements/status_start_option.tpl"}
    </tbody>
    <tfoot><tr>
      <td colspan="2">
      <input type="button" name="command" onclick="execStartPgpool()"
             value="{$message.strStartPgpool|escape}" />
      </td>
    </tr></tfoot>
    </table>
    </form>

{else}
    {* --------------------------------------------------------------------- *}
    {* Command Buttons                                                       *}
    {* --------------------------------------------------------------------- *}

    <div id="commandButtonsDiv" style="visibility: visible">
    <input type="button" name="command" onclick="stopPgpoolButtonHandler()"
           value="{$message.strStopPgpool|escape}" />
    <input type="button" name="command" onclick="restartPgpoolButtonHandler()"
           value="{$message.strRestartPgpool|escape}" />
    <input type="button" name="command" onclick="execReloadPgpool()"
           value="{$message.strReloadPgpool|escape}" />
    </div>

    {* --------------------------------------------------------------------- *}
    {* Stop Options                                                          *}
    {* --------------------------------------------------------------------- *}
    <div id="stopPgpoolOptionDiv" style="visibility: hidden; position: absolute">
    <h3>{$message.strStopOption|escape}</h3>

    <form action="status.php" name="stopPgpoolForm" method="post">
    <input type="hidden" name="action" value="stopPgpool" />
    <input type="hidden" name="nodeNumber" value="" />
    <table>
    <thead><tr><th colspan="2">{$message.strStopOption|escape}</th></tr></thead>
    <tfoot><tr>
      <td colspan="2">
      <input type="button" name="command" onclick="execStopPgpool()"
             value="{$message.strExecute|escape}" />
      <input type="button" name="command" onclick="cancelPgpoolButtonHandler()"
             value="{$message.strCancel|escape}" />
      </td>
    </tr></tfoot>
    <tbody>
    {include file="elements/status_stop_option.tpl"}
    </tbody>
    </table>
    </form>
    </div>

    {* --------------------------------------------------------------------- *}
    {* Restart Options                                                       *}
    {* --------------------------------------------------------------------- *}
    <div id="restartPgpoolOptionDiv" style="visibility: hidden; position: absolute">
    <h3>{$message.strRestartOption|escape}</h3>

    <form action="status.php" name="restartPgpoolForm" method="post">
    <input type="hidden" name="action" value="restartPgpool" />
    <input type="hidden" name="nodeNumber" value="" />
    <table>
    <thead><tr><th colspan="2">{$message.strRestartOption|escape}</th></tr></thead>
    <tfoot><tr>
      <td colspan="2">
      <input type="button" name="command" onclick="execRestartPgpool()"
             value="{$message.strExecute|escape}" />
      <input type="button" name="command" onclick="cancelPgpoolButtonHandler()"
             value="{$message.strCancel|escape}" />
      </td>
    </tr></tfoot>
    <tbody>
    {include file="elements/status_stop_option.tpl"}
    {include file="elements/status_start_option.tpl"}
    </tbody>
    </table>
    </form>
    </div>

{/if}

{* --------------------------------------------------------------------- *}
{* Start/Stop/Restart messages                                           */
{* --------------------------------------------------------------------- *}

{if isset($pgpoolStatus)}
    <div class="message">
    <h3>Messages</h3>
        <p>{$pgpoolStatus|escape}</p>
        <p>
        {foreach from=$pgpoolMessage item=lines}
        {$lines|escape}<br />
        {/foreach}
        </p>
    </div>
{/if}
