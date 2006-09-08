<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>{$message.strSystemDb|escape}</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="screen.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">
var msgDeleteConfirm = "{$message.msgDeleteConfirm|escape}";
{literal}
<!--
var count;
function CheckboxChange(chkBox){
  for(count = 0; count < document.queryCache.elements.length; count++){
    document.queryCache.elements[count].checked = chkBox.checked;
  }
}

function sendAction(action) {
    document.systemDb.action.value=action;
    document.systemDb.submit();
}

function deleteAction() {
	if(window.confirm(msgDeleteConfirm)){ 
		document.systemDb.action.value="delete";
		document.systemDb.submit();
	}
}

// -->
{/literal}
</script>
</head>
<body>
<div id="header">
  <h1><img src="images/logo.gif" alt="pgpoolAdmin" /></h1>
</div>
<div id="menu">
{include file="menu.tpl"}
</div>
<div id="content">
<div id="help"><a href="help.php?help={$help|escape}"><img src="images/question.gif" alt="help"/>{$message.strHelp|escape}</a></div>
  <h2>{$message.strSystemDb|escape}</h2>
  <form name="systemDb" action="systemDb.php" method="post">
    <input type="hidden" name="action" value="update" />
    <table>
      <tfoot>
        <tr><td colspan="7"> {if $isUpdate == true}
          <input type="button" name="submitUpdate" value="{$message.strUpdate|escape}" onclick="sendAction('update')"/>
          <input type="button" name="submitDelete" value="{$message.strDelete|escape}" onclick="deleteAction()"/>
          <input type="button" name="submitCancel" value="{$message.strCancel|escape}" onclick="sendAction('cancel')"/>
          {else}
          <input type="button" name="submitAdd" value="{$message.strAdd|escape}" onclick="sendAction('add')"/>
          {/if} </td>
      </tr>
      </tfoot>
      <tbody>
      
      {if $error}
      <tr>
        <td colspan="4"> {$error|escape} </td>
      </tr>
      {/if}
      {if $isUpdate == true}
       <tr>
        <th><label>{$message.strDbName|escape}</label></th>
        <td></td>
        <td><input type="text" name="dbname" value="{$result.dbname|escape}" readonly="readonly" /></td>
        <td></td>
      </tr><tr>
        <th><label>{$message.strSchemaName|escape}</label></th>
        <td></td>
        <td><input type="text" name="schema_name" value="{$result.schema_name|escape}" readonly="readonly" /></td>
        <td></td>
      </tr><tr>
        <th><label>{$message.strTable|escape}</label></th>
        <td></td>
        <td><input type="text" name="table_name" value="{$result.table_name|escape}" readonly="readonly" /></td>
        <td></td>
      </tr><tr>
        <th><label>{$message.strColName|escape}</label></th>
        <td></td>
        <td><input type="text" name="col_name" value="{$result.col_name|escape}" /></td>
        <td></td>
      </tr><tr>
        <th><label>{$message.strColList|escape}</label></th>
        <td>{ldelim}</td>
        <td>
          <input type="text" name="col_list" size="50" value="{$result.col_list|escape}" />
          </td>
        <td>{rdelim}</td>
      </tr><tr>
        <th><label>{$message.strTypeList|escape}</label></th>
        <td>{ldelim}</td>
        <td>
          <input type="text" name="type_list" size="50" value="{$result.type_list|escape}" />
          </td>
        <td>{rdelim}</td>
      </tr><tr>
        <th><label>{$message.strDistDefFunc|escape}</label></th>
        <td></td>
        <td><input type="text" name="dist_def_func" value="{$result.dist_def_func|escape}" /></td>
        <td></td>
      </tr>
        {else}
        <tr>
        <th><label>{$message.strDbName|escape}</label></th>
        <td></td>
        <td><input type="text" name="dbname" value="{$result.dbname|escape}" /></td>
        <td></td>
      </tr><tr>
        <th><label>{$message.strSchemaName|escape}</label></th>
        <td></td>
        <td><input type="text" name="schema_name" value="{$result.schema_name|escape}" /></td>
        <td></td>
      </tr><tr>
        <th><label>{$message.strTable|escape}</label></th>
        <td></td>
        <td><input type="text" name="table_name" value="{$result.table_name|escape}" /></td>
        <td></td>
      </tr><tr>
        <th><label>{$message.strColName|escape}</label></th>
        <td></td>
        <td><input type="text" name="col_name" value="{$result.col_name|escape}" /></td>
        <td></td>
      </tr><tr>
        <th><label>{$message.strColList|escape}</label></th>
        <td>{ldelim}</td>
        <td>
          <input type="text" name="col_list" size="50" value="{$result.col_list|escape}" />
          </td>
        <td>{rdelim}</td>
      </tr><tr>
        <th><label>{$message.strTypeList|escape}</label></th>
        <td>{ldelim}</td>
        <td>
          <input type="text" name="type_list" size="50" value="{$result.type_list|escape}" />
          </td>
        <td>{rdelim}</td>
      </tr><tr>
        <th><label>{$message.strDistDefFunc|escape}</label></th>
        <td></td>
        <td><input type="text" name="dist_def_func" value="{$result.dist_def_func|escape}" /></td>
        <td></td>
      </tr>
        {/if}
      </tbody>
      </table>
      <p />
      <table>
      <thead>
      <tr>
        <th><label>{$message.strDbName|escape}</label></th>
        <th><label>{$message.strSchemaName|escape}</label></th>
        <th><label>{$message.strTable|escape}</label></th>
        <th><label>{$message.strColName|escape}</label></th>
        <th><label>{$message.strColList|escape}</label></th>
        <th><label>{$message.strTypeList|escape}</label></th>
        <th><label>{$message.strDistDefFunc|escape}</label></th>
      </tr>
      </thead>
      <tbody>
      {foreach name=systemdb from=$systemDb item=list}
        {if ($smarty.foreach.systemdb.iteration) % 2 == 0}
        <tr class="even">
        {else}
        <tr class="odd">
        {/if}
        <td rowspan="{$list.listLength|escape}"><a href="systemDb.php?dbname={$list.dbname|escape}&amp;schema_name={$list.schema_name|escape}&amp;table_name={$list.table_name|escape}">{$list.dbname|escape}</a></td>
        <td rowspan="{$list.listLength|escape}">{$list.schema_name|escape}</td>
        <td rowspan="{$list.listLength|escape}">{$list.table_name|escape}</td>
        <td rowspan="{$list.listLength|escape}">{$list.col_name|escape}</td>
        <td>{$list.col_list[0]|escape}</td>
        <td>{$list.type_list[0]|escape}</td>
        <td rowspan="{$list.listLength|escape}">{$list.dist_def_func|escape}</td>
      </tr>
        {section name=num loop=$list.col_list start=1}
        {if ($smarty.foreach.systemdb.iteration) % 2 == 0}
        <tr class="even">
        {else}
        <tr class="odd">
        {/if}
       <td>
        {$list.col_list[num]|escape}
      </td><td>
        {$list.type_list[num]|escape}
      </td></tr>
        {/section}
      {/foreach}
      </tbody>
    </table>
  </form>
</div>
<div id="footer">
{include file='footer.tpl'}
</div>
</body>
</html>
