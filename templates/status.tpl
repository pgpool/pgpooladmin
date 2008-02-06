<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>{$message.strPgpoolStatus|escape}</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="screen.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">
<!--

var strConnError = "{$message.strConnectionError|escape}";
var strUp = "{$message.strUp|escape}";
var strDown = "{$message.strDown|escape}";
var strDataError = "{$message.strDataError|escape}";
var refreshTime = "{$refreshTime|escape}";
var view = "{$viewPHP|escape}";
var msgStopPgpool = "{$message.msgStopPgpool|escape}";
var msgRestartPgpool = "{$message.msgRestartPgpool|escape}";
var msgReloadPgpool = "{$message.msgReloadPgpool|escape}";

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
            if(view != "innerLog.php")
                timer(2000);
        }
    }
    xmlhttp.open('GET', view, true);
    xmlhttp.setRequestHeader("If-Modified-Since", "Thu, 01 Jun 1970 00:00:00 GMT");
    xmlhttp.send("");
}

function reload() {
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
            if(refreshTime > 0)
                timer(refreshTime);
        }
    }
    xmlhttp.open('GET', view, true);
    xmlhttp.setRequestHeader("If-Modified-Since", "Thu, 01 Jun 1970 00:00:00 GMT");
    xmlhttp.send("");
}

function timer(interval) {
	setTimeout("reload()",interval);
}

function sendCommand(command, nodeNumber){
    document.Command.action.value= command;
    document.Command.nodeNumber.value= nodeNumber;
    document.Command.submit();
}

function startPgpool() {
    document.Command.action.value= "start";
    document.Command.submit();
}

function stopPgpool() {
    var stopOption = document.getElementById('stopOption');
    stopOption.style.visibility = "visible";
    stopOption.style.position = "";
    stopOption.style.height = "";
    var cmdBtn = document.getElementById('cmdBtn');
    cmdBtn.style.visibility = "hidden";
    cmdBtn.style.position = "absolute";
    cmdBtn.style.height = "0";
}

function restartPgpool() {
    var stopOption = document.getElementById('stopOption');
    stopOption.style.visibility = "hidden";
    stopOption.style.position = "absolute";
    stopOption.style.height = "0";
    var restartOption = document.getElementById('restartOption');
    restartOption.style.visibility = "visible";
    restartOption.style.position = "";
    restartOption.style.height = "";
    var cmdBtn = document.getElementById('cmdBtn');
    cmdBtn.style.visibility = "hidden";
    cmdBtn.style.position = "absolute";
    cmdBtn.style.height = "0";
}

function cancelCmd() {
    var stopOption = document.getElementById('stopOption');
    stopOption.style.visibility = "hidden";
    stopOption.style.position = "absolute";
    stopOption.style.height = "0";
    var restartOption = document.getElementById('restartOption');
    restartOption.style.visibility = "hidden";
    restartOption.style.position = "absolute";
    restartOption.style.height = "0";
    var cmdBtn = document.getElementById('cmdBtn');
    cmdBtn.style.visibility = "visible";
    cmdBtn.style.position = "";
    cmdBtn.style.height = "";
}

function execRestartPgpool() {
   if(window.confirm(msgRestartPgpool)){ 
    document.Command.action.value= "restart";
    document.Command.submit();
   }
}

function execReloadPgpool() {
   if(window.confirm(msgReloadPgpool)){ 
    document.Command.action.value= "reload";
    document.Command.submit();
   }
}

function execStopPgpool() {
   if(window.confirm(msgStopPgpool)){ 
    document.Command.action.value= "stop";
    document.Command.submit();
   }
}

