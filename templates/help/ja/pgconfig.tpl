<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>{$message.strPgConfSetting|escape}</title>
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
<div id="help"><a href="{$help}.php"><img src="images/back.gif" />{$message.strBack}</a></div>
  <h2>{$message.strHelp|escape}({$message.strPgConfSetting|escape})</h2>
  <h3>{$message.strSummary|escape}</h3>
  pgpoolの設定ファイルであるpgpool.confの設定内容を表示・変更することができます。
  <h3>{$message.strFeature|escape}</h3>
  変更したい値を入力して更新ボタンを押してください。
  <h3>バックエンドホストの追加</h3>
  新しいバックエンドホストを追加したい場合には、追加ボタンを押してください。<br />
  バックエンドホストの項目に新しい入力欄ができますので、そこに新しいバックエンドホストの情報を入力してください。<br />
  入力が終わりましたら、更新ボタンを押してください。
  <h3>バックエンドホストの削除</h3>

  登録してあるバックエンドホストを削除したい場合には、そのホスト設定の右側にある削除ボタンを押してください。<br />
  <div id="submenu">
    <h3>Table of Contents</h3>
    <ul>
      <li><a href="#connections">Connections</a></li>
      <li><a href="#backends">Backends</a></li>
      <li><a href="#pcp">PCP</a></li>
      <li><a href="#logging">Logging</a></li>
      <li><a href="#replication">Replication</a></li>
      <li><a href="#health-check">Health Check</a></li>
	  <li><a href="#online-recovery">Online Recovery</a></li>
      <li><a href="#system-database">System Database</a></li>
      <li><a href="#others">Others</a></li>
    </ul>
  </div>
    <h3><a name="connections">Connections</a></h3>
    <table>
      <thead>
        <tr>
          <th>{$message.strParameter|escape}</th>
          <th>{$message.strDetail|escape}</th>

        </tr>
      </thead>
      <tbody>
        <tr>
          <th><label>{$message.descListen_addresses|escape}</label>
          <br>listen_addresses (string)</th>
          <td>
TCP/IPコネクションを受け付けるアドレスをホスト名またはIPアドレスで指定します。「*」を指定するとすべてのIPインタフェースからのコネクションを受け付けます。「''」を指定するとTCP/IPコネクションを受け付けま
せん。デフォルト値は「localhost」です。<br />UNIXドメインソケット経由のコネクションは常に受け付けます。
          </td>

        </tr>
        <tr>
          <th><label>{$message.descPort|escape}</label>
          <br>port (integer)</th>
          <td>pgpoolがコネクションを受け付けるポート番号です。デフォルト値は9999です</td>
        </tr>
        <tr>

          <th><label>{$message.descSocket_dir|escape}</label>
          <br>socket_dir (string)</th>
          <td>PostgreSQLサーバのUnix domain socketのディレクトリです。デフォルト値は'/tmp'です。</td>
        </tr>
        <tr>
          <th><label>{$message.descNum_init_children|escape}</label>
          <br>num_init_children (integer)</th>

          <td>preforkするpgpoolのサーバプロセスの数です。デフォルト値は32になっています。<br />
