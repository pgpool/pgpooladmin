<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>{$message.strPgConfSetting|escape}</title>
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
<div id="help"><a href="{$help}.php"><img src="images/back.gif" />{$message.strBack}</a></div>

<h2>{$message.strHelp|escape}({$message.strPgConfSetting|escape})</h2>

<div id="submenu">
    <h3>Table of Contents</h3>
    <ul>
      <li><a href="#connections">Connections</a></li>
      <li><a href="#pools">Pools</a></li>
      <li><a href="#backends">Backends</a></li>
      <li><a href="#logs">Logs</a></li>
      <li><a href="#file_locations">File Locations</a></li>
      <li><a href="#connection_pooling">Connection Pooling</a></li>
      <li><a href="#replication">Replication</a></li>
      <li><a href="#load_balancing_mode">Load Balancing Mode</a></li>
      <li><a href="#master_slave_mode">Master/Slave Mode</a></li>
      <li><a href="#parallel_mode">Parallel Mode and Query Cache</a></li>
      <li><a href="#health-check">Health Check</a></li>
      <li><a href="#failover">Failover and Failback</a></li>
      <li><a href="#online-recovery">Online Recovery</a></li>
      <li><a href="#memqcache">On Memory Query Cache</a></li>
      <li><a href="#others">Others</a></li>
    </ul>
</div>

<h3>{$message.strSummary|escape}</h3>
<p>pgpoolの設定ファイルであるpgpool.confの設定内容を表示・変更することができます</p>

<h3>{$message.strFeature|escape}</h3>
<p>変更したい値を入力して更新ボタンを押してください。</p>
<p>
更新した設定を反映させるには、設定のリロードが必要です。
また、[*]が付いている項目は、設定を反映させるために pgpool の再起動が必要となります。
</p>
　
<h4>バックエンドホストの追加</h4>
<p>新しいバックエンドホストを追加したい場合には、追加ボタンを押してください。</p>
<p>
バックエンドホストの項目に新しい入力欄ができますので、
そこに新しいバックエンドホストの情報を入力してください。
入力が終わりましたら、更新ボタンを押してください。
</p>

<h4>バックエンドホストの削除</h4>
<p>登録してあるバックエンドホストを削除したい場合には、そのホスト設定の右側にある
削除ボタンを押してください。</p>


<h3><a name="connections">Connections</a></h3>

<table>
  <thead>
    <tr>
      <th width="240">{$message.strParameter|escape}</th>
      <th>{$message.strDetail|escape}</th>
    </tr>
  </thead>
  <tbody>
    <tr><th class="category" colspan="2">pgpool Connection Settings</th></tr>

    <tr>
      <th id="LISTEN_ADDRESSES"><label>{$message.descListen_addresses|escape}</label>
      <p>listen_addresses (string) *</th>
      <td>
      <p>
      pgpool-II が TCP/IP コネクションを受け付けるアドレスをホスト名またはIPアドレスで指定します。
      「*」を指定するとすべての IP インタフェースからのコネクションを受け付けます。
      「''」を指定すると TCP/IP コネクションを受け付けません。
      </p>
      <p>デフォルト値は「localhost」です。
      UNIX ドメインソケット経由のコネクションは常に受け付けます。
      </p>
      </td>
    </tr>

    <tr>
      <th id="PORT"><label>{$message.descPort|escape}</label>
      <p>port (integer) *</th>
      <td>
      <p>
      pgpool-IIがコネクションを受け付けるポート番号です。
      </p>
      <p>
      デフォルト値は 9999 です。
      </p>
      </td>
    </tr>

    <tr>
      <th id="SOCKET_DIR"><label>{$message.descSocket_dir|escape}</label>
      <p>socket_dir (string) *</th>
      <td>
      <p>
      pgpool-IIがコネクションを受け付けるUNIXドメインソケットを置くディレクトリです。
      このソケットは、cronによって削除されることがあるので注意してください。
      <code>'/var/run'</code>などのディレクトリに変更することをお勧めします。
      </p>
      <p>
      デフォルト値は'/tmp'です。
      </p>
      </td>
    </tr>

    <tr><th class="category" colspan="2">pgpool Communication Manager Connection Settings</th></tr>

    <tr>
      <th id="PCP_PORT"><label>{$message.descPcp_port|escape}</label>
      <p>pcp_port (integer) *</th>
      <td>
      <p>
      pcpが使用するポート番号です。
      </p>
      </td>
    </tr>

    <tr>
      <th id="PCP_SOCKET_DIR"><label>{$message.descPcp_socket_dir|escape}</label>
      <p>pcp_socket_dir (string) *</th>
      <td>
      <p>
      pcpがコネクションを受け付けるUNIXドメインソケットを置くディレクトリです。
      デフォルト値は'/tmp'です。
      このソケットは、cronによって削除されることがあるので注意してください。
      <code>'/var/run'</code>などのディレクトリに変更することをお勧めします。
      </p>
      </td>
    </tr>

    <tr><th class="category" colspan="2">Authentication</th></tr>
    <tr>
      <th id="ENABLE_POOL_HBA"><label>{$message.descEnable_pool_hba|escape}</label>
      <p>enable_pool_hba</th>
      <td>
      <p>true ならば、pool_hba.conf に従ってクライアント認証を行います。</p>
      <p>デフォルト値は false です。</p>
      </td>
    </tr>

    <tr>
      <th id="AUTHENTICATION_TIMEOUT"><label>{$message.descAuthentication_timeout|escape}</label>
      <p>authentication_timeout (integer)</th>
      <td>
        <p>
        認証処理のタイムアウト時間を秒単位で指定します。0 を指定するとタイムアウトを無効にします。
        authentication_timeout のデフォルト値は 60 です。
        </p>
      </td>
    </tr>

    <tr><th class="category" colspan="2">SSL Connections</th></tr>

    <tr>
      <th id="SSL"><label>{$message.descSsl|escape}</label>
      <p>ssl (bool) *</th>
      <td>
        <p>
        true ならば pgpool-II とフロントエンド、pgpool-II とバックエンドの間の SSL 接続が可能になります。
        なお、pgpool-II とフロントエンドの接続に SSL が利用できるためには、
        <code>ssl_key</code> と <code>ssl_cert</code> が設定されてなければなりません。
        </p>
        <p>
        デフォルトでは SSL サポートはオフになっています。
        </p>
      </td>
    </tr>

    <tr>
      <th><label>{$message.descSsl_key|escape}</label>
      <p id="SSL_KEY">ssl_key (string)</th>
      <td>
        <p>
        フロントエンドとの接続に使用するプライベートキーファイルのフルパスを指定します。
        </p>
        <p>
        ssl_key のデフォルト値はありません。
        ssl_key の設定がない場合は、フロントエンドとの接続で SSL が使用されなくなります。
        </p>
      </td>
    </tr>

    <tr>
      <th><label>{$message.descSsl_cert|escape}</label>
      <p id="SSL_CERT">ssl_cert (string)</th>
      <td>
        <p>
        フロントエンドとの接続に使用する公開x509証明書のフルパスを指定します。
        </p>
        <p>
        ssl_cert のデフォルト値はありません。
        ssl_cert の設定がない場合は、フロントエンドとの接続で SSL が使用されなくなります。
        </p>
      </td>
    </tr>

    <tr>
      <th id="SSL_CA_CERT"><label>{$message.descSsl_ca_cert|escape}</label>
      <p>ssl_ca_cert (string)</th>
      <td>
      </td>
    </tr>

    <tr>
      <th id="SSL_CA_CERT_DIR"><label>{$message.descSsl_ca_cert_dir|escape}</label>
      <p>ssl_ca_cert_dir (string)</th>
      <td>
      </td>
    </tr>

  </tbody>
  <tfoot>
    <tr>
      <td colspan="2"></td>
    </tr>
  </tfoot>
</table>


