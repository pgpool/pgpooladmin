<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>{$message.strSystemDb|escape}</title>
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
    在 pgpool.conf 文件里设置 parallel_mode=true 后，可以进行并行查询。
  <h3>{$message.strFeature|escape}</h3>
每一列的信息如下。<p />
<table>
  <tr>
    <th class="right_border"><label>列名</label></th>
    <th class="right_border"><label>数据类型</label></th>
    <th><label>説明</label></th>
  </tr>
  <tr>
    <th class="right_border"><label>{$message.strDbName|escape}</label></th>
    <td class="right_border">TEXT</td>
    <td>分区数据库名</td>
  </tr>
  <tr>
    <th class="right_border"><label>{$message.strSchemaName|escape}</label></th>
    <td class="right_border">TEXT</td>
    <td>数据库模式名</td>
  </tr>
  <tr>
    <th class="right_border"><label>{$message.strTable|escape}</label></th>
    <td class="right_border">TEXT</td>
    <td>分区表名</td>
  </tr>
  <tr>
    <th class="right_border"><label>{$message.strColName|escape}</label></th>
    <td class="right_border">TEXT</td>
    <td>用于分区的列名</td>
  </tr>
  <tr>
    <th class="right_border"><label>{$message.strColList|escape}</label></th>
    <td class="right_border">TEXT[]</td>
    <td>分区表的列名的列表</td>
  </tr>
  <tr>
    <th class="right_border"><label>{$message.strTypeList|escape}</label></th>
    <td class="right_border">TEXT[]</td>
    <td>列的数据类型的列表</td>
  </tr>
  <tr>
    <th class="right_border"><label>{$message.strDistDefFunc|escape}</label></th>
    <td class="right_border">TEXT</td>
    <td>定义了分区规则的函数名</td>
  </tr>
</table>
<p />
<h3>添加</h3>
在所有列里输入值后，按「添加」按钮。<br />
列名列表和数据类型列表的每个值需要加上单引号，并且用逗号间隔。
<h3>更新</h3>
更新时，点击需要更新定义的数据库名，修改输入框里被表示的数据后按「更新」键即可更新。但是，数据库名，模式名，表名不能更改。
<h3>删除</h3>
删除时，点击需要删除定义的数据库名，按「删除」键后，将跳出确认对话框，按「OK」后即可删除。
</div>
<div id="footer">
{include file='footer.tpl'}
</div>
</body>
</html>