なお、問い合わせのキャンセルを行うと通常のコネクションとは別に新たなコネクションが張られます。したがって、すべてのコネクションが使用中の場合は問い合わせのキャンセルができなくってしまうので、ご注意下
   さい。問い合わせのキャンセルを必ず保証したい場合は、想定されるコネクション数の倍の値を設定することをおすすめします。</td>
        </tr>
        <tr>
          <th><label>{$message.descMax_pool|escape}</label>
          <br>max_pool (integer)</th>
          <td>pgpoolの各サーバプロセスがキープするPostgreSQLへの最大コネクション数です。pgpoolは、ユーザ名、データベースが同じならばコネクションを再利用しますが、そうでなければ新たにPostgreSQLへのコネクションを確立しようとします。したがって、ここでは想定される[ユーザ名:データベース名]のペアの種類の数だけをmax_poolに指定しておく必要があります。もしmax_poolを使いきってしまった場合は一番古いコネクションを切断し、そのスロットが再利用されます。<br />max_poolのデフォルト値は4です。<br />なお、pgpool全体としては、num_init_children*max_pool 分だけPostgreSQLへのコネクションが張られる点に注意してください</td>

        </tr>
        <tr>
          <th><label>{$message.descChild_life_time|escape}</label>
          <br>child_life_time (integer)</th>
          <td>pgpoolの子プロセスの寿命です。アイドル状態になってからchild_life_time秒経過すると、一旦終了して新しいプロセスを起動します。メモリーリークその他の障害に備えた予防措置です。child_life_timeのデフォルト値は300秒、すなわち5分です。0を指定するとこの機能は働きません（すなわち起動しっ放し）。なお、まだ一度もコネクションを受け付けていないプロセスにはchild_life_timeは適用されません。</td>
        </tr>
        <tr>

          <th><label>{$message.descConnection_life_time|escape}</label>
          <br>connection_life_time (integer)</th>
          <td>コネクションプール中のコネクションの有効期間を秒単位で指定します。0を指定すると有効期間は無限になります。connection_life_timeのデフォルト値は0です。</td>
        <tr>
          <th><label>{$message.descChild_max_connections|escape}</label>
          <br>child_max_connections (integer)</th>

          <td>各pgpool子プロセスへの接続回数がこの設定値を超えると、その子プロセスを終了します。child_life_timeやconnection_life_timeが効かないくらい忙しいサーバで、PostgreSQLバックエンドが肥大化するのを防ぐのに有効です。</td>
        </tr>
        <tr>
          <th><label>{$message.descConnection_cache|escape}</label>
					<br>connection_cache</th>
          <td>trueならコネクションをキャッシュします。デフォルトはtrueです。</td>
        </tr>

        <tr>
          <th><label>{$message.descPgpool2_hostname|escape}</label>
          <br>pgpool2_hostname (string)</th>
		  <td>pgpool2が稼働しているホスト名を指定します。</td>
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

          <th>{$message.strParameter|escape}</th>
          <th>{$message.strDetail|escape}</th>
          <td></td>
        </tr>
      </thead>
      <tbody>
        <tr>
          <th><label>{$message.descBackend_socket_dir|escape}</label>
          <br>backend_socket_dir (string)</th>
          <td>PostgreSQLサーバのUnix domain socketのディレクトリです。デフォルト値は'/tmp'です。</td>
        </tr>
        <tr>
		  <th><label>{$message.descBackend_hostname|escape}</label>
      <br />backend_hostname (string)</th>
		  <td>postmasterが稼働しているホスト名を指定します。指定しない場合にはUnix domain socketで接続します。</td>
        </tr>

		<tr>
    <th><label>{$message.descBackend_port|escape}</label>
    <br />backend_port (integer)</th>
		<td>postmasterが稼働しているポート番号です。</td>
      </tr>
      <tr>
        <th><label>{$message.descBackend_weight|escape}</label><br />backend_weight (integer)</th>
		<td>ロードバランスモード時に振り分ける重みを0から1の値で設定します。すべてのバックエンドサーバで指定した値から相対的な重みを計算して振り分けます。</td>

      </tr>
	  </tbody>
    </table>
    <h3><a name="pcp">PCP (pgpool Control Port)</a></h3>
    <table>
      <thead>
        <tr>
          <th>{$message.strParameter|escape}</th>

          <th>{$message.strDetail|escape}</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <th><label>{$message.descPcp_port|escape}</label>
          <br>pcp_port (integer)</th>

          <td>PCPに接続するためのポート番号です。デフォルトは9898です。</td>
        </tr>
        <tr>
          <th><label>{$message.descPcp_socket_dir|escape}</label>
          <br>pcp_socket_dir (string)</th>
		  <td>PCPのUnix domain socketのディレクトリです。デフォルト値は'/tmp'です。</td>
        </tr>
        <tr>

          <th><label>{$message.descPcp_timeout|escape}</label>
          <br>pcp_timeout (integer)</th>
		  <td>PCPコマンドのタイムアウトを設定します。この時間の間に応答がない場合にはコネクションを切断します。</td>
        </tr>
      </tbody>
      <tfoot>
        <tr>
          <td colspan="2"></td>

        </tr>
      </tfoot>
    </table>
    <h3><a name="logging">Logging</a></h3>
    <table>
      <thead>
        <tr>
          <th>{$message.strParameter|escape}</th>

          <th>{$message.strDetail|escape}</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <th><label>{$message.descLogdir|escape}</label>
          <br>logdir (string)</th>

		  <td>pgpoolの各種ログファイルを格納するディレクトリです。現在のところ、pgpool.pidというプロセスIDを格納するファイルだけが作られるようになっています。logdirのデフォルト値は'/tmp'です。</td>
        </tr>
        <tr>
          <th><label>{$message.descPrint_timestamp|escape}</label>
					<br>print_timestamp</th>
		  <td>trueならばpgpoolのログにタイムスタンプを追加します。デフォルトはtrueです。</td>
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
          <th>{$message.strParameter|escape}</th>
          <th>{$message.strDetail|escape}</th>
        </tr>
      </thead>
      <tbody>

        <tr>
          <th><label>{$message.descReplication_mode|escape}</label>
					<br>replication_mode</th>
		  <td>レプリケーションモードで動作させる場合はtrueを指定してください。デフォルト値はfalseです。</td>
        </tr>
        <tr>
          <th><label>{$message.descReplication_timeout|escape}</label>
          <br>replication_timeout (integer)</th>

		  <td>ノード間でのデッドロックを監視するためのタイムアウト時間をミリ秒単位で指定します。デフォルト値は5000、すなわち5秒です。0を指定するとタイムアウトしなくなります。</td>
        </tr>
        <tr>
          <th><label>{$message.descReplication_stop_on_mismatch|escape}</label>
					<br>replication_stop_on_mismatch</th>
		  <td>trueを指定するとマスタとセカンダリの間でデータの不一致があった場合に強制的に縮退運転に入ります。このオプションがfalseの場合は、該当の問い合わせを強制的に終了するだけに留めます。デフォルト値はfalseです。</td>
		</tr>

        <tr>
          <th><label>{$message.descReset_query_list|escape}</label>
          <br>reset_query_list (string)</th>
		  <td>セッションが終了するときにコネクションを初期化するためのSQLコマンドを「;」で区切って列挙します。デフォルトは以下のようになっていますが、任意のSQL文を追加しても構いません。
		  <p>reset_query_list = 'ABORT; RESET ALL; SET SESSION AUTHORIZATION DEFAULT'</p>