<h3><a name="pools">Pools</a></h3>
<table>
  <thead>
    <tr>
      <th width="240">{$message.strParameter|escape}</th>
      <th>{$message.strDetail|escape}</th>
    </tr>
  </thead>
  <tbody>
    <tr><th class="category" colspan="2">Pool size</th></tr>

    <tr>
      <th id="NUM_INIT_CHILDREN"><label>{$message.descNum_init_children|escape}</label>
      <p>num_init_children (integer) *</th>
      <td>
        <p>
        prefork する pgpool-II のサーバプロセスの数です。デフォルト値は 32 になっています。
        これが、pgpool-II に対してクライアントが同時に接続できる上限の数になります。
        これを超えた場合は、そのクライアントは、pgpool-II のどれからのプロセスへのフロントエンドの接続が終了するまで
        待たされます（PostgreSQL と違ってエラーになりません）。
        待たされる数の上限は、2 * num_init_children です。
        </p>
        <p>
        基本的に後述の max_pool * num_init_children 分だけ PostgreSQL へのコネクションが張られますが、
        他に以下の考慮が必要です。
        </p>
        <ul>
            <li>問い合わせのキャンセルを行うと通常のコネクションとは別に新たなコネクションが張られます。
                したがって、すべてのコネクションが使用中の場合は問い合わせのキャンセルができなくなってしまうので、
                ご注意下さい。
                問い合わせのキャンセルを必ず保証したい場合は、想定されるコネクション数の倍の値を
                設定することをおすすめします。
            </li>
            <li>一般ユーザで PostgreSQL に接続できるのは、
                max_connections - superuser_reserved_connections 分だけです。
            </li>
        </ul>
        <p>
        以上をまとめると、
        </p>

        <table>
        <tr><th>クエリのキャンセルを考慮しない場合</th>
            <td>max_pool * num_init_children &lt;=<br>
                (max_connections - superuser_reserved_connections)</td></tr>
        <tr><th>クエリのキャンセルを考慮する場合</th>
            <td>max_pool * num_init_children * 2 &lt;=<br>
                (max_connections - superuser_reserved_connections)</td></tr>
        </table>

        <p>
        のどちらかを満たすように設定してください。
        </p>
      </td>
    </tr>

    <tr>
      <th id="MAX_POOL"><label>{$message.descMax_pool|escape}</label>
      <p>max_pool (integer) *</th>
      <td>
        <p>
        pgpool-II の各サーバプロセスがキープする PostgreSQL への最大コネクション数です。
        pgpool-II は、ユーザ名、データベースが同じならばコネクションを再利用しますが、
        そうでなければ新たに PostgreSQL へのコネクションを確立しようとします。
        したがって、ここでは想定される [ユーザ名:データベース名] のペアの種類の数だけを
        max_pool に指定しておく必要があります。
        もし max_pool を使いきってしまった場合は一番古いコネクションを切断し、
        そのスロットが再利用されます。
        </p>
        <p>
        max_poolのデフォルト値は4です。
        </p>
        <p>
        なお、pgpool-II全体としては、<a href="#NUM_INIT_CHILDREN">num_init_children</a> *
        <a href="#MAX_POOL">max_pool</a> 分だけ
        PostgreSQL へのコネクションが張られる点に注意してください。
        </p>
      </td>
    </tr>

    <tr><th class="category" colspan="2">Life time</th></tr>

    <tr>
      <th id="CHILD_LIFE_TIME"><label>{$message.descChild_life_time|escape}</label>
      <p>child_life_time (integer)</th>
      <td>
        <p>
        pgpool-IIの子プロセスの寿命です。アイドル状態になってから
        child_life_time秒経過すると、一旦終了して新しいプロセスを起動します。
        メモリーリークその他の障害に備えた予防措置です。
        child_life_timeのデフォルト値は300秒、すなわち5分です。
        0を指定するとこの機能は働きません（すなわち起動しっ放し）。
        なお、まだ一度もコネクションを受け付けていないプロセスにはchild_life_timeは適用されません。
        </p>
      </td>
    </tr>

    <tr>
      <th id="CHILD_MAX_CONNECTIONS"><label>{$message.descChild_max_connections|escape}</label>
      <p>child_max_connections (integer)</th>
      <td>
        <p>
        各pgpool-II子プロセスへの接続回数がこの設定値を超えると、その子プロセスを終了します。
        <a href="#CHILD_LIFE_TIME">child_life_time</a> や <a href="#CONNECTION_LIFE_TIME">connection_life_time</a>が
        効かないくらい忙しいサーバで、
        PostgreSQL バックエンドが肥大化するのを防ぐのに有効です。
        </p>
      </td>
    </tr>

    <tr>
      <th id="CONNECTION_LIFE_TIME"><label>{$message.descConnection_life_time|escape}</label>
      <p>connection_life_time (integer)</th>
      <td>
        <p>
        コネクションプール中のコネクションの有効期間を秒単位で指定します。
        0 を指定すると有効期間は無限になります。
        connection_life_timeのデフォルト値は0です。
        </p>
      </td>
    </tr>

    <tr>
      <th id="CLIENT_IDLE_LIMIT"><label>{$message.descClient_idle_limit|escape}</label>
      <p>client_idle_limit (integer)</th>
      <td>
        <p>
        前回クライアントから来たクエリから、client_idle_limit 秒越えても次の
        クエリが届かない場合は、クライアントへの接続を強制的に切断し、
        クライアントからの次のコネクションを待つようにします。
        この設定は、だらしないクライアントプログラムや、クライアントと pgpool の間の
        TCP/IP コネクションが不調なことによって、
        pgpool の子プロセスが占有されてしまう問題を回避するのに役立ちます。
        デフォルト値は 0(無効)です。
        このパラメータは、オンラインリカバリのセカンドステージでは無視されます。
        </p>
        <p>
        このパラメータを変更した時には設定ファイルを再読み込みしてください。
        </p>
      </td>
    </tr>
  </tbody>
  <tfoot>
    <tr>
      <td colspan="2"></td>
    </tr>
  </tfoot>
</table>


<h3><a name="backends">Backends</a></h3>
<table>
  <thead>
    <tr>
      <th width="240">{$message.strParameter|escape}</th>
      <th>{$message.strDetail|escape}</th>
      <td></td>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th id="BACKEND_SOCKET_DIR"><label>{$message.descBackend_socket_dir|escape}</label>
      <p>backend_socket_dir (string) *</th>
      <td>PostgreSQL サーバの Unix domain socket のディレクトリです。</p>
       <p>デフォルト値は'/tmp'です。</td>
    </tr>

    <tr>
      <th id="BACKEND_HOSTNAME"><label>{$message.descBackend_hostname|escape}</label>
      <p>backend_hostname (string)</th>
      <td>
        <p>
        使用する PostgreSQL サーバのホスト名を指定します。
        pgpool-II は、このホスト名を使って PostgreSQL と通信します。
        </p>
        <p>
        TCP/IP を使用する場合、ホスト名または IP アドレスを指定できます。
        "/" で始まる文字列を指定すると、TCP/IP ではなく、UNIX ドメインソケットを使用され、
        ディレクトリ名とみなしてそこにソケットファイルが作成されることになります。
        空文字（<code>''</code>）を指定すると、<code>/tmp</code> 下に作成した UNIX ドメインソケットで接続します。
        </p>
        <p>
        実際には、"backend_hostname" の後に 0, 1, 2...と数字を付加して使用する複数
        の PostgreSQL を区別します（たとえば<code>backend_hostname0</code>）。
        この数字のことを「DBノードID」と呼び、0から開始します。
        DB ノード ID == 0 の PostgreSQL は、特別に「マスターDB」と呼ばれます。
        複数の DB ノードを運用している場合、条件によってはマスター DB がダウンしても運用を続けることができます。
        この場合は、稼働中かつ DB ノード ID がもっとも若いものが新しいマスター DB になります。
        </p>
        <p>
        ただし、ストリーミングレプリケーションモードで運用している場合は、
        DB ノード ID が 0 のノードには特別な意味はなく、プライマリノードかどうかが問題になります。
        <p>
        1 台しか PostgreSQL を使用しない場合は、"backend_hostname0" としてください。
        </p>
      </td>
    </tr>

    <tr>
      <th id="BACKEND_PORT"><label>{$message.descBackend_port|escape}</label>
      <p>backend_port (integer)</th>
      <td>
        <p>
        使用する PostgreSQL サーバのポート番号を指定します。
        実際には、"backend_port" の後に 0, 1, 2... と DB ノード ID を付加して使用する
        複数の PostgreSQL を区別します。
        </p>
        <p>
        1 台しか PostgreSQL を使用しない場合は、"backend_port0" としてください。
        </p>
      </td>
    </tr>

    <tr>
      <th id="BACKEND_WEIGHT"><label>{$message.descBackend_weight|escape}</label>
      <p>backend_weight (integer)</th>
      <td>
        <p>
        使用する PostgreSQL サーバに対する負荷分散の比率を0以上の整数または浮動小数点で指定します。
        "backend_weight" の後には、DB ノード ID を付加して使用する複数の PostgreSQL を区別します。
        1 台しか PostgreSQL を使用しない場合は、"backend_weight0" としてください。
        負荷分散を使用しない場合は、「1」を設定してください。
        </p>
        <p>
        backend_weight は新しく追加した行を設定ファイル再読み込みで追加することができます。
        pgpool-II 2.2.6 / 2.3 以降では、設定ファイルの再読込で backend_weight 値を変更できます。
        新しく接続したクライアントセッションから、この新しい weight 値が反映されます。
        マスタースレーブモードにおいて、あるスレーブに対して管理業務を実施する都合上、
        問い合わせがそのスレーブに送られるのを防ぎたい場合に有用です。
        </p>
      </td>
    </tr>

    <tr>
      <th id="BACKEND_DATA_DIRECTORY"><label>{$message.descBackend_data_directory|escape}</label>
      <p>backend_data_directory (string) *</th>
      <td>
        <p>
        使用する PostgreSQL サーバのデータベースクラスタのパスを指定します。
        実際には、"backend_data_directory" の後に DB ノード ID を付加して
        使用する複数の PostgreSQL を区別します。
        このパラメータはオンラインリカバリの際に使用します。
        </p>
        <p>
        オンラインリカバリを使用しない場合には設定する必要はありません。
        </p>
      </td>
    </tr>

    <tr>
      <th id="BACKEND_FLAG"><label>{$message.descBackend_flag|escape}</label>
      <p>backend_flag (string) *</th>
      <td>
        <p>
        バックエンド単位での様々な挙動を制御するフラグです。
        実際には、"backend_flag" の後に数字を付けて、どのバックエンドのフラグか指定します。
        </p>
        <p>
        例: <code>backend_flag0</code>
        </p>
        <p>
        複数のフラグを "|" で連結して指定することができます。
        現在以下のものがあります。
        </p>

        <table>
        <tr><th class="nodec">ALLOW_TO_FAILOVER</th>
        <td>フェイルオーバやデタッチが可能になります。これがデフォルトの動作です。
            DISALLOW_TO_FAILOVER と同時には指定できません。
        </td></tr>
        <tr><th class="nodec">DISALLOW_TO_FAILOVER</th>
        <td>フェイルオーバやデタッチが行われません。
            Heartbeat や Pacemaker などのHA（High Availability）ソフトでバックエンドを二重化しているなどの事情で、
            pgpool-II 側でフェイルオーバの制御をして欲しくないときなどに指定します。
            ALLOW_TO_FAILOVER と同時には指定できません。
        </td></tr>
        </table>
      </td>
    </tr>

  </tbody>
  <tfoot>
    <tr>
      <td colspan="2"></td>
    </tr>
  </tfoot>
