<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>{$message.strNodeStatus|escape}</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="screen.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">
<!--
{literal}
function load() {
    var xmlhttp = false; 

    if (typeof XMLHttpRequest!='undefined')
        xmlhttp = new XMLHttpRequest();
    else
        xmlhttp = new ActiveXObject("MSXML2.XMLHTTP");

    if (!xmlhttp) {
        alert('Sorry, cannot use XMLHttpRequest');
        return;
    }

    xmlhttp.onreadystatechange = function() {
        if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
            var content = document.getElementById('status');
            var ret = xmlhttp.responseText;

            content.innerHTML  = ret;
        }
    }
    xmlhttp.open('GET', 'innerNodeServerStatus.php', true);
    xmlhttp.setRequestHeader("If-Modified-Since", "Thu, 01 Jun 1970 00:00:00 GMT");
    xmlhttp.send("");
}

function showDetail(num) {
    var catalog = "pg_settings";
    var xmlhttp = false; 
    var url = "";

    if (typeof XMLHttpRequest!='undefined')
        xmlhttp = new XMLHttpRequest();
    else
        xmlhttp = new ActiveXObject("MSXML2.XMLHTTP");

    if (!xmlhttp) {
        alert('Sorry, cannot use XMLHttpRequest');
        return;
    }

    xmlhttp.onreadystatechange = function() {
        if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
            var content = document.getElementById('detailInfo');
            var ret = xmlhttp.responseText;

            content.innerHTML  = ret;
        }
    }
    url = "innerSystemCatalog.php?num=" + num + "&catalog=" + catalog;
    xmlhttp.open('GET', url, true);
    xmlhttp.setRequestHeader("If-Modified-Since", "Thu, 01 Jun 1970 00:00:00 GMT");
    xmlhttp.send("");
}

// -->
</script>
{/literal}
</head>
<body onload="load()">
<div id="header">
  <h1><img src="images/logo.gif" alt="pgpoolAdmin" /></h1>
</div>
<div id="menu">
{include file="menu.tpl"}
</div>
<div id="content">
<div id="help"><a href="help.php?help={$help|escape}"><img src="images/question.gif" alt="help"/>{$message.strHelp|escape}</a></div>
<h2>{$message.strNodeStatus|escape}</h2>
  <div id="status">{$message.strPleaseWait|escape}</div>
<p>
  <div id="detailInfo"></div>
</p>  
</div>
<div id="footer">
{include file='footer.tpl'}
</div>
</body>
</html>
