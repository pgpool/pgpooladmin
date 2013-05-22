<script type="text/javascript">
<!--
var refreshTime  = "{$refreshTime|escape}";
var refreshTimeLog  = "{$refreshTimeLog|escape}";
var view         = "{$viewPHP|escape}";
var msgStartPgpool   = "{$message.msgStartPgpool|escape}";
var msgStopPgpool    = "{$message.msgStopPgpool|escape}";
var msgReloadPgpool    = "{$message.msgReloadPgpool|escape}";
var msgRestartPgpool = "{$message.msgRestartPgpool|escape}";
var msgAddBackend    = "{$message.msgAddBackend|escape}";
var msgAddBackendNg  = "{$message.msgAddBackendNg|escape}";

{literal}

/* --------------------------------------------------------------------- */
/* page reloading                                                        */
/* --------------------------------------------------------------------- */

function load()
{
    var xmlhttp = false;
    if (typeof XMLHttpRequest!='undefined') {
        xmlhttp = new XMLHttpRequest();
    } else {
        xmlhttp = new ActiveXObject("MSXML2.XMLHTTP");
    }

    if (!xmlhttp) {
        alert('Sorry, cannot use XMLHttpRequest');
        return;
    }

    xmlhttp.onreadystatechange = function()
    {
        if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
            var content = document.getElementById('div_status');
            var ret = xmlhttp.responseText;
            if (content == null) { return; }

            content.innerHTML  = ret;
            if (view != "innerLog.php") {
                setTimeout("load()", refreshTimeLog);
            } else if (refreshTime > 0) {
                setTimeout("load()", refreshTime);
            }
        }
    }
    xmlhttp.open('GET', view, true);
    xmlhttp.setRequestHeader("If-Modified-Since", "Thu, 01 Jun 1970 00:00:00 GMT");
    xmlhttp.send("");
}

function sendCommand(command, nodeNumber, message)
{
    if (window.confirm(message)) {
        document.commandForm.action.value= command;
        document.commandForm.nodeNumber.value= nodeNumber;
        document.commandForm.submit();
    }
}

/* --------------------------------------------------------------------- */
/* When a button clicked                                                 */
/* --------------------------------------------------------------------- */

function _setVisible(id, visible)
{
    var button = document.getElementById(id);

    if (visible) {
        button.style.visibility = "visible";
        button.style.position   = "";
        button.style.height     = "";

    } else {
        button.style.visibility = "hidden";
        button.style.position   = "absolute";
        button.style.height     = "0";
    }
}

function stopPgpoolButtonHandler()
{
    _setVisible('stopPgpoolOptionDiv', true);
    _setVisible('commandButtonsDiv',   false);
    document.stopPgpoolForm.action.value = 'stopPgpool';
}

function restartPgpoolButtonHandler()
{
    _setVisible('stopPgpoolOptionDiv',    false);
    _setVisible('restartPgpoolOptionDiv', true);
    _setVisible('commandButtonsDiv',      false);
    document.restartPgpoolForm.action.value = 'restartPgpool';
}

function cancelPgpoolButtonHandler()
{
    _setVisible('stopPgpoolOptionDiv',    false);
    _setVisible('restartPgpoolOptionDiv', false);
    _setVisible('commandButtonsDiv',      true);
}

function execStartPgpool()   { execute('startPgpool',   msgStartPgpool,   null); }
function execStopPgpool()    { execute('stopPgpool',    msgStopPgpool,    null); }
function execReloadPgpool()  { execute('reloadPgpool',  msgReloadPgpool,  null); }
function execRestartPgpool() { execute('restartPgpool', msgRestartPgpool, null); }

/* --------------------------------------------------------------------- */
/* execute PostgreSQL's command                                          */
/* --------------------------------------------------------------------- */

function stopPgsqlButtonHandler(nodeNumber)
{
    _setVisible('stopPgsqlDiv', true);
    _setVisible('restartPgsqlDiv', false);
    document.stopPgsqlForm.action.value = 'stopPgsql';
    document.stopPgsqlForm.nodeNumber.value = nodeNumber;
}

function restartPgsqlHandler(nodeNumber)
{
    _setVisible('stopPgsqlDiv', false);
    _setVisible('restartPgsqlDiv', true);
    document.stopPgsqlForm.action.value = 'restartPgsql';
    document.restartPgsqlForm.nodeNumber.value = nodeNumber;
}

//function execStartPgsql()   { execute('startPgsql',   null); }
function execRestartPgsql() { execute('restartPgsql', msgRestartPgsql); }
function execStopPgsql()    { execute('stopPgsql',    msgStopPgsql); }
function execReloadPgsql(nodeNumber)  { execute('reloadPgsql', msgReloadPgsql, nodeNumber); }

/* --------------------------------------------------------------------- */
/* Add/remove backend node                                               */
/* --------------------------------------------------------------------- */

function addBackendButtonHandler()
{
    _setVisible('addBackendDiv', true);
}

function cancelButtonHandler(div_name)
{
    _setVisible(div_name, false);
}

function checkAddForm()
{
    // Check if not empty
    msg = "";
    if (document.getElementById('backend_hostname').value == '') {
        msg += "- backend_hostname\n";
    }

    port = document.getElementById('backend_port').value;
    if (port == '' || !isInteger(port)) {
        msg += "- backend_port\n";
    }

    weight = document.getElementById('backend_weight').value;
    if (weight == '' || !isFloat(weight)) {
        msg += "- backend_weight\n";
    }
    if (msg != "") {
        alert(msgAddBackendNg + "\n" + msg);
        return false;
    }

    return confirm(msgAddBackend);
}

function isInteger(num) { return num.match(/^[0-9]+$/); }
function isFloat(num) { return num.match(/^[0-9]+\.?[0-9]?$/); }

function execRemoveBackend(node_num)
{
    execute('removeBackend', msgRemoveBackend, node_num);
}

/* --------------------------------------------------------------------- */
/* execute pgpool's commands                                             */
/* --------------------------------------------------------------------- */

function execute(action, confirm_text, node_num)
{
    elements = document.getElementsByName(action + 'Form');
    if (elements.length != 1) {
        elements = document.getElementsByName('commandForm');
        if (elements.length != 1) {
            alerr('Unknown error');
            return;
        }
    }
    target_form = elements[0];

    if (confirm_text == null || window.confirm(confirm_text)) {
        target_form.action.value = action;
        if (node_num != null) {
            target_form.nodeNumber.value = node_num;
        }
        target_form.submit();
    }
}

function changeView(chView)  { execute(chView, null, null); }

// -->
</script>
{/literal}
