<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>PORTALE UNICAL: Fase di Autenticazione</title>
	
</head>

<body bgcolor="808040">

<font size="+1"><b>Autenticazione...Attendere Prego.....</b></font>



<cfparam name="Q_PER_MATRICOLA" default="">
<cfparam name="Q_PER_PIN" default="">
<cfparam name="pin" default="N">
<cfparam name="Q_CODICEFISCALE" default="">
<cfparam name="Q_FIRMADIGITALE" default="N">

<cfset Q_CODICEFISCALE = #Q_CODICEFISCALE# />
<cfset Q_FIRMADIGITALE = #Q_FIRMADIGITALE# />

<body bgcolor="808040">

<cfif q_per_matricola is not "">
	<!--- Controllo Username --->
    <cfmodule template="../common/chk_common.cfm" 
        A_TYPE="TEXT"
        A_LABEL="Matricola"
        A_VALUE=#Q_PER_MATRICOLA#
        A_REQUIRED="S"
        A_REGEX="[^0-9]"
        A_OUTPUT="V_MATRICOLA">
<cfelse>
	<cfset v_matricola="">
</cfif>
<font size="+1"><b>Autenticazione...Attendere Prego.....</b></font>
<cfinclude template="/config.cfm">

<cfif Q_FIRMADIGITALE is "N">
	<!--- Controllo Username --->
    <cfmodule template="../common/chk_common.cfm" 
        A_TYPE="TEXT"
        A_LABEL="Matricola"
        A_VALUE=#Q_PER_MATRICOLA#
        A_REQUIRED="S"
        A_REGEX="[^0-9]"
        A_OUTPUT="V_MATRICOLA"
    >
	<cfif Q_PER_MATRICOLA is "" OR Q_PER_PIN is "">
		<!--- ACCESSO ANONIMO --->
		<cflocation url="../common/error.cfm?bad_login" addtoken="NO">
	</cfif>