PostgreSQLのバージョンによって使用できるSQLコマンドが違うので、PostgreSQL 7.3以前では注意してください(「4. pgpoolの稼働環境」参照)。<br />なお、「ABORT」は、PostgreSQL 7.4以上ではトランザクションブロックの中にいない場合には発行されません。
          </td>
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
          <th>{$message.strParameter|escape}</th>
          <th>{$message.strDetail|escape}</th>
        </tr>
      </thead>
      <tbody>

        <tr>
          <th><label>{$message.descHealth_check_timeout|escape}</label>
          <br>health_check_timeout (integer)</th>
		  <td> pgpoolはサーバ障害やネットワーク障害を検知するために、定期的にバックエンドに接続を試みます。これを「ヘルスチェック」と言います。障害が検知されると、フェイルオーバや縮退運転を試みます。<br />この パラメータは、ネットワークケーブルが抜けた際などにヘルスチェックが長時間待たされるのを防ぐためのタイムアウト値を秒単位で指定します。デフォルトは20秒です。0を指定するとタイムアウト処理をしません。<br />なお、ヘルスチェックを有効にすると、ヘルスチェックのための余分の接続が1つ必要になりますので、PostgreSQLのpostgresql.confの設定項目のmax_connectionsを少くとも1増やすようにしてください</td>
        </tr>
        <tr>

          <th><label>{$message.descHealth_check_period|escape}</label>
          <br>health_check_period (integer)</th>
		  <td>ヘルスチェックを行う間隔を秒単位で指定します。0を指定するとヘルスチェックを行いません。デフォルトは0です(つまりヘルスチェックを行いません)。
		  </td>
        </tr>
        <tr>
          <th><label>{$message.descHealth_check_user|escape}</label>
          <br>health_check_user (string)</th>

		  <td>ヘルスチェックを行うためのPostgreSQLユーザ名です。</td>
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
          <th>{$message.strParameter|escape}</th>
          <th>{$message.strDetail|escape}</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <th><label>{$message.descRecovery_user|escape}</label>
          <br>recovery_user (string)</th>
		  <td>オンラインリカバリを行うための PostgreSQL ユーザ名です。</td>
        </tr>
        <tr>
          <th><label>{$message.descRecovery_password|escape}</label>
          <br>recovery_password (string)</th>
		  <td>オンラインリカバリを行うための PostgreSQL ユーザパスワードです。</td>
        </tr>
        <tr>
          <th><label>{$message.descRecovery_1st_stage_command|escape}</label>
          <br>recovery_1st_stage_command (string)</th>
		  <td>最初にオンラインリカバリ中に起動するコマンド名を
		  指定します。コマンド ファイルはセキュリティ上の観点
		  からデータベースクラスタ以下にあるコマ ンドやスクリ
		  プトのみを呼び出します。 例えば、
		  recovery_1st_stage_command = 'sync-command' と設定し
		  てある場 合、$PGDATA/sync-command を起動しようとしま
		  す。 recovery_1st_stage_command を実行している間は
		  pgpool ではクライアン トからの接続を制限しません。参
		  照や更新を行うことができます。</td>
        </tr>
        <tr>
          <th><label>{$message.descRecovery_2nd_stage_command|escape}</label>
          <br>recovery_2nd_stage_command (string)</th>
		  <td>2 回目のオンラインリカバリ中に起動するコマンド名
		  を指定します。コマン ドファイルはセキュリティ上の観
		  点からデータベースクラスタ以下にあるコ マンドやスク
		  リプトのみを呼び出します。 例えば、
		  recovery_2nd_stage_command = 'sync-command' と設定し
		  てある場 合、$PGDATA/sync-command を起動しようとしま
		  す。 recovery_2nd_stage_command を実行している間は
		  pgpool ではクライアン トから接続、参照、更新処理を一
		  切受け付けません。また、バッチ 処理などによって接続
		  しているクライアントが長時間存在している場合には コ
		  マンドを起動しません。接続を制限し、現在の接続数が 0
		  になった時点 でコマンドを起動します。</td>
        </tr>
        <tr>
          <th><label>{$message.descRecovery_timeout|escape}</label>
          <br>recovery_timeout (integer)</th>
		  <td>オンラインリカバリ処理の最大待ち時間を指定します。0 を指定すると待ち時間無しとなり、リカバリが一瞬で終了しない場合以外は失敗となります。</td>
        </tr>
      </tbody>
      <tfoot>
        <tr>
          <td colspan="2"></td>
        </tr>
      </tfoot>
    </table>
    <h3><a name="system-database">System Database</a></h3>
    <table>
      <thead>
        <tr>
          <th>{$message.strParameter|escape}</th>
          <th>{$message.strDetail|escape}</th>

        </tr>
      </thead>
      <tbody>
        <tr>
          <th><label>{$message.descSystem_db_hostname|escape}</label>
          <br>system_db_hostname (string)</th>
		  <td>システムDBが稼働しているホスト名を指定します。指定しない場合にはUnix domain socketで接続します。</td>
        </tr>

        <tr>
          <th><label>{$message.descSystem_db_port|escape}</label>
          <br>system_db_port (integer)</th>
		  <td>システムDBがあるPostgreSQLに接続するためのポート番号を指定します。</td>
        </tr>
        <tr>
          <th><label>{$message.descSystem_db_dbname|escape}</label>
          <br>system_db_dbname (string)</th>
		  <td>システムDBのデータベース名を指定します。</td>
        </tr>
        <tr>
          <th><label>{$message.descSystem_db_schema|escape}</label>
          <br>system_db_schema (string)</th>
		  <td>システムDBのスキーマを指定します。</td>
        </tr>
        <tr>
          <th><label>{$message.descSystem_db_user|escape}</label>
          <br>system_db_user (string)</th>
		  <td>システムDBに接続するユーザ名を指定します。</td>
        </tr>
        <tr>
          <th><label>{$message.descSystem_db_password|escape}</label>
          <br>system_db_password (string)</th>
		  <td>システムDBに接続するユーザのパスワードを指定します。</td>
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
          <th>{$message.strParameter|escape}</th>
          <th>{$message.strDetail|escape}</th>

        </tr>
      </thead>
      <tbody>
        <tr>
          <th><label>{$message.descLoad_balance_mode|escape}</label>
					<br>load_balance_mode</th>
		  <td>trueを指定するとレプリケーションモードの際に、SELECT文をマスタとセカンダリの間でロードバランスします。デフォルト値はfalseです</td>

		</tr>
        <tr>
          <th><label>{$message.descMaster_slave_mode|escape}</label>
					<br>master_slave_mode</th>
		  <td> trueならばマスタ/スレーブモードでpgpoolを運転します。デフォルトはfalseです。このモードはreplication_modeとは両立しません。</td>
		</tr>
        <tr>

          <th><label>{$message.descInsert_lock|escape}</label>
					<br>insert_lock</th>
		  <td>
