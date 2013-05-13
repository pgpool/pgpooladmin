{if hasMemqCache() == false}
    <tr><td>{$message.strCmdC|escape} (-c)</td>
      {if $c == 1}
      <td><input type="checkbox" name="c" checked="checked" /></td>
      {else}
      <td><input type="checkbox" name="c" /></td>
      {/if}
    </tr>
{/if}

<tr><td>{$message.strCmdLargeD|escape} (-D)</td>
  {if $D == 1}
  <td><input type="checkbox" name="D" checked="checked" /></td>
  {else}
  <td><input type="checkbox" name="D" /></td>
  {/if}
</tr>

<tr><td>{$message.strCmdN|escape} (-n)</td>
  {if $n == 1}
  <td><input type="checkbox" name="n" checked="checked" /></td>
  {else}
  <td><input type="checkbox" name="n" /></td>
  {/if}
</tr>

{if hasMemqCache()}
<tr><td>{$message.strCmdLargeC|escape} (-C)</td>
  {if $C == 1}
  <td><input type="checkbox" name="C" checked="checked" /></td>
  {else}
  <td><input type="checkbox" name="C" /></td>
  {/if}
</tr>
{/if}

<tr><td>{$message.strCmdD|escape} (-d)</td>
  {if $d == 1}
  <td><input type="checkbox" name="d" checked="checked" /></td>
  {else}
  <td><input type="checkbox" name="d" /></td>
  {/if}
</tr>

<tr><td>{$message.strCmdPgpoolFile|escape} (-f)</td>
    <td>{$pgpoolConf|escape}</td>
</tr>

<tr><td>{$message.strCmdPcpFile|escape} (-F)</td>
    <td>{$pcpConf|escape}</td>
</tr>
