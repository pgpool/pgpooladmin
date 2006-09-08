<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>{$message.strSystemDb|escape}</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="screen.css" rel="stylesheet" type="text/css" />
</head>
<body>
<div id="header">
  <h1><img src="images/logo.gif" alt="pgpoolAdmin" /></h1>
</div>
<div id="menu">
{include file="menu.tpl"}
</div>
<div id="content">
<div id="help"><a href="{$help|escape}.php"><img src="images/back.gif" />{$message.strBack|escape}</a></div>
  <h2>{$message.strHelp|escape}({$message.strSystemDb|escape})</h2>
  <h3>{$message.strSummary|escape}</h3>
The setting of a parallel query is defined for parallel_mode=true in pgpool.conf. 
  <h3>{$message.strFeature|escape}</h3>
The data type of each column is as follows. <p />
<table>
  <tr>
    <th class="right_border"><label>Column Name</label></th>
    <th class="right_border"><label>Data Type</label></th>
    <th><label>Description</label></th>

  </tr>
  <tr>
    <th class="right_border"><label>Database Name</label></th>
    <td class="right_border">TEXT</td>
    <td>Distributed database name</td>
  </tr>
  <tr>

    <th class="right_border"><label>Schema Name</label></th>
    <td class="right_border">TEXT</td>
    <td>Schema name of database</td>
  </tr>

  <tr>
    <th class="right_border"><label>Table</label></th>
    <td class="right_border">TEXT</td>
    <td>Distributed table name</td>
  </tr>

  <tr>
    <th class="right_border"><label>Column Name of Distributed key</label></th>
    <td class="right_border">TEXT</td>
    <td>Column Name of Distributed key</td>
  </tr>

  <tr>
    <th class="right_border"><label>Column List</label></th>
    <td class="right_border">TEXT[]</td>
    <td>List of row name of table that distributes data</td>
  </tr>
  <tr>
    <th class="right_border"><label>Type List of Column</label></th>

    <td class="right_border">TEXT[]</td>
    <td>List of type of row name</td>
  </tr>
  <tr>
    <th class="right_border"><label>Distributed Function Name</label></th>
    <td class="right_border">TEXT</td>
    <td>Function name that defines partitioning rule</td>

  </tr>
</table>
<p />
<h3>Add</h3>
The value is input to all columns and "Add" button is pushed. <br />
Please enclose each element with a single quotation, and delimit each element by the comma about the column list and the type list of column. 

<h3>Update</h3>
Please click the data base name of the definition that wants to be updated. Please the value must be displayed in the input field and correct and push "Update" button. However, neither the data base name, the schema name nor the table name are revocable. 
<h3>Delete</h3>
Please click the data base name of the definition that wants to be deleted. Please push "Delete" button. The confirmation dialog is displayed and push the "OK" button, please. 
</div>
<div id="footer">
{include file='footer.tpl'}
</div>
</body>
</html>