</table>


<h3><a name="logs">Logs</a></h3>
<table>
  <thead>
    <tr>
      <th width="240">{$message.strParameter|escape}</th>
      <th>{$message.strDetail|escape}</th>
    </tr>
  </thead>
  <tbody>
    <tr><th class="category" colspan="2">Where to log</th></tr>

    <tr>
      <th id="LOG_DESTINATION"><label>{$message.descLog_destination|escape}</label>
      <p>log_destination (string) *</th>
      <td>
        <p>
        pgpool-IIは、stderr か syslog のどちらかにログを書くことができます。デフォルトは stderr です。
        </p>
        <p>
        注意: syslog を使う場合は、syslog デーモンの設定を変更する必要があります。
        </p>
        <p>
        pgpool-II は、syslog ファシリティ LOCAL0 から LOCAL7 までにログを書くことができます
        （syslog_facilityをご覧ください）。
        しかし、ほとんどのデフォルトの syslog 設定は、そのようなメッセージを廃棄してしまいます。
        そこで、syslog デーモンの以下のような設定が必要になります。
        </p>
        <pre>
local0.*    /var/log/pgpool.log
        </pre>
      </td>
    </tr>

    <tr><th class="category" colspan="2">What to log</th></tr>

    <tr>
      <th id="PRINT_TIMESTAMP"><label>{$message.descPrint_timestamp|escape}</label>
      <p>print_timestamp (string) *</th>
      <td>
      <p>true ならば pgpool-II のログにタイムスタンプを追加します。デフォルトは true です。</p>
      <p>デフォルトは true です。</p></td>
    </tr>

    <tr>
      <th id="LOG_CONNECTIONS"><label>{$message.descLog_connections|escape}</label>
      <p>log_connections (bool)</th>
      <td>true ならば、全てのクライアント接続をログへ出力します。</td>
    </tr>

    <tr>
      <th id="LOG_HOSTNAME"><label>{$message.descLog_hostname|escape}</label>
      <p>log_hostname (bool)</th>
      <td>
        <p>
        true ならば、ps コマンドでの状態表示時にIPアドレスではなく、ホスト名を表示します。
        また、<a href="#LOG_CONNECTIONS">log_connections</a> が有効な場合にはログにホスト名を出力します。
        </p>
      </td>
    </tr>

    <tr>
      <th id="LOG_STATEMENT"><label>{$message.descLog_statement|escape}</label>
      <p>log_statement (bool)</th>
      <td>
        <p>
        true ならば SQL 文をログ出力します。この役目は PostgreSQL の log_statement オプションと似ていて、
        デバッグオプションがないときでも 問い合わせをログ出力して調べることができるので便利です。
        </p>
      </td>
    </tr>

    <tr>
      <th id~"LOG_PER_NODE_STATEMENT"><label>{$message.descLog_per_node_statement|escape}</label>
      <p>log_per_node_statement (bool)</th>
      <td>
      <p>
      <a href="#LOG_STATEMENT">log_statement</a>と似ていますが、DBノード単位でログが出力されるので、
      レプリケーションや負荷分散の確認が容易です</td>
      </p>
      </td>
    </tr>

    <tr>
      <th id="LOG_STANDBY_DELAY"><label>{$message.descLog_standby_delay|escape}</label>
      <p>log_standby_delay (string)</th>
      <td>
        <p>
        レプリケーションの遅延状況をログする条件を指定します。
        'none' を指定すると、ログを出力しません。
        'always' ならヘルスチェックを実行するたびに必ず出力します。
        'if_over_threshold' を指定すると、<a href="#DELAY_THRESHOLD">delay_threshold</a>を超えたときだけ
        ログが出力されます。
        </p>
        <p>
        デフォルト値は'none'です。
        </p>
      </td>
    </tr>

    <tr><th class="category" colspan="2">Syslog specific</th></tr>

    <tr>
      <th><label>{$message.descSyslog_facility|escape}</label>
      <p id="SYSLOG_FACILITY">syslog_facility (string) *</th>
      <td>
        <p>
        syslog が有効な場合、このパラメータによって syslog の「ファシリティ」を設定します。
        LOCAL0, LOCAL1, LOCAL2, LOCAL3, LOCAL4, LOCAL5, LOCAL6, LOCAL7から選択します。
        デフォルトは LOCAL0 です。
        併せて syslog デーモンのドキュメントもご覧ください。
        </p>
      </td>
    </tr>

    <tr>
      <th id="SYSLOG_IDENT"><label>{$message.descSyslog_ident|escape}</label>
      <p>syslog_ident (string) *</th>
      <td>
        <p>
        syslog が有効な場合、このパラメータによって syslog のメッセージにあらわれるプログラム名を設定します。
        デフォルトは "pgpool" です。
        </p>
      </td>
    </tr>

    <tr><th class="category" colspan="2">Debug</th></tr>

    <tr>
      <th id="DEBUG_LEVEL"><label>{$message.descDebug_level|escape}</label>
      <p>debug_level (integer)</th>
      <td>
        <p>
        デバッグメッセージの詳細レベル。0 でデバッグメッセージの出力なし。
        1 以上でデバッグメッセージを出力します。
        数字が大きければより詳細なメッセージが出力されるようになります
        （3.0 では今のところメッセージの詳細度は変りません）。
        </p>
        <p>
        デフォルト値は0です。
        </p>
      </td>
    </tr>

  </tbody>
  <tfoot>
    <tr>
      <td colspan="2"></td>
    </tr>
  </tfoot>
</table>


<h3><a name="file_locations">File Locations</a></h3>

<table>
  <thead>
    <tr>
      <th width="240">{$message.strParameter|escape}</th>
      <th>{$message.strDetail|escape}</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th id="LOGDIR"><label>{$message.descLogdir|escape}</label>
      <p>logdir (string) *</th>
      <td>
      <p>このディレクトリ下に、pgpool-II の DB ノードの状態を記録する pgpool_status ファイルが書かれます。</p>
      <p>デフォルト値は '/tmp' です。</p></td>
    </tr>

    <tr>
      <th id="PID_FILE_NAME"><label>{$message.descPid_file_name|escape}</label>
      <p>pid_file_name (string) *</th>
      <td>
      <p>pgpool-II の pid file（プロセス IDを 格納したファイル）のフルパス名です。</p>
      <p>デフォルト値は'/var/run/pgpool/pgpool.pid'です。</p></td>
    </tr>

  </tbody>
  <tfoot>
    <tr>
      <td colspan="2"></td>
    </tr>
  </tfoot>
</table>


<h3><a name="connection_pooling">Connection Pooling</a></h3>
<table>
  <thead>
    <tr>
      <th width="240">{$message.strParameter|escape}</th>
      <th>{$message.strDetail|escape}</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th id="CONNECTION_CACHE"><label>{$message.descConnection_cache|escape}</label>
      <p>connection_cache (bool) *</th>
      <td>true なら PostgreSQL へのコネクションをキャッシュします。</td>
    </tr>

    <tr>
      <th id="RESET_QUERY_LIST"><label>{$message.descReset_query_list|escape}</label>
      <p>reset_query_list (string)</th>
      <td>
        <p>
        セッションが終了するときにコネクションを初期化するための SQL コマンドを「;」で区切って列挙します。
        デフォルトは以下のようになっていますが、任意の SQL 文を追加しても構いません。
