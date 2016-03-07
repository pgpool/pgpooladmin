<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>{$message.strSetting|escape}</title>
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
  <h2>{$message.strHelp|escape}({$message.strSetting|escape})</h2>
  <h3>{$message.strSummary|escape}</h3>
  pgpool管理ツールの設定を表示・変更することができます。
  <h3>{$message.strFeature|escape}</h3>
    <table>
      <tbody>
        <tr>
          <th><label>{$message.strLanguage|escape}</label>
            (string)</th>
          <td class="input">表示したい言語を選択します。「auto」を選択した場合には、ブラウザで設定した言語が優先的に表示されます。</td>
        </tr>
        <tr>
          <th><label>{$message.strPgConfFile|escape}</label>
            (string)</th>
          <td>pgpool.confへのパスをフルパスで指定します。</td></tr>
        <tr>
          <th><label>{$message.strPasswordFile|escape}</label>
            (string)</th>
          <td>pcp.confへのパスをフルパスで指定します。</td></tr>
        <tr>
          <th><label>{$message.strPgpoolCommand|escape}</label>
            (string)</th>
          <td>pgpoolへのパスをフルパスで指定します。</td></tr>
        <tr>
          <th colspan="2"><label>{$message.strPgpoolCommandOption|escape}</label>
            (string)</th></tr>
          <tr><td>{$message.strCmdC|escape}(-c)</td>
          <td>起動時にクエリキャッシュをクリアします。</td>
          </tr>
          <tr><td>{$message.strCmdN|escape}(-n)</td>
          <td>非デーモンモードでpgpoolを起動します。pgpoolのログを管理ツールで表示するには、この項目をオンにする必要があります。</td>
          </tr>
          <tr><td>{$message.strCmdD|escape}(-d)</td>
          <td>デバッグモードで起動します。デバッグログが必要な場合にはオンにします。</td>
          </tr>
          <tr><td>{$message.strCmdM|escape}(-m)</td>
          <td>pgpoolのすべてのプロセスを終了します。pgpool停止ボタンを押すと、終了オプションが表示されます。停止モードとして
          <ul>
          <li>smart</li>
          <li>fast</li>
          <li>immediate</li>
          </ul>
          を選択することができます。終了すると、pgpoolステータスが「pgpool停止」となり、起動用画面が表示されます。</td>
          </tr>
          <tr><td>{$message.strCmdPgpoolFile|escape}(-f)</td>
          <td>pgpoolの起動時に指定するpgpool.confです。pgpool.confのパスは「{$message.strPgConfFile|escape}」で指定した値になります。</td>
          </tr>
          <tr><td>{$message.strCmdPcpFile|escape}(-F)</td>
          <td>pgpoolの起動時に指定するpcp.confです。pcp.confのパスは「{$message.strPasswordFile|escape}」で指定した値になります。</td>
          </tr>
        <tr>
          <th><label>{$message.strPgpoolLogFile|escape}</label>
            (string)</th>
          <td>非デーモンモードで起動した場合に使用するログファイルかパイプ先を指定します。ログファイルを指定する場合はフルパスで記述します。パイプ先を指定する場合はバー（"|"）から記述してください。空欄の場合に非デーモンモードで起動した場合はpgpool.confのlogdirで指定してあるパスにpgpool.logというファイル名でログを作成します。</td></tr>
        <tr>
          <th><label>{$message.strPcpDir|escape}</label>
            (string)</th>
          <td>PCPコマンドがインストールしてあるディレクトリを指定します。</td></tr>
        <tr>
          <th><label>{$message.strPcpDir|escape}</label>
            (string)</th>
          <td>PCPコマンドがインストールしてあるディレクトリを指定します。</td></tr>
        <tr>
          <th><label>{$message.strPcpHostName|escape}</label>
            (string)</th>
          <td>PCPコマンドを実行するホスト名を指定します。通常は「localhost」になります。</td>
        </tr>
        <tr>
          <th><label>{$message.strPcpRefreshTime|escape}</label>
            (integer)
            </td>
          <td>ステータスの更新間隔を秒単位で指定します。0を指定した場合には自動更新しません。
        </td></tr>
      </tbody>
    </table>
  <p>最後に更新ボタンを押して更新します。</p>
</div>
<div id="footer">
{include file='footer.tpl'}
</div>
</body>
</html>
