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
  <h3>{$message.strSummary|escape}</h3>
  pgpoolの設定ファイルであるpgpool.confの設定内容を表示・変更することができます。
  <h3>{$message.strFeature|escape}</h3>
  変更したい値を入力して更新ボタンを押してください。<br />
  更新した設定を反映させるには、設定のリロードが必要です。また、[*]が付いている項目は、設定を反映させるために pgpool の再起動が必要となります。
　
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
          <th width="240">{$message.strParameter|escape}</th>
          <th>{$message.strDetail|escape}</th>

        </tr>
      </thead>
      <tbody>
        <tr>
          <th><label>{$message.descListen_addresses|escape}</label>
          <br>listen_addresses (string) *</th>
          <td>TCP/IP コネクションを受け付けるアドレスをホスト名または IP アドレスで指定します。
          「*」を指定するとすべての IP インタフェースからのコネクションを受け付けます。
          「''」を指定すると TCP/IP コネクションを受け付けません。
           UNIX ドメインソケット経由のコネクションは常に受け付けます。
          <br>デフォルト値は localhost です。
          </td>
        </tr>
        <tr>
          <th><label>{$message.descPort|escape}</label>
          <br>port (integer) *</th>
          <td>pgpoolがコネクションを受け付けるポート番号です。
          <br>デフォルト値は 9999 です。
          </td>
        </tr>
        <tr>
          <th><label>{$message.descSocket_dir|escape}</label>
          <br>socket_dir (string) *</th>
          <td>PostgreSQL サーバの Unix domain socket のディレクトリです。
          <br>デフォルト値は '/tmp' です。
          </td>
        </tr>
        <tr>
          <th><label>{$message.descNum_init_children|escape}</label>
          <br>num_init_children (integer) *</th>
          <td>prefork する pgpool のサーバプロセスの数です。
           問い合わせのキャンセルを行うと通常のコネクションとは別に新たなコネクションが張られます。
           従って、全てのコネクションが使用中の場合は問い合わせのキャンセルができなくってしまうので、ご注意下さい。
           問い合わせのキャンセルを必ず保証したい場合は、想定されるコネクション数の倍の値を設定することをおすすめします。
           <br>デフォルト値は 32 です。
          </td>
        </tr>
        <tr>
          <th><label>{$message.descMax_pool|escape}</label>
          <br>max_pool (integer) *</th>
          <td>pgpool の各サーバプロセスがキープする PostgreSQL への最大コネクション数です。
           pgpool は、ユーザ名、データベースが同じならばコネクションを再利用しますが、
           そうでなければ、新たに PostgreSQL へのコネクションを確立しようとします。
           従って、ここでは想定される [ユーザ名:データベース名] のペアの種類の数だけを max_pool に指定しておく必要があります。
           もし max_pool を使いきってしまった場合は一番古いコネクションを切断し、そのスロットが再利用されます。
           <br>なお、pgpool全体としては、num_init_children * max_pool 分だけ PostgreSQL へのコネクションが張られる点に注意してください。
           <br>デフォルト値は 4 です。
          </td>
        </tr>
        <tr>
          <th><label>{$message.descChild_life_time|escape}</label>
          <br>child_life_time (integer)</th>
          <td>pgpool の子プロセスの寿命です。
           アイドル状態になってから child_life_time 秒経過すると、一旦終了して新しいプロセスを起動します。
           メモリーリークその他の障害に備えた予防措置です。
           なお、まだ一度もコネクションを受け付けていないプロセスには child_life_time は適用されません。
           <br>デフォルト値は 300秒（5分）です。0を指定するとこの機能は動作しません。
          </td>
        </tr>
        <tr>
          <th><label>{$message.descConnection_life_time|escape}</label>
          <br>connection_life_time (integer)</th>
          <td>コネクションプール中のコネクションの有効期間を秒単位で指定します。
           <br>デフォルト値は 0 です。0を指定すると有効期間は無限になります。
          </td>
        </tr>
        <tr>
          <th><label>{$message.descChild_max_connections|escape}</label>
          <br>child_max_connections (integer)</th>
          <td>各 pgpool 子プロセスへの接続回数がこの設定値を超えると、その子プロセスを終了します。
           child_life_time や connection_life_time が効かないくらい忙しいサーバで、
           PostgreSQL バックエンドが肥大化するのを防ぐのに有効です。
           <br>デフォルト値は 0(無効) です。
          </td>
        </tr>
        <tr>
          <th><label>{$message.descClient_idle_limit|escape}</label>
          <br>client_idle_limit (integer)</th>
          <td>前回クライアントから来たクエリから、client_idle_limit 秒越えても次のクエリが届かない場合は、
           クライアントへの接続を強制的に切断し、クライアントからの次のコネクションを待つようにします。
          <br>デフォルト値は 0(無効) です。
          </td>
        </tr>
        <tr>
          <th><label>{$message.descAuthentication_timeout|escape}</label>
          <br>authentication_timeout (integer)</th>
          <td>認証処理のタイムアウト時間を秒単位で指定します。
           <br>デフォルト値は 60 です。0 を指定するとタイムアウトを無効にします。
          </td>
        </tr>
        <tr>
          <th><label>{$message.descConnection_cache|escape}</label>
		<br>connection_cache (bool) *</th>
          <td>true の時にコネクションをキャッシュします。
           <br>デフォルトは true です。
          </td>
        </tr>
        <tr>
          <th><label>{$message.descPgpool2_hostname|escape}</label>
          <br>pgpool2_hostname (string) *</th>
          <td>pgpool2 が稼働しているホスト名を指定します。
           <br>デフォルトでは設定されていません。
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
          <th><label>{$message.descBackend_socket_dir|escape}</label>
          <br>backend_socket_dir (string) *</th>
          <td>PostgreSQL サーバの Unix domain socket のディレクトリです。
           <br>デフォルト値は'/tmp'です。</td>
        </tr>
        <tr>
	  <th><label>{$message.descBackend_hostname|escape}</label>
          <br>backend_hostname (string)</th>
	  <td>postmaster が稼働しているホスト名を指定します。指定しない場合には Unix domain socket で接続します。
          </td>
        </tr>
	<tr>
          <th><label>{$message.descBackend_port|escape}</label>
          <br>backend_port (integer)</th>
		<td>postmasterが稼働しているポート番号です。</td>
        </tr>
        <tr>
          <th><label>{$message.descBackend_weight|escape}</label>
          <br>backend_weight (integer)</th>
          <td>ロードバランスモード時に振り分ける重みを0から1の値で設定します。
           すべてのバックエンドサーバで指定した値から相対的な重みを計算して振り分けます。</td>
        </tr>
        <tr>
          <th><label>{$message.descBackend_data_directory|escape}</label>
          <br>backend_data_directory (string)</th>
         <td>使用する PostgreSQL サーバのデータベースクラスタのパスを指定します。
         実際には、"backend_data_directory" の後にDBノードIDを付加して使用する複数の PostgreSQL を区別します。
         このパラメータはオンラインリカバリの際に使用します。
         オンラインリカバリを使用しない場合には設定する必要はありません。</td>
        </tr>
      </tbody>
      <tfoot>
        <tr>
          <td colspan="2"></td>
        </tr>
      </tfoot>
    </table>

    <h3><a name="pcp">PCP (pgpool Control Port)</a></h3>
    <table>
      <thead>
        <tr>
          <th width="240">{$message.strParameter|escape}</th>

          <th>{$message.strDetail|escape}</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <th><label>{$message.descPcp_port|escape}</label>
          <br>pcp_port (integer) *</th>
          <td>PCP に接続するためのポート番号です。
          <br>デフォルトは9898です。</td>
        </tr>
        <tr>
          <th><label>{$message.descPcp_socket_dir|escape}</label>
          <br>pcp_socket_dir (string) *</th>
          <td>PCP の Unix domain socket のディレクトリを指定します。
          <br>デフォルト値は'/tmp'です。</td>
        </tr>
        <tr>
          <th><label>{$message.descPcp_timeout|escape}</label>
          <br>pcp_timeout (integer) *</th>
          <td>PCPコマンドのタイムアウトを設定します。
           この時間の間に応答がない場合にはコネクションを切断します。
           <br>デフォルトは10です。</td>
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
          <th width="240">{$message.strParameter|escape}</th>
          <th>{$message.strDetail|escape}</th>
        </tr>
      </thead>
      <tbody>

        <tr>
          <th><label>{$message.descLogdir|escape}</label>
          <br>logdir (string) *</th>
          <td>pgpoolの各種ログファイルを格納するディレクトリです。
          <br>デフォルト値は'/tmp'です。</td>
        </tr>

        <tr>
          <th><label>{$message.descPid_file_name|escape}</label>
          <br>pid_file_name (string) *</th>
          <td>pgpoolのpidファイルの名前(パス名)です。
          <br>デフォルト値は'/var/run/pgpool/pgpool.pid'です。</td>
        </tr>

        <tr>
          <th><label>{$message.descPrint_timestamp|escape}</label>
	  <br>print_timestamp *</th>
          <td>true ならば pgpool のログにタイムスタンプを追加します。
          <br>デフォルトは true です。</td>
	</tr>

        <tr>
          <th><label>{$message.descLog_statement|escape}</label>
	  <br>log_statement</th>
	  <td>true の時、SQL 文をログ出力します。
           この役目は PostgreSQL の log_statement オプションと似ており、
           デバッグオプションがないときでも問い合わせをログ出力して調べることができるので便利です。
          <br>デフォルト値は false です。
          </td>
	</tr>

        <tr>
          <th><label>{$message.descLog_per_node_statement|escape}</label>
	  <br>log_per_node_statement</th>
	  <td>   log_statementと似ていますが、DBノード単位でログが出力されるので、レプリケーションや負荷分散の確認が容易です。
          <br>デフォルト値は false です。
          </td>
	</tr>

        <tr>
          <th><label>{$message.descLog_connections|escape}</label>
	  <br>log_connections</th>
	  <td>true の時、クライアントから受信した接続ごとにログを出力します。
           <br>デフォルト値は false です。
          </td>
	</tr>
        <tr>
          <th><label>{$message.descLog_hostname|escape}</label>
	  <br>log_hostname</th>
	  <td>true の時、クライアントのホスト名を "ps" コマンドの結果に出力します。
           また log_connections が有効になっている場合、クライアントから受信した接続のログと一緒にホスト名も出力されます。
           ただしホスト名の探索には負荷がかかりますので、有効にする場合には注意してください。
          <br>デフォルト値は false です。
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
          <th><label>{$message.descReplication_mode|escape}</label>
	  <br>replication_mode *</th>
	  <td>レプリケーションモードで動作させる場合は true を指定してください。
          <br>デフォルト値は false です。</td>
        </tr>
        <tr>
          <th><label>{$message.descReplication_timeout|escape}</label>
          <br>replication_timeout (integer)</th>
	  <td>デットロックを監視するためのタイムアウト時間をミリ秒単位で指定します。
          <br>デフォルト値は 5000 (5秒)です。</td>
       </tr>

        <tr>
          <th><label>{$message.descReplication_stop_on_mismatch|escape}</label>
		  <br>replication_stop_on_mismatch</th>
	  <td>true の場合、マスタとセカンダリの間で、データの不一致があった場合に強制的に縮退運転に入ります。
           false の場合には、該当の問い合わせを強制的に終了するだけに留めます。
          <br>デフォルト値は false です。</td>
	</tr>

        <tr>
          <th><label>{$message.descFail_over_on_backend_error|escape}</label>
		  <br>fail_over_on_backend_error</th>
	  <td>trueならば、バックエンドのソケットへの書き込みに失敗するとフェイルオーバします。
   これはpgpool-II 2.2.xまでの挙動と同じです。