<pre>
reset_query_list = 'ABORT; DISCARD ALL'
</pre>

        <p>
        PostgreSQL のバージョンによって使用できる SQL コマンドが違います。
        各バージョンごとのお勧め設定は以下です（ただし、"ABORT" は必ずコマンドに含めてください）。
        </p>

        <table>
        <tr class="header"><th>PostgreSQL バージョン</th><th>reset_query_list の推奨設定値</th></tr>
        <tr><th>7.1 以前</th><td>ABORT</td></tr>
        <tr><th>7.2 から 8.2</th><td>ABORT; RESET ALL; SET SESSION AUTHORIZATION DEFAULT</td></tr>
        <tr><th>8.3 以降</th><td>ABORT; DISCARD ALL</td></tr>
        </table>

        <p>
        ※ 「ABORT」は、PostgreSQL 7.4 以上ではトランザクションブロックの中にいない場合には発行されません。
        </p>
      </td>
    </tr>

  </tbody>
  <tfoot>
    <tr>
      <td colspan="2"></td>
    </tr>
  </tfoot>
</table>


<h3><a name="replication">Replication</a></h3>
<table>
  <thead>
    <tr>
      <th width="240">{$message.strParameter|escape}</th>
      <th>{$message.strDetail|escape}</th>
    </tr>
  </thead>
  <tbody>

    <tr>
      <th id="REPLICATE_MODE"><label>{$message.descReplication_mode|escape}</label>
      <p>replication_mode (bool) *</th>
      <td>レプリケーションモードで動作させる場合は true を指定してください。</p>
      <p>デフォルト値は false です。</p></td>
    </tr>

    <tr>
      <th id="REPLICATE_SELECT"><label>{$message.descReplicate_select|escape}</label>
      <p>replicate_select (bool)</th>
      <td>
        <p>
        true を設定すると、レプリケーションモードでは SELECT 文をレプリケーションします。
        これは pgpool-II 1.0 までの挙動と同じになります。
        false を設定すると SELECT 文をマスタのみに送信します。デフォルト値は false です。
        </p>
        <p>
        replicate_select、<a href="#LOAD_BALANCE_MODE">load_balance_mode</a>、
        SELECT 問合わせが明示的なトランザクションブロックの内側にあるかどうかどうかで、
        レプリケーションモードの動作が変化します。詳細を表に示します。
        </p>

        <table>
        <tr>
        <th class="nodec">SELECT が明示的なトランザクションブロックの内側にある</th>
        <td>Y</td><td>Y</td><td>Y</td><td>N</td><td>N</td><td>N</td><td>Y</td><td>N</td>
        </tr>

        <tr>
        <th class="nodec">replicate_select が true</th>
        <td>Y</td><td>Y</td><td>N</td><td>N</td><td>Y</td><td>Y</td><td>N</td><td>N</td>
        </tr>

        <tr>
        <th class="nodec">load_balance_mode が true</th>
        <td>Y</td><td>N</td><td>N</td><td>N</td><td>Y</td><td>N</td><td>Y</td><td>Y</td>
        </tr>

        <tr>
        <th class="nodec">結果（R:レプリケーション, M: マスタのみに送信, L: ロードバランスされる）</th>
        <td>R</td><td>R</td><td>M</td><td>M</td><td>R</td><td>R</td><td>M</td><td>L</td>
        </tr>
        </table>
      </td>
    </tr>

    <tr>
      <th><label>{$message.descInsert_lock|escape}</label>
      <p>insert_lock (bool)</th>
      <td>
        <p>
        SERIAL 型を使っているテーブルをレプリケーションすると、SERIAL 型の列の値が DB ノードの間で
        一致しなくなることがあります。
        この問題は、該当テーブルを明示的にロックすることで回避できます
        （もちろんトランザクションの並列実行性は犠牲になりますが）。
        しかし、そのためには、
        </p>
<pre>
INSERT INTO ...
</pre>

        <p>
        を
        </p>

<pre>
BEGIN;
LOCK TABLE ...
INSERT INTO ...
COMMIT;
</pre>

        <p>
        に書き換えなければなりません。
        insert_lock を true にすると自動的にトランザクションの開始、テーブルロック、トランザクションの終了を
        行ってくれるので、こうした手間を省くことができます
        （すでにトランザクションが開始されている場合は LOCK TABLE...だけが実行されます）。
        </p>
        <p>
        そのほか注意事項などは pgpool-II のマニュアルに詳細があります。
        </p>
        <p>
        insert_lock のデフォルト値は true です。
        </p>
      </td>
    </tr>

    <tr>
      <th id="LOBJ_LOCK_TABLE"><label>{$message.descLobj_lock_table|escape}</label>
      <p>lobj_lock_table (string)</th>
      <td>
        <p>
        ラージオブジェクトのレプリケーションを行いたいときにロック管理に使うためのテーブル名を指定します。
        これを使用することによって、すべての DB ノードで同じIDを持つラージオブジェクトが作成されることが
        保証されます。
        </p>
        <p>
        lobj_lock_table に指定するテーブル名が空文字の場合は、ラージオブジェクトに関する上記の処理は行いません
        （したがって、ラージオブジェクトのレプリケーションは保証されません）。
        lobj_lock_table のデフォルト値は空文字です。
        </p>
        <p>
        pgpool-II のマニュアルに、より詳細な説明があります。
        </p>
      </td>
    </tr>

   <tr><th class="category" colspan="2">Degenerate handling</th></tr>

    <tr>
      <th id="REPLICATION_STOP_ON_MISMATCH"><label>{$message.descReplication_stop_on_mismatch|escape}</label>
      <p>replication_stop_on_mismatch (bool)</th>
      <td>
        <p>
        各 DB ノードから送られてくるパケットの種類が不一致になった場合に、DB ノードを切り放して縮退運転に入ります。
        </p>
        <p>
        良くあるケースとしては、<a href="#REPLICATE_SELECT">replicate_select</a> が指定されていて
        SELECT が各 DB ノードで実行されているときに、
        検索結果行数が一致しないなど、があります（これに限定されるものではありません。
        たとえばある DB ノードで UPDATE が成功したのに、他の DB ノードでは失敗した場合が一例です）。
        ただし、pgpool はパケットの中身まではチェックしていないので、SELECT 結果のデータ内容が異なっていても、
        縮退は起きないことに注意してください。
        </p>
        <p>
        縮退対象の DB ノードは「多数決」で少数派になったものが対象になります。
        もし多数決で同票になった場合は、マスタ DB ノード
        （DB ノード番号がもっともわかいもの）を含むグループが優先され、
        それ以外のグループに所属する DB ノードが切り放しの対象になります。
        </p>
        <p>
        このオプションが false の場合は、該当のセッションを強制的に終了するだけに留めます。
        デフォルト値は false です。
        </p>
      </td>
    </tr>

    <tr>
      <th id="FAIL_OVER_IF_AFFECTED_TUPLES_MISMATCH"><label>{$message.descFailover_if_affected_tuples_mismatch|escape}</label>
      <p>failover_if_affected_tuples_mismatch (bool)</th>
      <td>
        <p>
        各 DB ノードで実行された INSERT/UPDATE/DELETE の結果行数が不一致になった場合に、
        DB ノードを切り放して縮退運転に入ります。
        </p>
        <p>
        縮退対象の DB ノードは「多数決」で少数派になったものが対象になります。
        もし多数決で同票になった場合は、マスタ DB ノード
        （DB ノード番号がもっともわかいもの）を含むグループが優先され、
        それ以外のグループに所属する DB ノードが切り放しの対象になります。
        </p>
        <p>
        このオプションが false の場合は、該当のセッションを強制的に終了するだけに留めます。
        デフォルト値は false です。
        </p>
      </td>
    </tr>

    <tr>
      <th id="FAIL_OVER_ON_BACKEND_ERROR"><label>{$message.descFail_over_on_backend_error|escape}</label>
      <p>fail_over_on_backend_error</th>
      <td>
        <p>
        true ならば、バックエンドのソケットへからの読み出し、書き込みに失敗するとフェイルオーバします。
        false にすると、フェイルオーバせず、単にエラーがレポートされてセッションが切断されます。
        </p>
        <p>
        このパラメータをfalseにする場合には、health check を有効にすることをお勧めします。
        なお、このパラメータが false の場合でも、バックエンドがシャットダウンされたことを
        pgpool-II が検知した場合にはフェイルオーバが起きることに注意してください。
        </p>
      </td>
    </tr>

    <tr>
      <th id="REPLICATION_TIMEOUT"><label>{$message.descReplication_timeout|escape}</label>
      <p>replication_timeout (integer)</th>
      <td>デットロックを監視するためのタイムアウト時間をミリ秒単位で指定します。
      <p>デフォルト値は 5000 (5秒)です。</td>
   </tr>

  </tbody>
  <tfoot>
    <tr>
      <td colspan="2"></td>
    </tr>
  </tfoot>
