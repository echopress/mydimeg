<cfparam name="Q_QUERY" default="" >

<cfparam name="Q_NOME_FORM" default="" >
<cfparam name="Q_V_TEMP_TOT" default="" >




<!---<cfparam name="first" default="1">

<cfparam name="Q_ID" default="">

<cfparam name="Q_CURR_FOLDER" default="">
<cfparam name="Q_START_FOLDER" default="">
<cfparam name="Q_NAV_FOLDER" default="">

<cfparam name="QF_COGNOME" default="">
<cfparam name="QF_NOME" default="">
<cfparam name="QF_TELEFONO" default="">

<cfparam name="Q_COMUNE" default="">
<cfparam name="Q_CAP" default="">
<cfparam name="Q_PROV" default="">
<cfparam name="Q_NAZ" default="">

<cfparam name="QO_BY" default="">
<cfparam name="QO_DIR" default="">
<cfparam name="Q_NEWSLETTER" default="S">

<cfparam name="Q_KM" default="0">
<cfparam name="Q_KM_TOTALI" default="0">






<cfquery name="Insert_Missione" datasource="#APP_DSN#" dbtype="ODBC">
	INSERT INTO missione (
		luogo,
		stato,
		oggetto,
		data_inizio,
		durata,
		id_fondo,
		id_incaricomissione,
		id_rimborsomissione,
		id_anticipomissione,
		id_autmezzoprorpio,
		id_auttaxi,
		last_user,
		last_data,
		last_ip
	) VALUES (
		'#luogo#',
		'#stato#',
		'#oggetto#',
		'#data_inizio#',
		'#durata#',
		'#id_fondo#',
		'#id_incaricomissione#',
		'#id_rimborsomissione#',
        '#id_anticipomissione#',
        #id_autmezzoprorpio#,
        #id_auttaxi#,
       	'#Session.S_USR_USERNAME#',
		'#DateFormat(Now(),"yyyy-mm-dd")# #TimeFormat(Now(),"HH:mm:ss")#',
		'#REMOTE_ADDR#'
	)
</cfquery>--->

<cfset nomeFile  = "D:\WWW\mydimeg\portale_admin\" & "#Q_NOME_FORM#" & ".xml">      
<cffile action="write" file = "#nomeFile#" output="#Q_V_TEMP_TOT#">