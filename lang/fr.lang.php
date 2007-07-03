<?php

/* vim: set expandtab tabstop=4 shiftwidth=4 softtabstop=4: */

/**
 * Message catalog in English
 *
 * PHP versions 4 and 5
 *
 * LICENSE: Permission to use, copy, modify, and distribute this software and
 * its documentation for any purpose and without fee is hereby
 * granted, provided that the above copyright notice appear in all
 * copies and that both that copyright notice and this permission
 * notice appear in supporting documentation, and that the name of the
 * author not be used in advertising or publicity pertaining to
 * distribution of the software without specific, written prior
 * permission. The author makes no representations about the
 * suitability of this software for any purpose.  It is provided "as
 * is" without express or implied warranty.
 *
 * @author     Ryuma Ando <ando@ecomas.co.jp>
 * @copyright  2003-2007 PgPool Global Development Group
 * @version    CVS: $Id$
 */

$message = array(
    'lang' => 'fr',
    'strLang' => 'Fran�ais',
    'descBackend_hostname' => 'Le nom du vrai serveur PostgreSQL sur lequel pgpool va se connecter',
    'descBackend_port' => 'Le num�ro de port du vrai serveur PostgreSQL',
    'descBackend_socket_dir' => 'Le r�pertoire du socket de PostgreSQL',
    'descBackend_weight' => 'Poids de la r�partition de charge quand pgpool est dans ce mode',
    'descChild_life_time' => 'Dur�e de vie d\'un processus enfant en secondes',
    'descChild_max_connections' => 'Si child_max_connections connexions ont �t� re�ues, l\'enfant quitte',
    'descConnection_cache' => 'Si vrai, met en cache les connexions vers PostgreSQL',
    'descConnection_life_time' => 'Dur�e de vie de chaque connexion inutilis�e en secondes',
    'descEnable_query_cache' => 'Mettre en place un cache des requ�tes',
    'descHealth_check_period' => 'Sp�cifie l\'interval de la prochaine v�rification du serveur. 0 correspond � une d�sactivation de la v�rification.',
    'descHealth_check_timeout' => 'Pgpool v�rifie p�riodiquement l\'�tat des serveurs pour d�tecter les serveurs injoignables, parce que arr�ter ou � cause d\'un probl�me r�seau',
    'descHealth_check_user' => 'Nom de l\'utilisateur PostgreSQL pour la v�rification de l\'�tat',
    'descIgnore_leading_white_space' => 'Si vrai, ignore les espaces blancs en d�but de chaque requ�te quand pgpool v�rifie si la requ�te est un SELECT pour utiliser la r�partition de charge',
    'descInsert_lock' => ' Si vous r�pliquez une table poss�dant une colonne de type SERIAL, quelque fois, la valeur de serial ne sera pas identique parmi les serveurs',
    'descListen_addresses' => 'Sp�cifie les adresses � �couter pour les connexions TCP/IP',
    'descLoad_balance_mode' => 'R�alise une r�partition de charge pour les requ�tes SELECT',
    'descLog_statement' => 'Si vrai, trace toutes les requ�tes dans les journaux',
    'descLogdir' => 'Le nom du r�pertoire o� stocker les journaux de pgpool',
    'descMaster_slave_mode' => 'Ex�cuter le mode ma�tre/esclave',
    'descMax_pool' => 'Nombre de groupes de connexions que chaque processus serveur pgpool conserve',
    'descNum_init_children' => 'Nombre de processus pgpool ex�cut�s au d�marrage',
    'descParallel_mode' => 'Ex�cuter en mode parall�le',
    'descPcp_port' => 'Le num�ro du port de pcp',
    'descPcp_socket_dir' => 'Le r�pertoire du socket de connexion de pcp',
    'descPcp_timeout' => 'Si le d�lai expire sans r�ponse du client, il se d�connecte et s\'arr�te',
    'descPgpool2_hostname' => 'Nom du serveur Pgpool2 lors de son ex�cution',
    'descPort' => 'Num�ro de port de pgpool',
    'descPrint_timestamp' => 'Si vrai, une date est ajout�e au d�but de chaque ligne de traces',
    'descReplication_mode' => 'Configurer ceci � vrai (true) si vous voulez utiliser la r�plication',
    'descReplication_stop_on_mismatch' => 'Stopper le mode r�plication en as de diff�rence de donn�es entre le ma�tre et l\'esclave',
    'descReplication_strict' => 'Si vrai, pgpool attendra la fin de la requ�te sur le ma�tre avant d\'envoyer une requ�te sur le serveur secondaire',
    'descReplication_timeout' => 'Dans le mode de r�plication non strict, il y un risque de verrou mortel',
    'descReset_query_list' => 'Commandes SQL s�par�es par des points-virgules � ex�cuter � la fin de la session',
    'descSocket_dir' => 'Le r�pertoire socket de connexion de pgpool',
    'descSystem_db_dbname' => 'Le nom de la base de donn�es syst�me',
    'descSystem_db_hostname' => 'Nom du serveur du syst�me de bases de donn�es',
    'descSystem_db_password' => 'Mot de passe pour se connecter au syst�me de bases de donn�es',
    'descSystem_db_port' => 'Num�ro de port du serveur du syst�me de bases de donn�es',
    'descSystem_db_schema' => 'Nom du sch�ma de la base de donn�es syst�me',
    'descSystem_db_user' => 'Nom de l\'utilisateur pour se connecter au syst�me de bases de donn�es',
    'errAlreadyExist' => 'Il existe d�j�.',
    'errFileNotExecutable' => 'Le fichier n\'est pas ex�cutable',
    'errFileNotFound' => 'Fichier introuvable',
    'errFileNotWritable' => 'Le fichier ne peut �tre �crit',
    'errIllegalHostname' => 'Nom d\'h�te ill�gal',
    'errInputEverything' => 'Merci de saisir tous les �l�ments',
    'errNoDefined' => 'Pas de param�tre d�fini',
    'errNotSameLength' => 'La longueur du tableau col_list ne correspond pas � celle de type_list. Vous devriez avoir le m�me nombre d\'�l�ments.',
    'errPasswordMismatch' => 'Les mots de passe ne correspondent pas',
    'errRequired' => 'Ceci est requis',
    'errShouldBeInteger' => 'Cet �l�ment devrait �tre un entier',
    'errShouldBeZeroOrMore' => 'Cet �l�ment devrait �tre positif ou nul',
    'errSingleQuotation' => 'Merci de placer l\'�l�ment tableau dans des guillemets simples.',
    'msgDeleteConfirm' => 'Voulez-vous vraiment le supprimer ?',
    'msgMasterDbConnectionError' => '�chec de la connexion au ma�tre',
    'msgPgpoolConfNotFound' => 'pgpool.conf introuvable',
    'msgPleaseSetup' => 'Aucun fichier de configuration. Merci de commencer par la configuration.',
    'msgRestart' => 'Red�marrer pour que les changements soient pris en compte',
    'msgRestartPgpool' => 'Voulez-vous red�marrer pgpool ?',
    'msgSameAsPasswordFile' => 'Valeur identique � celle du fichier de mots de passe',
    'msgSameAsPgpoolFile' => 'Valeur identique � celle du fichier pgpool.conf',
    'msgStopPgpool' => 'Voulez-vous vraiment arr�ter pgpool ?',
    'msgUpdateComplete' => 'Mise � jour termin�e',
    'msgUpdateFailed' => '�chec de la mise � jour',
    'strAdd' => 'Ajouter',
    'strAdminPassword' => 'Mot de passe',
    'strBack' => 'Retour',
    'strCancel' => 'Annuler',
    'strChangePassword' => 'Modifier le mot de passe',
    'strClear' => 'Effacer',
    'strClearQueryCache' => 'Effacer le cache des requ�tes',
    'strCmdC' => 'Efface le cache des requ�tes',
    'strCmdD' => 'Mode debug',
    'strCmdDesc' => 'Si c\'est un blanc, cette option est ignor�e.',
    'strCmdM' => 'Mode stop',
    'strCmdN' => 'Ne pas ex�cuter en mode d�mon',
    'strCmdPcpFile' => 'pcp.conf',
    'strCmdPgpoolFile' => 'pgpool.conf',
    'strColList' => 'Liste de colonnes',
    'strColName' => 'Nom de la colonne de la cl� distribu�e',
    'strCommon' => 'Commun',
    'strConnectionError' => 'Erreur de connexion',
    'strConnTime' => 'Date de d�but de la connexion',
    'strConnUsed' => 'Utilisation de la connexion',
    'strConnUser' => 'utilisateur',
    'strCreateTime' => 'Heure de cr�ation',
    'strDataError' => 'Erreur de donn�es',
    'strDateFormat' => 'd/m/Y, H:i:s',
    'strDb' => 'Base de donn�es',
    'strDbName' => 'Nom de la base',
    'strDebug' => 'Mode debug',
    'strDelete' => 'Supprimer',
    'strDeleted' => 'lignes ont �t� supprim�es',
    'strDetail' => 'D�tail',
    'strDetailInfo' => 'Informations d�tail',
    'strDisconnect' => 'D�connexion',
    'strDistDefFunc'=> 'Nom de fonction distribu�',
    'strDown' => 'Bas',
    'strError' => 'Erreur',
    'strErrorCode' => 'Code d\'erreur',
    'strErrorMessage' => 'Message d\'erreur',
    'strExecute' => 'Ex�cuter',
    'strFeature' => 'Fonctionnalit�',
    'strHealthCheck' => 'V�rification',
    'strHelp' => 'Aide',
    'strInvalidation' => 'Invalidation',
    'strIPaddress' => 'Adresse IP',
    'strLanguage' => 'Langue',
    'strLoadBalanceMode' => 'Mode de r�partition de charge',
    'strLog' => 'Se connecter',
    'strLogin' => 'Connexion',
    'strLoginName' => 'Nom de connexion',
    'strLogout' => 'D�connexion',
    'strMasterServer' => 'Serveur ma�tre',
    'strMeasures' => 'Mesures',
    'strNodeInfo' => 'Info. sur le noeud',
    'strNodeStatus' => 'Statut du noeud',
    'strNodeStatus1' => 'Haut. D�connexion',
    'strNodeStatus2' => 'Haut. Connexion',
    'strNodeStatus3' => 'Bas',
    'strNoNode' => 'Il n\'y a pas de noeud',
    'strOff' => 'Arr�t�',
    'strOn' => 'D�marr�',
    'strParallelMode' => 'Mode parall�le',
    'strParameter' => 'Param�tre',
    'strPassword' => 'Mot de passe',
    'strPasswordConfirmation' => 'Confirmation du mot de passe',
    'strPasswordFile' => 'Fichier des mots de passe',
    'strPcpConfFile' => 'Fichier pcp.conf',
    'strPcpDir' => 'R�pertoire de PCP',
    'strPcpHostName' => 'Nom d\'h�te de PCP',
    'strPcpRefreshTime' => 'Temps de rafra�chissement',
    'strPcpTimeout' => 'D�lai de PCP',
    'strPgConfFile' => 'Fichier pgpool.conf',
    'strPgConfSetting' => 'Configuration de pgpool.conf',
    'strPgpool' => 'pgpool',
    'strPgpool1' => 'pgpool-I',
    'strPgpool2' => 'pgpool-II',
    'strPgpoolCommand' => 'Commande pgpool',
    'strPgpoolCommandOption' => 'Options de la commande pgpool',
    'strPgpoolLogFile' => 'Journal pgpool',
    'strPgpoolManagementSystem' => 'Syst�me de gestion de pgpool-II',
    'strPgpoolServer' => 'Serveur pgpool-II',
    'strPgpoolStatus' => 'Statut de pgpool',    
    'strPgpoolSummary' => 'R�sum�',
    'strPleaseWait' => 'Un instant...',
    'strPort' => 'Port',
    'strProcId' => 'Processus',
    'strProcInfo' => 'Info. processus',
    'strProcTime' => 'D�but d\'ex�cution du processus',
    'strProtocolMajorVersion' => 'Version majeure du protocole',
    'strProtocolNinorVersion' => 'Version mineure du protocole',
    'strQueryCache' => 'Cache des requ�tes',
    'strQueryStr' => 'Requ�tes',
    'strReplicationMode' => 'Mode r�plication',
    'strReset' => 'R�initialiser',
    'strRestart' => 'Red�marrer',
    'strRestartOption' => 'Options de red�marrage de pgpool',
    'strRestartPgpool' => 'Red�marrer pgpool',
    'strReturn' => 'Renvoyer',
    'strSchemaName' => 'Nom du sch�ma',
    'strSearch' => 'Rechercher',
    'strSecondaryServer' => 'Serveur secondaire',
    'strSetting' => 'Configuration de pgpoolAdmin',
    'strSetup' => 'Configuration',
    'strStartOption' => 'Options de d�marrage',
    'strStartPgpool' => 'Ex�cuter pgpool',
    'strStatus' => 'Statut',
    'strStopOption' => 'Options d\'arr�t de pgpool',
    'strStopPgpool' => 'pgpool est stopp�',
    'strSummary' => 'R�sum�',
    'strSystemDb' => 'R�gle de partitionnement',
    'strTable' => 'Table',
    'strTypeList' => 'Saisir la liste des colonnes',
    'strUp' => 'Haut',
    'strUpdate' => 'Mettre � jour',
    'strValue' => 'Valeur',
    'strWeight' => 'Poids',
    'e1' => 'pgmgt.conf.php est introuvable.',
    'e2' => 'Le catalogue des messages est introuvable.',
    'e3' => 'Un erreur est survenue lors de l\'ex�cution de la commande PCP.',
    'e4' => 'pgpool.conf introuvable.',
    'e5' => 'Fichier mod�le de Smarty introuvable.',
    'e6' => 'Aide introuvable.',
    'e8' => 'pcp_timeout introuvable dans pgpool.conf',
    'e9' => 'pcp_timeout introuvable dans pgpool.conf',
    'e7' => 'Param�tre introuvable dans pgpmgt.conf.php',
    'e1001' => 'Erreur de la commande PCP.',
    'e1002' => 'Erreur de la commande pcp_node_count.',
    'e1003' => 'Erreur de la commande pcp_node_info.',
    'e1004' => 'Erreur de la commande pcp_proc_count.',
    'e1005' => 'Erreur de la commande pcp_proc_info.',
    'e1006' => 'Erreur de la commande pcp_stop_pgpool.',
    'e1007' => 'Erreur de la commande pcp_detach_node.',
    'e1008' => 'pgpool.conf inexistant.',
    'e1009' => 'pcp.conf inexistant.',
    'e1010' => 'Erreur de la commande pcp_attach_node.',
    'e1011' => 'Journal inexistant.',
    'e2001' => 'Erreur de connexion � la base de donn�es.',
    'e2002' => 'L\'erreur est survenue lors de l\'ex�cution de la commande SELECT',
    'e2003' => 'pgpool.conf inexistant.',
    'e3001' => 'Erreur de connexion � la base de donn�es.',
    'e3002' => 'L\'erreur est survenue lors de l\'ex�cution de la commande SELECT',
    'e3003' => 'L\'erreur est survenue lors de l\'ex�cution de la commande INSERT',
    'e3004' => 'L\'erreur est survenue lors de l\'ex�cution de la commande UPDATE',
    'e3005' => 'L\'erreur est survenue lors de l\'ex�cution de la commande DELETE',
    'e3006' => 'pgpool.conf inexistant.',
    'e4001' => 'pgpool.conf inexistant.',
    'e4002' => 'Impossible de lire pgpool.conf. ',
    'e4003' => 'Impossible d\'�crire dans pgpool.conf. ',
    'e5001' => 'pgmgt.conf.php inexistant.',
    'e5002' => 'Impossible de lire pgmgt.conf.php.',
    'e5003' => 'Impossible d\'�crire dans pgmgt.conf.php.',
    'e6001' => 'pcp.conf inexistant',
    'e6002' => 'Impossible de lire pcp.conf. ',
    'e6003' => 'Impossible d\'�crire dans pcp.conf. ',
    'e7001' => 'pcp.conf inexistant.',
    'e8001' => 'Impossible de r�cup�rer des informations d�taill�es.',
    
);

?>