</table>


<h3><a name="load_balancing_mode" id="load_balancing_mode">Load Balancing Mode</a></h3>

<table>
  <thead>
    <tr>
      <th width="240">{$message.strParameter|escape}</th>
      <th>{$message.strDetail|escape}</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th id="LOAD_BALANCE_MODE"><label>{$message.descLoad_balance_mode|escape}</label>
      <p>load_balance_mode (bool) *</th>
      <td>
        <p>
        true を指定するとレプリケーションモードまたはマスタースレーブモードの際に、
        SELECT 文をロードバランスして検索性能を向上させることができます。デフォルト値は false です。
        </p>
      </td>
    </tr>

    <tr>
      <th id="IGNORE_LEADING_WHITE_SPACE"><label>{$message.descIgnore_leading_white_space|escape}</label>
      <p>ignore_leading_white_space (bool)</th>
      <td>
        <p>
        true ならば、load balance の際に SQL 文行頭の空白を無視します（全角スペースは無視されません）。
        これは、DBI/DBD:Pg のように、勝手に行頭にホワイトスペースを追加するような API を使い、
        ロードバランスしたいときに有効です。
        </p>
      </td>
    </tr>

    <tr>
      <th id="WHITE_FUNCTION_LIST"><label>{$message.descWhite_function_list|escape}</label>
      <p>white_function_list (string)</th>
      <td>
        <p>
        データベースに対して<strong>更新を行なわない関数名</strong>をコンマ区切りで指定します。
        このリストに含まれない関数呼び出しを含む SELECT は、負荷分散の対象とはならず、
        レプリケーションモードにおいてはすべての DB ノードで実行されます
        （マスタースレーブモードにおいては、マスター（primary）DB ノードにのみ送信されます）。
        </p>
        <p>
        関数名には正規表現を使うことができます。
        たとえば、読み出しのみの関数が "get_" あるいは "select_" で始まるならば、以下のような指定が可能です。
        </p>
<pre>
white_function_list = 'get_.*,select_.*'
</pre>
      </td>
    </tr>

    <tr>
      <th id="BLACK_FUNCTION_LIST"><label>{$message.descBlack_function_list|escape}</label>
      <p>black_function_list (string)</th>
      <td>
        <p>
        データベースに対して<strong>更新を行なう関数名</strong>をコンマ区切りで指定します。
        このリストに含まれる関数呼び出しを含む SELECT は、負荷分散の対象とはならず、
        レプリケーションモードにおいてはすべてのDBノードで実行されます。
        このリストに含まれない関数呼び出しを含む SELECT は、負荷分散の対象となります。
        </p>
        <p>
        関数名には正規表現を使うことができます。
        たとえば、読み出しのみの関数が "set_"、"update_"、"delete_" あるいは "insert_" で始まるならば、
        以下のような指定が可能です。
        </p>
<pre>
black_function_list = 'nextval,setval,set_.*,update_.*,delete_.*,insert_.*'
</pre>

        <p>
        white_function_list と black_function_list の両方を空以外にすることはできません。
        どちらか一方のみに関数名を指定します。
        </p>
        <p>
        pgpool-II 3.0 より前のバージョンでは、固定で nextval と setval が書き込みを行なう関数として
        認識されていました。
        それと同じ動作を行なわせるには、以下のように white_function_list と black_function_list を指定します。
        </p>
<pre>
white_function_list = ''
black_function_list = 'nextval,setval,lastval,currval'
</pre>

        <p>
        上の例では、nextval と setval に加え、lastval と currval が追加されていることに注意してください。
        lastval と currval は書き込みを行う関数ではありませんが、これらの関数が負荷分散されることによって、
        エラーが発生するのを未然に防ぐことができます。
        black_function_list に含まれる関数は負荷分散されないからです。
        </p>
      </td>
    </tr>

  </tbody>
  <tfoot>
    <tr>
      <td colspan="2"></td>
    </tr>
  </tfoot>
</table>


<h3><a name="master_slave_mode" id="master_slave_mode">Master/Slave Mode</a></h3>

<table>
  <thead>
    <tr>
      <th width="240">{$message.strParameter|escape}</th>
      <th>{$message.strDetail|escape}</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th id="MASTER_SLAVE_MODE"><label>{$message.descMaster_slave_mode|escape}</label>
      <p>master_slave_mode *</th>
      <td>true ならばマスタ/スレーブモードで pgpool を運転します。
      このモードは replication_mode とは両立できません。
      <p>デフォルトは false です。</td>
      </td>
    </tr>

    <tr><th class="category" colspan="2">Streaming</th></tr>

    <tr>
     <th id="SR_CHECK_PERIOD"><label>{$message.descSr_check_period|escape}</label>
      <p>sr_check_period (integer) *</th>
      <td>
        <p>
        ストリーミングレプリケーションの遅延チェックの間隔を秒単位で指定します。
        デフォルト値は0で、これはチェックを行わないことを意味します。
        </p>
      </td>
    </tr>

    <tr>
     <th id="SR_CHECK_USER"><label>{$message.descSr_check_user|escape}</label>
      <p>sr_check_user (string) *</th>
      <td>
        <p>
        ストリーミングレプリケーションの遅延チェックを行うユーザ名を指定します。
        このユーザは、すべてのバックエンドに存在しなければなりません。
        さもなければエラーになります。
        </p>
        <p>
        sr_check_user と sr_check_password は、sr_check_period が 0 であっても指定が必要です。
        pgpool-II は、どのサーバが primary サーバであるのかを調べるために、
        PostgreSQL バックエンドに関数呼び出しのリクエストを送ります。
        そのセッションで sr_check_user と sr_check_password が使われるからです。
        </p>
        <p>
        このパラメータは設定ファイルの再読込によって変更できます。
        </p>
      </td>
    </tr>

    <tr>
     <th id="SR_CHECK_PASSWORD"><label>{$message.descSr_check_password|escape}</label>
      <p>sr_check_password (string) *</th>
      <td>
        <p>
        ストリーミングレプリケーションの遅延チェックを行うユーザに対するパスワードをを指定します。
        パスワードが必要なければ空文字 ('') を指定します。
        </p>
      </td>
    </tr>

    <tr>
     <th id="DELAY_THRESHOLD"><label>{$message.descDelay_threshold|escape}</label>
      <p>delay_threshold (integer)</th>
      <td>
        <p>
        スタンバイサーバへのレプリケーションの遅延許容度をバイト単位で指定します。
        </p>
        <p>
        pgpool-II は、スタンバイサーバの遅延がこの値を超えた場合には、
        負荷分散が有効であってもその DB ノードに SELECT を送信せず、プライマリサーバに送るようにします。
        delay_threshold が 0 の場合は、遅延のチェックを行ないません。
        また、delay_threshold が指定されていても、<a href="#SR_CHECK_PERIOD">sr_check_period</a>が
        無効 (=0) ならば、やはりこの機能は働きません。
        </p>
        <p>
        デフォルト値は 0 です。
        </p>
      </td>
    </tr>

    <tr><th class="category" colspan="2">Special commands</th></tr>
    <tr>
     <th id="FOLLOW_MASTER_COMMAND"><label>{$message.descFollow_master_command|escape}</label>
      <p>follow_master_command (string) *</th>
      <td>
        <p>
        マスターノードのフェイルオーバー後に実行するコマンドを指定します。
        これは、マスタースレーブモードでストリーミングレプリケーション構成の場合のみ有効です。
        特殊文字を指定すると、pgpool が必要な情報に置き換えてコマンドを実行します。
        </p>

        <center>
        <table>
        <tr class="header"><th>文字</th><th>意味</th></tr>
        <tr><td>%d</td><td>切り離されたノード番号</td></tr>
        <tr><td>%h</td><td>切り離されたノードのホスト名</td></tr>
        <tr><td>%p</td><td>切り離されたノードのポート番号</td></tr>
        <tr><td>%D</td><td>切り離されたノードのデータベースクラスタパス</td></tr>
        <tr><td>%M</td><td>古いマスターのノード番号</td></tr>
        <tr><td>%m</td><td>新しいマスターのノード番号</td></tr>
        <tr><td>%H</td><td>新しいマスターのホスト名</td></tr>
        <tr><td>%P</td><td>古いプライマリノード番号</td></tr>
        <tr><td>%%</td><td>'%'文字</td></tr>
        </table>
        </center>

        <p>
        このパラメータを変更した時には設定ファイルを再読み込みしてください。
        </p>

        <p>
        空文字列以外を指定すると、マスターノードのフェイルオーバー後に新しいマスター以外の
        すべてのノードは切り離され、
        クライアントから再び接続を受け付けるために子プロセスの再起動が行われます。
        その後、切り離されたそれぞれのノードに対して follow_master_command に指定したコマンドが実行されます。
        通常は、ここに <a href="#pcp_recovery_node">pcp_recovery_node</a> コマンドを
        組み込んだシェルスクリプトなどを指定し、新しいマスターからスレーブをリカバリするために使用します。
        </p>
       </td>
     </tr>
  </tbody>
  <tfoot>
    <tr>
      <td colspan="2"></td>
    </tr>
  </tfoot>