<cfelse>
	<!--- Controllo Errori --->
	<cfquery name="Get_Error" datasource="#APP_DSN#" dbtype="ODBC">
		SELECT * FROM ErrorAccess
		WHERE username = '#V_MATRICOLA#'
	</cfquery>
	<cfif Get_Error.num_error gt 5>
		<cflocation url="../common/error.cfm?onemoment_login" addtoken="NO">		
	</cfif>
	<!--- Fine Controllo Errori --->
    
	<!--- ACCESSO CON MATRICOLA E PIN --->
	<!---<cfset V_PIN=LCase(hash(Q_PER_PIN, "MD5"))>
    <cfif LSIsNumeric(V_MATRICOLA)>
      <cfset V_MATRICOLA=int(V_MATRICOLA)>--->
  </cfif>
    
	<cfquery name="Get_LoginSoldi" datasource="#APP_DSN#" dbtype="ODBC">
		SELECT * FROM ANAGRAFICHE_SOLDI
        WHERE ( (matricola = '#V_MATRICOLA#') OR (codice_fiscale='#Q_CODICEFISCALE#') )
		<cfif Q_FIRMADIGITALE is "N">
            AND pin = '#V_PIN#'
        </cfif>
		AND valido = 'Y'
	</cfquery>
    
	<cfif Get_LoginSoldi.RecordCount is 0>
		<cflocation url="../common/error.cfm?bad_login" addtoken="NO">
	</cfif>
	

	<!--- ACCESSO CON USERNAME E PASSWORD --->
	<cfquery name="Get_Login" datasource="#APP_DSN#" dbtype="ODBC">
		SELECT * FROM personale 
		WHERE per_matricola = #Get_LoginSoldi.matricola#
		AND per_enabled = 'S'
	</cfquery>
    
	<cfif Get_Login.RecordCount is 0>
		<cflocation url="../common/error.cfm?bad_login" addtoken="NO">
	</cfif>
	
	<!--- controlla allow --->
	<cfset t_allow=Get_Login.per_allow>
	<cfif right(t_allow,1) is not ".">
		<cfset t_allow=t_allow & ".">
	</cfif>
	<cfloop condition="right(t_allow,3) is '.0.'">
		<cfset t_allow=left(t_allow,len(t_allow)-2)>
	</cfloop>
	<cfif (t_allow is "0.") or (t_allow is ".")>
		<cfset t_allow="">
	</cfif>
	<cfset new_Remote=REMOTE_ADDR & ".">
	<cfif (t_allow is not "") and ((new_Remote is not t_allow) AND left(REMOTE_ADDR,len(t_allow)) is not t_allow)>
		<cflocation url="../common/error.cfm?no_allow" addtoken="NO">
	</cfif>	
	<cfif Q_FIRMADIGITALE is "N">
        <cfmodule template="..\common\enkript.cfm" A_STRING="#Q_PER_PASSWORD#" A_OUTPUT="T_PWD">
    </cfif>
	<cfif T_PWD is Get_Login.per_password>
		<cfset Session.S_PER_ID= "#Get_Login.PER_ID#">
		<cfset Session.S_PER_USERNAME= "#Get_Login.PER_USERNAME#">
		<cfset Session.S_PER_COGNOME= "#Get_Login.PER_COGNOME#">
		<cfset Session.S_PER_NOME= "#Get_Login.PER_NOME#">
		<cfset Session.S_PER_FOLDER= "#Get_Login.PER_FOLDER#">		
		<cfset Session.S_PER_LASTLOG="#Get_Login.PER_LASTLOG#">
		<cfset Session.S_PER_TIME_LOGIN="#TimeFormat(Now(),"HH:mm")#">		        
		
		<!--- CALCOLO Abilitazioni --->
 		<cfmodule template="../common/get_abilitazioni.cfm"
		    A_DSN=#APP_DSN#
			A_USER=#Get_Login.PER_ID#
			A_OUTPUT="t_abilitazioni">
		<cfset Session.S_ABILITAZIONI=t_abilitazioni>
		<!--- FINE CALCOLO Abilitazioni --->
	
	 	<cfquery name="lastvisit" datasource="#APP_DSN#" dbtype="ODBC" debug="yes">
			UPDATE personale SET 
				per_lastlog = '#DateFormat(Now(), "yyyy-mm-dd")# #TimeFormat(Now(),"HH:mm:ss")#',
				per_lastip = '#REMOTE_ADDR#'
			WHERE per_id = #Get_Login.PER_ID#
		</cfquery>
		
	<!---START SCRIVO LOG--->	
	<cfinvoke 
		component="#APP_FOLDERS_COMPONENT#" method="WriteLog" returnVariable="">
		<cfinvokeargument name="v_filename" value="#APP_ADMIN_FOLDERS_ROOT#\log.txt">		
		<!---Scrittura tabella--->
		<cfinvokeargument name="v_appdns" value="#APP_DSN#">
		<cfinvokeargument name="v_oggetto3" value="">
		<cfinvokeargument name="v_folder" value="#Get_Login.PER_FOLDER#">
		<cfinvokeargument name="v_tab_cod" value="PERSONALE">
		<!---Fine Scrittura tabella--->		
		<cfinvokeargument name="v_servizio" value="LOGIN">
		<cfinvokeargument name="v_azione" value="LOGIN">
		<cfinvokeargument name="v_oggetto1" value="#Get_Login.PER_ID#">
		<cfinvokeargument name="v_oggetto2" value="#Get_Login.PER_USERNAME#">    		
	</cfinvoke>
	<!---FINE SCRIVO LOG--->
		
		
 	 	<cflocation url="home.cfm" addtoken="No">
	</cfif>
	

<!--- ACCESSO FALLITO --->

<cfoutput>	
	<cflocation url="../common/error.cfm?bad_login" addtoken="NO">
</cfoutput>

</body>
</html>

