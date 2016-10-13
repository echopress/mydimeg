<!---Il config.cfm è già presente--->
<!--- with trailing slash --->
<!---VERIRICARE SE L'UTENTE E' LOGGATO--->
<cfset isAuthorized=False>
<cfif Session.S_USR_ID neq "">
	<cfset isAuthorized=True>
</cfif>

<!---SERVE L'ID DEL FILE E NON IL NOME!!!!!--->
<cfparam name="id" default="">
<cfparam name="s" default="">
<cfquery name="Get_allegato" dataSource="#APP_DSN#" dbtype="ODBC">
    SELECT * FROM documedia#s# WHERE med_id='#id#'
</cfquery>
<!---<cfoutput>SELECT * FROM documedia#s# WHERE med_id='#id#'</cfoutput>
<cfabort>--->
<cfif Get_allegato.recordcount le 0>
	<cfoutput>File not found, or you are not authorized to see it</cfoutput>
    <cfabort>
</cfif>

<cfset file_fisico=Get_allegato.med_file> <!---ho la cartella e il nome del file--->
<cfset nome_del_file=ListLast(file_fisico, "/")>

<cfset filename = Replace("#ATTACHMENTS_FOLDER##file_fisico#", '/', '\') />

<!---<cfoutput>
isAuthorized: #isAuthorized# FileExists(filename):#FileExists(filename)#
</cfoutput>--->
<!---<cfoutput>#ExpandPath(filename)#</cfoutput>
<cfabort>--->

<cfset contenttype = getPageContext().getServletContext().getMimeType(filename)>
<cfif Not isDefined("contettype")>
	<cfset contenttype="x-application">
</cfif>

<!---INSERIRE LOG--->
<!---START SCRIVO LOG RELATIVO ALL' UPDATE--->	
<cfinvoke 
    component="#APP_FOLDERS_COMPONENT#.write_log" method="WriteLog" returnVariable="">		
    <!---Scrittura tabella--->
    <cfinvokeargument name="v_appdns" value="#APP_DSN#">
    <cfinvokeargument name="v_oggetto3" value="file: #file_fisico#">
    <cfinvokeargument name="v_folder" value="/">
    <cfinvokeargument name="v_tab_cod" value="DOCUMEDIA#s#">
    <!---Fine Scrittura tabella--->		
    <cfinvokeargument name="v_servizio" value="progetti">
    <cfinvokeargument name="v_azione" value="VIEW">
    <cfinvokeargument name="v_oggetto1" value="#id#">
    <cfinvokeargument name="v_oggetto2" value="visualizzazione/download di un file allegato/documento">	    		
</cfinvoke>
<!---FINE SCRIVO LOG--->

<cfif isAuthorized AND StructKeyExists(url, "id") AND FileExists(filename)>
	<cfset fileinfo=GetFileInfo(filename)>
	
	<cfheader name="Content-Length" value="#fileinfo.size#">
    <cfheader name="Content-Type" value="#contenttype#">
    <cfheader name="Content-Disposition" value="attachment;filename=""#nome_del_file#""">
    
    
    
    <cfcontent file="#filename#" type="#contenttype#" reset="true" />
<cfelse>
    <cfoutput>File not found, or you are not authorized to see it</cfoutput>
    <cfabort>
</cfif>