</table>



<h3><a name="parallel_mode" id="parallel_mode">Parallel Mode and Query Cache</a></h3>

<table>
  <thead>
    <tr>
      <th width="240">{$message.strParameter|escape}</th>
      <th>{$message.strDetail|escape}</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th id="PARALLEL_MODE"><label>{$message.descParallel_mode|escape}</label>
      <p>parallel_mode *</th>
      <td>pgpool をパラレルモードで稼働させる場合には true を指定します。
       この場合には分散ルールを指定する必要があります。
      <p>デフォルト値は false です。</td>
    </tr>

    <tr>
      <th id="ENABLE_QUERY_CACHE"><label>{$message.descEnable_query_cache|escape}</label>
      <p>enable_query_cache *</th>
      <td>SELECT の結果をキャッシュする場合には true にします。
      <p>デフォルト値は false です。</td>
    </tr>

    <tr>
      <th id="PGPOOL2_HOSTNAME"><label>{$message.descPgpool2_hostname|escape}</label>
      <p>pgpool2_hostname (string) *</th>
      <td>pgpool2 が稼働しているホスト名を指定します。
      <p>デフォルトでは設定されていません。
      </td>
    </tr>

   <tr><th class="category" colspan="2">System DB info</th></tr>

    <tr>
      <th id="SYSTEM_DB_HOSTNAME"><label>{$message.descSystem_db_hostname|escape}</label>
      <p>system_db_hostname (string) *</th>
      <td>システム DB が稼働しているホスト名を指定します。
      指定しない場合には Unix domain socket で接続します。
      <p>デフォルト値は localhost です。</td>
    </tr>

    <tr>
      <th id="SYSTEM_DB_PORT"><label>{$message.descSystem_db_port|escape}</label>
      <p>system_db_port (integer) *</th>
      <td>システム DB がある PostgreSQL に接続するためのポート番号を指定します。
      <p>デフォルト値は 5432 です。</td>
    </tr>

    <tr>
      <th id="SYSTEM_DB_DBNAME"><label>{$message.descSystem_db_dbname|escape}</label>
      <p>system_db_dbname (string) *</th>
      <td>システムDBのデータベース名を指定します。
      <p>デフォルト値は pgpool です。</td>
    </tr>

    <tr>
      <th id="SYSTEM_DB_SCHEMA"><label>{$message.descSystem_db_schema|escape}</label>
      <p>system_db_schema (string) *</th>
      <td>システムDBのスキーマを指定します。
      <p>デフォルト値は pgpool_catelog です。</td>
    </tr>

    <tr>
      <th id="SYSTEM_DB_USER"><label>{$message.descSystem_db_user|escape}</label>
      <p>system_db_user (string) *</th>
      <td>システムDBに接続するユーザ名を指定します。
      <p>デフォルト値は pgpool です。</td>
    </tr>

    <tr>
      <th id="SYSTEM_DB_PASSWORD"><label>{$message.descSystem_db_password|escape}</label>
      <p>system_db_password (string) *</th>
      <td>システムDBに接続するユーザのパスワードを指定します。
      <p>デフォルト値は設定されていません。</td>
    </tr>
  </tbody>
  <tfoot>
    <tr>
      <td colspan="2"></td>
    </tr>
  </tfoot>
</table>


<h3><a name="health-check">Health Check</a></h3>

<table>
  <thead>
    <tr>
      <th width="240">{$message.strParameter|escape}</th>
      <th>{$message.strDetail|escape}</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th id="HEALTH_CHECK_TIMEOUT"><label>{$message.descHealth_check_timeout|escape}</label>
      <p>health_check_timeout (integer)</th>
      <td>
        <p>
        pgpool-II はサーバ障害やネットワーク障害を検知するために、定期的にバックエンドに接続を試みます。
        これを「ヘルスチェック」と言います。障害が検知されると、フェイルオーバや縮退運転を試みます。
        </p>
        <p>
        この パラメータは、ネットワークケーブルが抜けた際などにヘルスチェックが長時間待たされるのを防ぐための
        タイムアウト値を秒単位で指定します。
        デフォルトは 20 秒です。0 を指定するとタイムアウト処理をしません
        (すなわち TCP/IP のタイムアウトまで待つことになります)。
        </p>
        <p>
        なお、ヘルスチェックを有効にすると、ヘルスチェックのための余分の接続が 1 つ必要になりますので、
        PostgreSQL の postgresql.conf の設定項目の max_connections を少くとも1増やすようにしてください。
        </p>
        <p>
        このパラメータを変更した時には設定ファイルを再読み込みしてください。
        </p>
      </td>
    </tr>

    <tr>
      <th id="HEALTH_CHECK_PERIOD"><label>{$message.descHealth_check_period|escape}</label>
      <p>health_check_period (integer)</th>
      <td>
      <p>
      ヘルスチェックを行う間隔を秒単位で指定します。0を指定するとヘルスチェックを行いません。
      デフォルトは0です（つまりヘルスチェックを行いません）。
      </p>
      </td>
   </tr>

    <tr>
      <th id="HEALTH_CHECK_USER"><label>{$message.descHealth_check_user|escape}</label>
      <p>health_check_user (string)</th>
      <td>
        <p>
        ヘルスチェックを行うための PostgreSQL ユーザ名です。
        このユーザ名は PostgreSQL に登録済みでなければなりません。
        さもないと、ヘルスチェックがエラーとなります。
        </p>
      </td>
    </tr>

    <tr>
      <th id="HEALTH_CHECK_PASSWORD"><label>{$message.descHealth_check_password|escape}</label>
      <p>health_check_password (string)</th>
      <td>
        <p>ヘルスチェックを行うためのPostgreSQLパスワードです。</p>
      </td>
    </tr>

    <tr>
      <th id="HEALTH_CHECK_MAX_RETRIES"><label>{$message.descHealth_check_max_retries|escape}</label>
      <p>health_check_max_retries (integer)</th>
      <td>
        <p>
        ヘルスチェックに失敗した後（したがってフェイルオーバする前に）リトライする回数を指定します。
        この設定は動作にむらのあるネットワーク環境において、マスタが正常であるにも関わらず
        たまにヘルスチェックが失敗することが予想される場合に有用です。
        デフォルト値は 0 で、この場合はリトライをしません。
        </p>
        <p>
        この設定を有効にする場合は、併せて <a href="#FAIL_OVER_ON_BACKEND_ERROR">fail_over_on_backend_error</a> を
        off にすることをお勧めします。
        </p>
      </td>
    </tr>

    <tr>
      <th id="HEALTH_CHECK_RETRY_DELAY"><label>{$message.descHealth_check_retry_delay|escape}</label>
      <p>health_check_retry_delay (integer)</th>
      <td>
        <p>
        ヘルスチェックのリトライの間の秒数を指定します
        （health_check_max_retries &gt; 0でなければ有効になりません）。
        0を指定すると、待ちなしに直ちにリトライします。
        </p>
      </td>
    </tr>
  </tbody>
  <tfoot>
    <tr>
      <td colspan="2"></td>
    </tr>
  </tfoot>
</table>


<h3><a name="failover" id="failover">Failover and Failback</a></h3>