falseにすると、フェイルオーバせず、単にエラーがレポートされてセッションが切断されます。
このパラメータをfalseにする場合には、health checkを有効にすることをお勧めします。
なお、このパラメータがfalseの場合でも、クライアントがpgpoolに接続する際にバックエンドへの接続に失敗した場合、あるいはバックエンドがシャットダウンされたことをpgpool-IIが検知した場合にはフェイルオーバが起きることに注意してください。
このパラメータを変更した時には設定ファイルを再読み込みしてください。
          <br>デフォルト値は true です。</td>
	</tr>

        <tr>
          <th><label>{$message.descReplicate_select|escape}</label>
          <br>replicate_select</th>
	  <td>true 場合に設定するとロードバランスされない SELECT 文をレプリケーションさせます。
          <br>デフォルト値は false です。</td>
	</tr>
        <tr>
          <th><label>{$message.descReset_query_list|escape}</label>
          <br>reset_query_list (string)</th>
	  <td>セッションが終了するときにコネクションを初期化するための SQL コマンドを「;」で区切って列挙します。
          <br>デフォルト値は以下のようになっていますが、任意の SQL文を追加しても構いません。
	  <p>reset_query_list = 'ABORT; DISCARD ALL'</p>
           PostgreSQL のバージョンによって使用できる SQLコマンドが違うので、
           PostgreSQL 7.3 以前では注意してください(「4. pgpoolの稼働環境」参照)。
           <br>なお、「ABORT」は、PostgreSQL 7.4以上ではトランザクションブロックの中にいない場合には発行されません。
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
          <th width="240">{$message.strParameter|escape}</th>
          <th>{$message.strDetail|escape}</th>
        </tr>
      </thead>
      <tbody>

        <tr>
          <th><label>{$message.descHealth_check_timeout|escape}</label>
          <br>health_check_timeout (integer)</th>
          <td> pgpool はサーバ障害やネットワーク障害を検知するために、定期的にバックエンドに接続を試みます。
           これを「ヘルスチェック」と言います。障害が検知されると、フェイルオーバや縮退運転を試みます。
          <br>このパラメータは、ネットワークケーブルが抜けた際などにヘルスチェックが長時間待たされるのを
           防ぐためのタイムアウト値を秒単位で指定します。
          <br>なお、ヘルスチェックを有効にすると、ヘルスチェックのための余分の接続が1つ必要になりますので、
           PostgreSQL の postgresql.conf の設定項目の max_connections を少くとも1増やすようにしてください。
          <br>デフォルト値は20秒です。0を指定するとタイムアウト処理をしません。
          </td>
        </tr>
        <tr>
          <th><label>{$message.descHealth_check_period|escape}</label>
          <br>health_check_period (integer)</th>
	  <td>ヘルスチェックを行う間隔を秒単位で指定します。0を指定するとヘルスチェックを行いません。
          <br>デフォルト値は0です。
          </td>
       </tr>
        <tr>
          <th><label>{$message.descHealth_check_user|escape}</label>
          <br>health_check_user (string)</th>
	  <td>ヘルスチェックを行うための PostgreSQL ユーザ名です。
          <br>デフォルト値は 'nobody' です。
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
          <th><label>{$message.descRecovery_user|escape}</label>
          <br>recovery_user (string)</th>
	  <td>オンラインリカバリを行うための PostgreSQL ユーザ名です。
          <br>デフォルト値は 'nobody' です。</td>
        </tr>
        <tr>
          <th><label>{$message.descRecovery_password|escape}</label>
          <br>recovery_password (string)</th>
	  <td>オンラインリカバリを行うための PostgreSQL ユーザパスワードです。
          <br>デフォルト値は設定されていません。</td>
       </tr>
        <tr>
          <th><label>{$message.descRecovery_1st_stage_command|escape}</label>
          <br>recovery_1st_stage_command (string)</th>
          <td>最初にオンラインリカバリ中に起動するコマンド名を指定します。
           コマンドファイルはセキュリティ上の観点からデータベースクラスタ以下にあるコマンドや
           スクリプトのみを呼び出します。
          <br>例えば、<p>recovery_1st_stage_command = 'sync-command'</p>と設定してある場合、
           $PGDATA/sync-command を起動しようとします。
           recovery_1st_stage_command を実行している間は pgpool ではクライアントからの接続を制限しません。
           参照や更新を行うことができます。
          <br>デフォルト値は設定されていません。</td>
        </tr>
        <tr>
          <th><label>{$message.descRecovery_2nd_stage_command|escape}</label>
          <br>recovery_2nd_stage_command (string)</th>
	  <td>2 回目のオンラインリカバリ中に起動するコマンド名を指定します。
           コマンドファイルはセキュリティ上の観点からデータベースクラスタ以下にあるコマンドや
           スクリプトのみを呼び出します。 
          <br>例えば、<p>recovery_2nd_stage_command = 'sync-command'</p>と設定してある場合、
           $PGDATA/sync-command を起動しようとします。 
           recovery_2nd_stage_command を実行している間は pgpool ではクライアントから接続、参照、
           更新処理を一切受け付けません。
           また、バッチ処理などによって接続しているクライアントが長時間存在している場合にはコマンドを起動しません。
           接続を制限し、現在の接続数が 0 になった時点でコマンドを起動します。
          <br>デフォルト値は設定されていません。</td>
        </tr>
        <tr>
          <th><label>{$message.descRecovery_timeout|escape}</label>
          <br>recovery_timeout (integer)</th>
	  <td>オンラインリカバリ処理の最大待ち時間を指定します。
           0 を指定すると待ち時間無しとなり、リカバリが一瞬で終了しない場合以外は失敗となります。
          <br>デフォルト値は 90 です。</td>
        </tr>

        <tr>
          <th><label>{$message.descClient_idle_limit_in_recovery|escape}</label>
          <br>client_idle_limit_in_recovery (integer)</th>
          <td>前回クライアントから来たクエリから、client_idle_limit_in_recovery 秒越えても次のクエリが届かない場合は、
           クライアントへの接続を強制的に切断し、クライアントからの次のコネクションを待つようにします。
          <br>デフォルト値は 0(無効) です。このパラメータはオンラインリカバリ中のみ有効です。
          </td>
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
          <th width="240">{$message.strParameter|escape}</th>
          <th>{$message.strDetail|escape}</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <th><label>{$message.descSystem_db_hostname|escape}</label>
          <br>system_db_hostname (string) *</th>
	  <td>システム DB が稼働しているホスト名を指定します。
          指定しない場合には Unix domain socket で接続します。
          <br>デフォルト値は localhost です。</td>
        </tr>
        <tr>
          <th><label>{$message.descSystem_db_port|escape}</label>
          <br>system_db_port (integer) *</th>
          <td>システム DB がある PostgreSQL に接続するためのポート番号を指定します。
          <br>デフォルト値は 5432 です。</td>
        </tr>
        <tr>
          <th><label>{$message.descSystem_db_dbname|escape}</label>
          <br>system_db_dbname (string) *</th>
	  <td>システムDBのデータベース名を指定します。
          <br>デフォルト値は pgpool です。</td>
        </tr>
        <tr>
          <th><label>{$message.descSystem_db_schema|escape}</label>
          <br>system_db_schema (string) *</th>
          <td>システムDBのスキーマを指定します。
          <br>デフォルト値は pgpool_catelog です。</td>
        </tr>
        <tr>
          <th><label>{$message.descSystem_db_user|escape}</label>
          <br>system_db_user (string) *</th>
	  <td>システムDBに接続するユーザ名を指定します。
          <br>デフォルト値は pgpool です。</td>
        </tr>
        <tr>
          <th><label>{$message.descSystem_db_password|escape}</label>
          <br>system_db_password (string) *</th>
	  <td>システムDBに接続するユーザのパスワードを指定します。
          <br>デフォルト値は設定されていません。</td>
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
          <th><label>{$message.descLoad_balance_mode|escape}</label>
          <br>load_balance_mode *</th>
          <td>レプリケーションモードの際に、SELECT 文をマスタとセカンダリの間でロードバランスします。
          <br>デフォルト値は false です。</td>
	</tr>
        <tr>
          <th><label>{$message.descMaster_slave_mode|escape}</label>
          <br>master_slave_mode *</th>
          <td>true ならばマスタ/スレーブモードで pgpool を運転します。このモードは replication_mode とは両立できません。
          <br>デフォルトは false です。</td>
	</tr>
        <tr>
          <th><label>{$message.descInsert_lock|escape}</label>
          <br>insert_lock</th>
	  <td>SERIAL 型を使っているテーブルをレプリケーションすると、SERIAL 型の列の値がマスタとセカンダリで
           一致しなくなることがあります。この問題は、該当テーブルを明示的にロックすることで回避できます。
           (その場合、トランザクションの並列実行性は犠牲になります。)
          <br>しかし、そのためには、<p>INSERT INTO ...</p> を <p>BEGIN;<br>LOCK TABLE ...<br>INSERT INTO ...<br>COMMIT;</p>
           に書き換えなければなりません。
          <br>insert_lock を true にすると自動的にトランザクションの開始、テーブルロック、トランザクションの終了を
           行ってくれるので、こうした手間を省くことができます。
          （すでにトランザクションが開始されている場合は LOCK TABLE... だけが実行されます。）
          <br>デフォルト値は false です。</td>
	</tr>
        <tr>
          <th><label>{$message.descIgnore_leading_white_space|escape}</label>
	  <br>ignore_leading_white_space</th>
	  <td>true ならば、load balance の際にSQL文行頭の空白を無視します(全角スペースは無視されません)。
           これは、DBI/DBD:Pg のように、勝手に行頭にホワイトスペースを追加するような API を使い、
           ロードバランスしたいときに有効です。
          <br>デフォルト値は true です。</td>
        </tr>
        <tr>
          <th><label>{$message.descParallel_mode|escape}</label>
	  <br>parallel_mode *</th>
	  <td>pgpool をパラレルモードで稼働させる場合には true を指定します。
           この場合には分散ルールを指定する必要があります。
          <br>デフォルト値は false です。</td>
	</tr>
        <tr>
          <th><label>{$message.descEnable_query_cache|escape}</label>
	  <br>enable_query_cache *</th>
	  <td>SELECT の結果をキャッシュする場合には true にします。
          <br>デフォルト値は false です。</td>
	</tr>
        <tr>
          <th><label>{$message.descEnable_pool_hba|escape}</label>
	  <br>enable_pool_hba</th>
	  <td>pool_hba.conf を使ったクライアント認証機能を有効にする場合には true にします。
          <br>デフォルト値は false です。</td>
	</tr>
        <tr>
          <th><label>{$message.descFailover_command|escape}</label>
	  <br>failover_command</th>
	  <td>ここで指定したコマンドは、ノードが切り離された際に自動的に実行されます。例えば、主系の異常を検出した際に待機系の起動を自動で行う際などに利用できます。
          <br>特殊文字を指定すると、pgpool が必要な情報に置き換えてコマンドを実行します。 
          <br>　%d: 切り離されたノード番号
          <br>　%h: 切り離されたノードのホスト名
          <br>　%p: 切り離されたノードのポート番号
          <br>　%D: 切り離されたノードのデータベースクラスタパス
          <br>　%%: '％'文字
          <br>デフォルトでは設定されていません。</td>
	</tr>
        <tr>
          <th><label>{$message.descFailback_command|escape}</label>
	  <br>failback_command</th>
	  <td>ここで指定したコマンドは、ノードが復帰した際に自動的に実行されます。例えば、主系の復帰を自動で待機系に伝える際などに利用できます。
          <br>特殊文字を指定すると、pgpool が必要な情報に置き換えてコマンドを実行します。 
          <br>　%d: 復帰したノード番号
          <br>　%h: 復帰したノードのホスト名
          <br>　%p: 復帰したノードのポート番号
          <br>　%D: 復帰したノードのデータベースクラスタパス
          <br>　%%: '％'文字
          <br>デフォルトでは設定されていません。</td>
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
