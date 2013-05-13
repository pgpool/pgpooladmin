<tr>
<th><label>{$message.descBackend_hostname|escape}</label>
<br />backend_hostname{$smarty.section.num.index} (string)</th>
<td><input type="text" id="backend_hostname" name="backend_hostname[]" value="" /></td>
<td rowspan="{if paramExists('backend_flag')}5{else}4{/if}">
</tr>

</tr>
<tr>
<th><label>{$message.descBackend_port|escape}</label>
<br />backend_port{$smarty.section.num.index|escape} (integer)</th>
<td><input type="text" id="backend_port" name="backend_port[]" value="" /></td>
</tr>

<tr>
<th><label>{$message.descBackend_weight|escape}</label>
<br />backend_weight{$smarty.section.num.index|escape} (float)</th>
<td><input type="text" id="backend_weight" name="backend_weight[]" value="" /></td>
</tr>

<tr>
<th><label>{$message.descBackend_data_directory|escape}</label>
<br />backend_data_directory{$smarty.section.num.index|escape} (string)</th>
<td><input type="text" name="backend_data_directory[]" value="" /></td>
</tr>

{if paramExists('backend_flag')}
<tr>
<th><label>{$message.descBackend_flag|escape}</label>
    <br />backend_flag{$smarty.section.num.index|escape} *</th>
<td><select name="backend_flag[]" id="backend_flag[]">
    <option value="ALLOW_TO_FAILOVER" selected>ALLOW_TO_FAILOVER</option>
    <option value="DISALLOW_TO_FAILOVER">DISALLOW_TO_FAILOVER</option>
    </select>
</td>
</tr>
{/if}