<table>
  <thead>
    <tr>
      <th width="240">{$message.strParameter|escape}</th>
      <th>{$message.strDetail|escape}</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th id="FAILOVER_COMMAND"><label>{$message.descFailover_command|escape}</label>
      <p>failover_command</th>
      <td>
        <p>
        ノードが切り離された時に実行するコマンドを指定します。特殊文字を指定すると、
        pgpool が必要な情報に置き換えてコマンドを実行します。
        </p>

        <center>
        <table>
        <tr class="header"><th>文字</th><th>意味</th></tr>
        <tr><td>%d</td><td>切り離されたノード番号</td></tr>
        <tr><td>%h</td><td>切り離されたノードのホスト名</td></tr>
        <tr><td>%H</td><td>新しいマスターのホスト名</td></tr>
        <tr><td>%p</td><td>切り離されたノードのポート番号</td></tr>
        <tr><td>%D</td><td>切り離されたノードのデータベースクラスタパス
        </td></tr>
        <tr><td>%M</td><td>古いマスターのノード番号</td></tr>
        <tr><td>%m</td><td>新しいマスターのノード番号</td></tr>
        <tr><td>%P</td><td>古いプライマリノード番号</td></tr>
        <tr><td>%%</td><td>'%'文字</td></tr>
        </table>
        </center>

        <p>
        このパラメータを変更した時には設定ファイルを再読み込みしてください。
        </p>
        <p>
        フェイルオーバー時には、pgpool はまず子プロセスを切断します(結果として、すべてのセッションが切断されます)。
        次に、pgpool はフェイルオーバコマンドを実行し、その完了を待ちます。
        そのあとで新しい pgpool の子プロセスが起動され、クライアントからの接続を受け付けられる状態になります。
        </p>
      </td>
    </tr>

    <tr>
      <th id="FAILBACK_COMMAND"><label>{$message.descFailback_command|escape}</label>
      <p>failback_command</th>
      <td>
        <p>
        ノードが復帰した時に実行するコマンドを指定します。特殊文字を指定すると、
        pgpool が必要な情報に置き換えてコマンドを実行します。
        </p>

        <center>
        <table>
        <tr class="header"><th>文字</th><th>意味</th></tr>
        <tr><td>%d</td><td>復帰したノード番号</td></tr>
        <tr><td>%h</td><td>復帰したノードのホスト名</td></tr>
        <tr><td>%p</td><td>復帰したノードのポート番号</td></tr>
        <tr><td>%D</td><td>復帰したノードのデータベースクラスタパス
        </td></tr>
        <tr><td>%M</td><td>古いマスターのノード番号</td></tr>
        <tr><td>%m</td><td>新しいマスターのノード番号</td></tr>
        <tr><td>%H</td><td>新しいマスターのホスト名</td></tr>
        <tr><td>%P</td><td>古いプライマリノード番号</td></tr>
        <tr><td>%%</td><td>'%'文字</td></tr>
        </table>
        </center>

        <p>
        このパラメータを変更した時には設定ファイルを再読み込みしてください。
        </p>
      </td>
    </tr>
  </tbody>
  <tfoot>
    <tr>
      <td colspan="2"></td>
    </tr>
  </tfoot>
</table>



<h3><a name="online-recovery">Online Recovery</a></h3>
<table>
  <thead>
    <tr>
      <th width="240">{$message.strParameter|escape}</th>
      <th>{$message.strDetail|escape}</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th id="RECOVERY_USER"><label>{$message.descRecovery_user|escape}</label>
      <p>recovery_user (string)</th>
      <td>
      <p>
      オンラインリカバリを行うための PostgreSQL ユーザ名です。
      デフォルト値は 'nobody' です。
      </p>
      </td>
    </tr>

    <tr>
      <th id~"RECOVERY_PASSWORD"><label>{$message.descRecovery_password|escape}</label>
      <p>recovery_password (string)</th>
      <td>
      <p>
      オンラインリカバリを行うための PostgreSQL ユーザパスワードです。
      デフォルト値は設定されていません。
      </p>
      </td>
   </tr>

    <tr>
      <th id="RECOVERY_1ST_STAGE"><label>{$message.descRecovery_1st_stage_command|escape}</label>
      <p>recovery_1st_stage_command (string)</th>
      <td>
        <p>
        オンラインリカバリ中に起動するコマンド名を指定します。
        このスクリプトは PostgreSQL のマスタ（プライマリ）サーバが起動します。
        コマンドファイルはセキュリティ上の観点からデータベースクラスタ以下にある
        コマンドやスクリプトのみを呼び出します。
        例えば、recovery_1st_stage_command = 'sync-command' と設定してある場合、
        $PGDATA/sync-command を起動しようとします。
        </p>
        <p>
        recovery_1st_stage_command は次の 3 つの引数を受けとります。
        </p>
        <ol>
            <li>マスタ（プライマリ）データベースクラスタへのパス</li>
            <li>リカバリ対象の PostgreSQL のホスト名</li>
            <li>リカバリ対象のデータベースクラスタへのパス</li>
        </ol>
        <p>
        recovery_1st_stage_command を実行している間は pgpool ではクライアン
        トからの接続を<b>制限しません</b>。参照や更新を行うことができます。
        </p>
      </td>
    </tr>

    <tr>
      <th id="RECOVERY_2ND_STAGE"><label>{$message.descRecovery_2nd_stage_command|escape}</label>
      <p>recovery_2nd_stage_command (string)</th>
      <td>
        <p>
        2 回目のオンラインリカバリ中に起動するコマンド名を指定します。
        このスクリプトは PostgreSQL のマスタ（プライマリ）サーバが起動します。
        コマンドファイルはセキュリティ上の観点からデータベースクラスタ以下にある
        コマンドやスクリプトのみを呼び出します。
        例えば、recovery_2nd_stage_command = 'sync-command' と設定してある場合、
        $PGDATA/sync-command を起動しようとします。
        </p>
        <p>
        recovery_2nd_stage_command は次の 3 つの引数を受けとります。
        </p>
        <ol>
            <li>マスタ（プライマリ）データベースクラスタへのパス</li>
            <li>リカバリ対象の PostgreSQL のホスト名</li>
            <li>リカバリ対象のデータベースクラスタへのパス</li>
        </ol>
        </p>
        <p>
        recovery_2nd_stage_command を実行している間は pgpool ではクライアントから
        接続、参照、更新処理を一切<b>受け付けません</b>。
        また、バッチ処理などによって接続しているクライアントが長時間存在している場合にはコマンドを起動しません。
        新たな接続を制限し、現在の接続数が 0 になった時点
        でコマンドを起動します。
        </p>
      </td>
    </tr>

    <tr>
      <th id="RECOVERY_TIMEOUT"><label>{$message.descRecovery_timeout|escape}</label>
      <p>recovery_timeout (integer)</th>
      <td>
        <p>
        pgpool は、オンラインリカバリの際にすべてのクライアントが接続を終了するまで待ちます。
        recovery_timeout でその最大待ち時間を指定します。単位は秒です。
        待ち時間が recovery_timeout を越えると、オンラインリカバリは中止され、通常の状態に戻ります。
        </p>
        <p>
        アイドル状態のクライアントが自分から切断するのを待ちたくない場合は、
        <a href="#CLIENT_IDLE_LIMIT_IN_RECOVERY">client_idle_limit_in_recovery</a> を利用することもできます。
        </p>
        </p>
        <p>
        recovery_timeout は、この他、オンラインリカバリの最後にリカバリ対象のDBノードで
        postmasterを起動する際の待ち時間にも利用されます。
        </p>
        <p>
        recovery_timeout のデフォルト値は 90 秒です。
        recovery_timeout を 0 としてもタイムアウトが無効になるわけではなく、
        単に即座にタイムアウトするだけですので注意してください。
        </p>
      </td>
    </tr>

    <tr>
      <th id="CLIENT_IDLE_LIMIT_IN_RECOVERY"><label>{$message.descClient_idle_limit_in_recovery|escape}</label>
      <p>client_idle_limit_in_recovery (integer)</th>
      <td>
        <p>
        client_idle_limitと似ていますが、このパラメータはリカバリのセカンドステージでのみ効力があります。
        前回クライアントから来たクエリから、client_idle_limit_in_recovery 秒越えても次のクエリが届かない場合は、
        クライアントへの接続を強制的に切断し、リカバリのセカンドステージの進行が妨害されるのを防ぎます。
        -1 を指定すると、直ちにクライアントへの接続を切断してセカンドステージに入ります。
        </p>
        <p>
        デフォルト値は 0(無効)です。
        </p>
        <p>
        クライアントが忙しく、アイドル状態にならない場合は client_idle_limit_in_recovery を設定しても
        セカンドステージに移行できません。
        この場合、client_idle_limit_in_recovery に -1 を設定すると、クライアントがビジーであっても
        ただちにクライアントへの接続を切断し、セカンドステージに移行することができます。
        </p>
      </td>
    </tr>

  </tbody>
  <tfoot>
    <tr>
      <td colspan="2"></td>
    </tr>
  </tfoot>
</table>


<h3><a name="memqcache" id="memqcache">On Memory Query Cache</a></h3>

