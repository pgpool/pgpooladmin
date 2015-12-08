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

function reload()
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

function timer(interval)
{
    setTimeout("reload()",interval);
}

function sendCommand(command, nodeNumber, message)
{
    if (window.confirm(message)) {
        document.Command.action.value= command;
        document.Command.nodeNumber.value= nodeNumber;
        document.Command.submit();
    }
}
