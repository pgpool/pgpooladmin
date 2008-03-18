<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>{$message.strNodeInfo|escape}</title>
<link href="screen.css" rel="stylesheet" type="text/css" />
</head>
<body>
  <table>
    <tr>
      <th><label>{$message.strErrorCode|escape}</label></th>
      <td>{$errorCode|escape}</td>
    </tr>
    <tr>
      <th><label>{$message.strErrorMessage|escape}</label></th>
      <td>{$message.$errorCode|escape}</td>
    </tr>
    </td>
    </tr>
  </table>
</body>
</html>