SERIAL型を使っているテーブルをレプリケーションすると、SERIAL型の列の値がマスタとセカンダリで一致しなくなることがあります。この問題は、該当テーブルを明示的にロックすることで回避できます(もちろんトランザ
クションの並列実行性は犠牲になりますが)。しかし、そのためには、
<p>
INSERT INTO ...
</p>
<p>
を
</p>
<p>
BEGIN;<br />

LOCK TABLE ...<br />
INSERT INTO ...<br />
COMMIT;
</p>
<p>
   に書き換えなければなりません。insert_lockをtrueにすると自動的にトランザクションの開始、テーブルロック、トランザクションの終了を行ってくれるので、こうした手間を省くことができます（すでにトランザクションが開始されている場合はLOCK TABLE...だけが実行されます）。
		  
		  </td>
		</tr>
        <tr>
          <th><label>{$message.descIgnore_leading_white_space|escape}</label>
					<br>ignore_leading_white_space</th>
		  <td>trueならば、load balanceの際にSQL文行頭の空白を無視します(全角スペースは無視されません)。これは、DBI/DBD:Pgのように、勝手に行頭にホワイトスペースを追加するようなAPIを使い、ロードバランスしたいときに有効です</td>
		</tr>
        <tr>
          <th><label>{$message.descParallel_mode|escape}</label>
					<br>parallel_mode</th>
		  <td>pgpoolをパラレルモードで稼働させる場合にはtrueを指定します。この場合には分散ルールを指定する必要があります。</td>

		</tr>
        <tr>
          <th><label>{$message.descLog_statement|escape}</label>
					<br>log_statement</th>
		  <td>trueならばSQL文をログ出力します。この役目はPostgreSQLのlog_statementオプションと似ていて、デバッグオプションがないときでも問い合わせをログ出力して調べることができるので便利です。</td>
		</tr>
        <tr>

          <th><label>{$message.descEnable_query_cache|escape}</label>
					<br>enable_query_cache</th>
		  <td>SELECTの結果をキャッシュする場合にはtrueにします。</td>
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
