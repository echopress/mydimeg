<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<head>
<cfoutput>
   <META HTTP-EQUIV="REFRESH" CONTENT="3; URL=login.cfm">
</cfoutput>
	<title>PORTALE UNICAL</title>
</head>

<body bgcolor="white">

<cfset V_Titolo_Pagina="Log Off">
<cfinclude template="../common/header.cfm">

<p align="center">
<font size=6 face="Tahoma, arial" color="red">
<cfoutput>
	<b>Arrivederci #Session.S_PER_NOME# #Session.S_PER_COGNOME#</b>
</cfoutput>

<!---START SCRIVO LOG--->	
	<cfinvoke 
		component="#APP_FOLDERS_COMPONENT#" method="WriteLog" returnVariable="">
		<cfinvokeargument name="v_filename" value="#APP_ADMIN_FOLDERS_ROOT#\log.txt">		
		<!---Scrittura tabella--->
		<cfinvokeargument name="v_appdns" value="#APP_DSN#">
		<cfinvokeargument name="v_oggetto3" value="">
		<cfinvokeargument name="v_folder" value="#Session.S_PER_FOLDER#">
		<cfinvokeargument name="v_tab_cod" value="PERSONALE">
		<!---Fine Scrittura tabella--->		
		<cfinvokeargument name="v_servizio" value="LOGOFF">
		<cfinvokeargument name="v_azione" value="LOGOFF">
		<cfinvokeargument name="v_oggetto1" value="#Session.S_PER_ID#">
		<cfinvokeargument name="v_oggetto2" value="#Session.S_PER_USERNAME#">    		
	</cfinvoke>
<!---FINE SCRIVO LOG--->


<!--- Azzera tutte le altre session --->
<cfset Session.S_PER_ID= "">
<cfset Session.S_PER_USERNAME= "">
<cfset Session.S_PER_COGNOME= "">
<cfset Session.S_PER_NOME= "">
<cfset Session.S_PER_FOLDER= "">		
<cfset Session.S_PER_LASTLOG="">
<cfset Session.S_PER_TIME_LOGIN="">	

</font>

<!---<cfinclude template="../common/footer.cfm">--->
</BODY>
</HTML>