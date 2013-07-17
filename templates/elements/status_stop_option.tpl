<tr><td>{$message.strCmdM|escape} (-m)</td><td>
  <select name="stop_mode">
  {if $m == 's'}
       <option value="s" selected="selected">smart</option>
       <option value="f">fast</option>
       <option value="i">immediate</option>
  {elseif $m == 'f'}
       <option value="s">smart</option>
       <option value="f" selected="selected">fast</option>
       <option value="i">immediate</option>
  {elseif $m == 'i'}
       <option value="s">smart</option>
       <option value="f">fast</option>
       <option value="i" selected="selected">immediate</option>
  {else}
       <option value="s">smart</option>
       <option value="f">fast</option>
       <option value="i">immediate</option>
  {/if}
  </select>

  <input type="hidden" name="action" />
  <input type="hidden" name="nodeNumber" />
  </td>
</tr>