<table>
  <thead>
    <tr>
      <th width="240">{$message.strParameter|escape}</th>
      <th>{$message.strDetail|escape}</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th id="MEMORY_CACHE_ENABLED"><label>{$message.descMemory_cache_enabled|escape}</label>
      <p>memory_cache_enabled (bool)</th>
      <td>
      <p>オンメモリクエリキャッシュを有効にするには、このパラメータを有効にします。</p>
      </td>
    </tr>

    <tr>
      <th id="MEMQCACHE_METHOD"><label>{$message.descMemqcache_method|escape}</label>
      <p>memqcache_method (string) *</th>
      <td>
        <p>
        メモリキャッシュのストレージには、共有メモリと <a href="http://memcached.org">memcached</a> のどちらかを
        選択することができます（併用はできません）。
        <p>
        共有メモリを使用するクエリキャッシュは高速で、memcached の立ち上げも必要なく、手軽に利用できます。
        ただし、共有メモリサイズの上限によって保存できるキャッシュの量に制限があります。
        memcached をキャッシュストレージに使用する場合は、ネットワークアクセスのオーバヘッドがあるものの、
        比較的自由にキャッシュメモリの大きさを設定できます。
        </p>
        <p>
        共有メモリを利用する場合は 'shmem'、Memcached を利用する場合は'memcached'と設定します。
        デフォルトは、'shmem'です。
        </p>
      </td>
    </tr>

    <tr><th class="category" colspan="2">Memcached specific</th></tr>

    <tr>
      <th id="MEMQCACHE_MEMCACHED_HOST"><label>{$message.descMemqcache_memcached_host|escape}</label>
      <p>memqcache_memcached_host (string) *</th>
      <td>
        <p>
        memcached が動いているホスト名またはIPアドレスを指定します。
        pgpool-II と同じマシンで memcached を動かす場合は、'localhost' とします。
        </p>
      </td>
    </tr>

    <tr>
      <th id="MEMQCACHE_MEMCACHED_PORT"><label>{$message.descMemqcache_memcached_port|escape}</label>
      <p>memqcache_memcached_port (integer) *</th>
      <td>
        <p>
        memcached のポート番号を指定します。デフォルト値は 11211 です。
        </p>
      </td>
    </tr>

    <tr><th class="category" colspan="2">Shared memory specific</th></tr>

    <tr>
      <th id="MEMQCACHE_TOTAL_SIZE"><label>{$message.descMemqcache_total_size|escape}</label>
      <p>memqcache_total_size (integer) *</th>
      <td>
        <p>
        キャッシュストレージに使用する共有メモリ領域のサイズを指定します。単位はバイトです。
        </p>
      </td>
    </tr>

    <tr>
      <th id="MEMQCACHE_MAX_NUM_CACHE"><label>{$message.descMemqcache_max_num_cache|escape}</label>
      <p>memqcache_max_num_cache (integer) *</th>
      <td>
        <p>
        キャッシュの数を指定します。
        この設定項目は、キャッシュの管理領域の大きさを決めるために使用します
        （<a href="MEMQCACHE_TOTAL_SIZE">memqcache_total_size</a>と は別に取られます）。
        管理領域の大きさは、memqcache_max_num_cache * 48 (バイト) になります。
        この数は少なすぎるとキャッシュを登録することができずにエラーになります。
        逆に多すぎると無駄になります。
        </p>
      </td>
    </tr>

    <tr>
      <th id="MEMQCACHE_CACHE_BLOCK_SIZE"><label>{$message.descMemqcache_cache_block_size|escape}</label>
      <p>memqcache_cache_block_size (integer) *</th>
      <td>
        <p>
        キャッシュストレージとして共有メモリを使用する場合は、メモリを
        memqcache_cache_block_size のブロックに分けて利用します。
        検索結果のキャッシュはこのブロックに入るだけ詰め込まれます。
        ただし、キャッシュは複数のブロックにまたがって格納されないので、
        memqcache_cache_block_sizeを検索結果が超えると、キャッシュに格納できなくなります。
        </p>
        <p>
        memqcache_cache_block_sizeは、512 以上の値でなければなりません。
        </p>
      </td>
    </tr>

    <tr><th class="category" colspan="2">Common</th></tr>

    <tr>
      <th id="MEMQCACHE_EXPIRE"><label>{$message.descMemqcache_expire|escape}</label>
      <p>memqcache_expire (integer) *</th>
      <td>
        <p>
        クエリキャッシュの寿命を秒単位で設定します。デフォルトは 60 です。
        0 を指定すると寿命が無限大になり、関連テーブルが更新されるまではキャッシュが有効になります。
        </p>
        <p>
        なお、この設定は、<a href="#MEMQCACHE_AUTO_CACHE_INVALIDATION">memqcache_auto_cache_invalidation</a>とは
        独立です。
        </p>
      </td>
    </tr>

    <tr>
      <th id="MEMQCACHE_MAXCACHE"><label>{$message.descMemqcache_maxcache|escape}</label>
      <p>memqcache_maxcache (integer) *</th>
      <td>
        <p>
        true ならば関連するテーブルが更新されるとキャッシュを無効化します。
        false ならばテーブルが更新されてもキャッシュを無効化しません。
        デフォルト値は true です。
        </p>
        <p>
        なお、この設定は<a href="#MEMQCACHE_EXPIRE">memqcache_expire</a>の設定とは独立です。
        </p>
      </td>
    </tr>

    <tr>
      <th id="MEMQCACHE_AUTO_CACHE_INVALIDATION"><label>{$message.descMemqcache_auto_cache_invalidation|escape}</label>
      <p>memqcache_auto_cache_invalidation (bool) *</th>
      <td>
        <p>
        SELECT文の実行結果が memqcache_maxcache バイトを超えると、キャッシュされません。
        </p>
        <p>
        この問題を回避するためには、memqcache_maxcache を大きくすれば良いのですが、
        キャッシュストレージとして共有メモリを使用する場合は、
        <a href="#MEMQCACHE_CACHE_BLOCK_SIZE">memqcache_cache_block_size</a> を超えないようにしてください。
        キャッシュストレージとして memcached を使用する場合は、
        memcached のスラブサイズ（デフォルトで 1MB）を超えないようにしてください。
        </p>
      </td>
    </tr>

    <tr>
      <th id="MEMQCACHE_OIDDIR"><label>{$message.descMemqcache_oiddir|escape}</label>
      <p>memqcache_oiddir (string) *</th>
      <td>
        <p>
        SELECT 文が使用するテーブルに OID を格納する一時ファイル領域のトップディレクトリをフルパスで指定します。
        memqcache_oiddir 以下には、データベース OID 名のディレクトリが作成され、
        更にその下にはテーブル OID 名のファイルが作成されます。
        テーブル OID 名ファイルの中には、クエリキャッシュへのポインタが格納されており、
        テーブルの更新があった際にキャッシュを削除するキーとなります。
        </p>
        <p>
        この領域は pgpool が再起動されると自動的に削除されます。
        </p>
      </td>
    </tr>

    <tr>
      <th id="WHITE_MEMQCACHE_TABLE_LIST"><label>{$message.descWhite_memqcache_table_list|escape}</label>
      <p>white_memqcache_table_list (string)</th>
      <td>
        <p>
        VIEW やunloggedテーブルを使っているSELECTは通常キャッシュの対象になりませんが、
        white_memqcache_table_list に記述しておくことで、キャッシュされるようになります。
        テーブル名はカンマ区切りで指定します。正規表現も利用できます。
        <p>
        なお、同じテーブル・VIEW が <a href="#BLACK_MEMQCACHE_TABLE_LIST">black_memqcache_table_list</a> と両方に
        指定されている場合は、white_memqcache_table_list が優先され、キャッシュを利用します。
        </p>
      </td>
    </tr>

    <tr>
      <th id="BLACK_MEMQCACHE_TABLE_LIST"><label>{$message.descBlack_memqcache_table_list|escape}</label>
      <p>black_memqcache_table_list(string)</th>
      <td>
        <p>
        SELECT 結果をキャッシュしたくないテーブル名をカンマ区切りで指定します。正規表現も利用できます。
        </p>
      </td>
    </tr>

  </tbody>
  <tfoot>
    <tr>
      <td colspan="2"></td>
    </tr>
  </tfoot>
</table>


<h3><a name="others">Others</a></h3>

<table>
  <thead>
    <tr>
      <th width="240">{$message.strParameter|escape}</th>
      <th>{$message.strDetail|escape}</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th id="RELCACHE_EXPIRE"><label>{$message.descRelcache_expire|escape}</label>
      <p>relcache_expire (integer)</th>
      <td>
        <p>
        リレーションキャッシュの寿命を秒単位で指定します。
        0を指定すると、キャッシュの寿命の管理は行わず、プロセスが生きているか、
        キャッシュが溢れるまでは有効になります（デフォルトの動作）。
        </p>
        <p>
        リレーションキャッシュは、PostgreSQL のシステムカタログに対する問い合わせを保存しておくものです。
        問い合わせる内容は、テーブルの構造、テーブルが一時テーブルかどうかなどがあります。
        キャッシュは pgpool の子プロセスのローカルメモりに保管されています。
        <p>
        もし ALTER TABLE が発行されると、テーブルの構造が変わる場合があり、
        リレーションキャッシュの内容と一致しなくなる恐れがあります。
        relcache_expireにより、その危険性をコントロールできるようになります。
        </p>
      </td>
    </tr>
  </tbody>
  <tfoot>
    <tr>
      <td colspan="2"></td>
    </tr>
  </tfoot>
</table>

</div>
<hr class="hidden" />
<div id="footer">
{include file='footer.tpl'}
</div>
</body>
</html>