function changeView(chView){
    document.Command.action.value= chView;
    document.Command.submit();
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
<form action="status.php" name="Command" method="post">
  <input type="hidden" name="action" value="" />
  <input type="hidden" name="nodeNumber" value="" />
<h2>{$message.strPgpoolStatus|escape}</h2>
{if $pgpoolIsActive == true}
<p>
    <input type="button" name="command" onclick="changeView('summary')" value="{$message.strPgpoolSummary|escape}" />
    <input type="button" name="command" onclick="changeView('proc')" value="{$message.strProcInfo|escape}" />
    <input type="button" name="command" onclick="changeView('node')" value="{$message.strNodeInfo|escape}" />
    {if $n == 1 && $pipe == 0}
    <input type="button" name="command" onclick="changeView('log')" value="{$message.strLog|escape}" />
    {/if}
</p>    
  <div id="status"></div>
<p>
    <input type="button" name="command" onclick="changeView('summary')" value="{$message.strPgpoolSummary|escape}" />
    <input type="button" name="command" onclick="changeView('proc')" value="{$message.strProcInfo|escape}" />
    <input type="button" name="command" onclick="changeView('node')" value="{$message.strNodeInfo|escape}" />
    {if $n == 1 && $pipe == 0}
    <input type="button" name="command" onclick="changeView('log')" value="{$message.strLog|escape}" />
    {/if}
</p>
{else}
{$message.strStopPgpool|escape}
{/if}
<h2>{$message.strPgpool|escape}</h2>
    {if $pgpoolIsActive == false}
    <table>
    <thead><tr><th colspan="2">{$message.strStartOption|escape}</th></tr></thead>
    <tfoot>
    <tr><td colspan="2"><input type="button" name="command" onclick="startPgpool()" value="{$message.strStartPgpool|escape}" /></td></tr></tfoot>
    <tbody>
        <tr>
          <tr><td>{$message.strCmdC|escape}(-c)</td>
          {if $c == 1}
          <td><input type="checkbox" name="c" checked="checked" /></td>
          {else}
          <td><input type="checkbox" name="c" /></td>
          {/if}
          </tr>
          <tr><td>{$message.strCmdN|escape}(-n)</td>
          {if $n == 1}
          <td><input type="checkbox" name="n" checked="checked" /></td>
          {else}
          <td><input type="checkbox" name="n" /></td>
          {/if}
          </tr>
          <tr><td>{$message.strCmdD|escape}(-d)</td>
          {if $d == 1}
          <td><input type="checkbox" name="d" checked="checked" /></td>
          {else}
          <td><input type="checkbox" name="d" /></td>
          {/if}
          </tr>
          <tr><td>{$message.strCmdPgpoolFile|escape}(-f)</td>
          <td>{$pgpoolConf|escape}</td>
          </tr>
          <tr><td>{$message.strCmdPcpFile|escape}(-F)</td>
          <td>{$pcpConf|escape}</td>
          </tr>
    </tbody>
    </table>
    {else}
    <div id="cmdBtn" style="visibility: visible">
    <input type="button" name="command" onclick="stopPgpool()" value="{$message.strStopPgpool|escape}" />
    <input type="button" name="command" onclick="restartPgpool()" value="{$message.strRestartPgpool|escape}" />
    <input type="button" name="command" onclick="execReloadPgpool()" value="{$message.strReloadPgpool|escape}" />
    </div>
    <div id="stopOption" style="visibility: hidden; position: absolute">
    <table>
    <thead><tr><th colspan="2">{$message.strStopOption|escape}</th></tr></thead>
    <tfoot>
    <tr><td colspan="2">
    <input type="button" name="command" onclick="execStopPgpool()" value="{$message.strExecute|escape}" />
    <input type="button" name="command" onclick="cancelCmd()" value="{$message.strCancel|escape}" />
    </td></tr></tfoot>
    <tbody>
          <tr><td>{$message.strCmdM|escape}(-m)</td><td><select name="stop_mode">
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
          </td></tr>
    </tbody>
    </table>
    </div>
    <div id="restartOption" style="visibility: hidden; position: absolute">
    <table>
    <thead><tr><th colspan="2">{$message.strRestartOption|escape}</th></tr></thead>
    <tfoot>
    <tr><td colspan="2">
    <input type="button" name="command" onclick="execRestartPgpool()" value="{$message.strExecute|escape}" />
    <input type="button" name="command" onclick="cancelCmd()" value="{$message.strCancel|escape}" />
    </td></tr></tfoot>
    <tbody>
        <tr>
          <tr><td>{$message.strCmdC|escape}(-c)</td>
          {if $c == 1}
          <td><input type="checkbox" name="c" checked="checked" /></td>
          {else}
          <td><input type="checkbox" name="c" /></td>
          {/if}
          </tr>
          <tr><td>{$message.strCmdN|escape}(-n)</td>
          {if $n == 1}
          <td><input type="checkbox" name="n" checked="checked" /></td>
          {else}
          <td><input type="checkbox" name="n" /></td>
          {/if}
          </tr>
          <tr><td>{$message.strCmdD|escape}(-d)</td>
          {if $d == 1}
          <td><input type="checkbox" name="d" checked="checked" /></td>
          {else}
          <td><input type="checkbox" name="d" /></td>
          {/if}
          </tr>
          <tr><td>{$message.strCmdM|escape}(-m)</td><td><select name="restart_mode">
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
          </td></tr>
          <tr><td>{$message.strCmdPgpoolFile|escape}(-f)</td>
          <td>{$pgpoolConf|escape}</td>
          </tr>
          <tr><td>{$message.strCmdPcpFile|escape}(-F)</td>
          <td>{$pcpConf|escape}</td>
          </tr>
    </tbody>
    </table>
    </div>
    {/if}
    <p>{$pgpoolStatus|escape}</p>
    <p>
    {foreach from=$pgpoolMessage item=lines}
    {$lines|escape}<br />
    {/foreach}
    </p>
</form>
</div>
<div id="footer">
{include file='footer.tpl'}
</div>
</body>
</html>
