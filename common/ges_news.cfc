<cfcomponent>
    <cfinclude template="/config.cfm">
    <cfset time_now=dateformat(now(),"yyyy-mm-dd") & " " & timeformat(now(),"HH:mm:ss")>
    
	<cffunction name="Get_Notizia" access="public" returntype="query">
		<cfargument name="Q_ID" type="string" required="yes">
		<cfargument name="time_now" type="string" required="yes">
		
		<CFQUERY dbtype = "ODBC" datasource = "#APP_DSN#" name = "Get_This">
            SELECT notizie.*, folders.fol_descr, folders.fol_protetto, folders.fol_folder
            FROM notizie, folders
            WHERE not_folder=fol_folder
            AND not_id=#Q_ID#
            AND not_visibile='S'
            AND  not_data_in < '#time_now#'
            AND  not_data_out > '#time_now#'
            <cfif (Left(REMOTE_ADDR,7) is not ("160.97.")) and (Left(REMOTE_ADDR,12) is not ("192.167.201."))>
                AND  not_intranet='N'
            </cfif>
            AND fol_type = 'NORMAL'
        </CFQUERY>
        
		<cfreturn Get_This>
	</cffunction>
    
    <cffunction name="Get_Images" access="public" returntype="query">
		<cfargument name="Q_ID" type="string" required="yes">
		
		<CFQUERY dbtype = "ODBC" datasource = "#APP_DSN#" name = "Get_This">
            SELECT *
            FROM documedia
            WHERE med_docid=#Q_ID#
            AND med_tipo = 'IMAGE'
            ORDER BY med_sort
        </CFQUERY>
        
		<cfreturn Get_This>
	</cffunction>
    
	<cffunction name="Get_Rels" access="public" returntype="query">
		<cfargument name="Q_ID" type="string" required="yes">
		
		<CFQUERY dbtype = "ODBC" datasource = "#APP_DSN#" name = "Get_This">
            SELECT * FROM docurel
            WHERE rel_doc1id=#Q_ID#
            ORDER BY rel_sort
        </CFQUERY>
        
		<cfreturn Get_This>
	</cffunction>

	<cffunction name="Get_Links" access="public" returntype="query">
		<cfargument name="Q_ID" type="string" required="yes">
		
		<CFQUERY dbtype = "ODBC" datasource = "#APP_DSN#" name = "Get_This">
            SELECT * FROM doculink
            WHERE lnk_docid=#Q_ID#
            ORDER BY lnk_sort
        </CFQUERY>
        
		<cfreturn Get_This>
	</cffunction>

	<cffunction name="Get_Attach" access="public" returntype="query">
		<cfargument name="Q_ID" type="string" required="yes">
		
		<CFQUERY dbtype = "ODBC" datasource = "#APP_DSN#" name = "Get_This">
            SELECT *
            FROM documedia
            WHERE med_docid=#Q_ID#
            AND med_tipo = 'ATTACH'
            ORDER BY med_sort
        </CFQUERY>
        
		<cfreturn Get_This>
	</cffunction>
    
	<cffunction name="Get_AudioVideo" access="public" returntype="query">
		<cfargument name="Q_ID" type="string" required="yes">
		
		<CFQUERY dbtype = "ODBC" datasource = "#APP_DSN#" name = "Get_This">
            SELECT *
            FROM documedia
            WHERE med_docid=#Q_ID#
            AND (med_tipo = 'VIDEO'
            OR med_tipo = 'AUDIO')
            ORDER BY med_sort
        </CFQUERY>
        
		<cfreturn Get_This>
	</cffunction>
    
	<cffunction name="Update_Hits" access="public" returntype="void">
		<cfargument name="Q_ID" type="string" required="yes">
		
		<CFQUERY dbtype = "ODBC" datasource = "#APP_DSN#" name = "Get_This">
            UPDATE notizie
            SET
            	not_hits = not_hits + 1
            WHERE not_id = #Q_ID#
        </CFQUERY>
	</cffunction>

	<cffunction name="Get_RelNews" access="public" returntype="query">
		<cfargument name="rel_doc2id" type="string" required="yes">
		
		<CFQUERY dbtype = "ODBC" datasource = "#APP_DSN#" name = "Get_This">
            SELECT *
            FROM notizie
            WHERE not_id=#rel_doc2id#
            AND not_visibile='S'
            AND not_tipologia <> 'LINK'
            AND not_tipologia <> 'GALLERY'
        </CFQUERY>
        
		<cfreturn Get_This>
	</cffunction>

	<cffunction name="Get_PROSSIME_NEWS" access="public" returntype="query">
		<cfargument name="Q_ID" type="string" required="yes">
        <cfargument name="dataInizio" type="string" required="yes">
        <cfargument name="dataFine" type="string" required="yes">
        <cfargument name="time_now" type="string" required="no">
        <cfargument name="step" type="string" required="no" default="10">
		
		<CFQUERY dbtype = "ODBC" datasource = "#APP_DSN#" name = "Get_This">
            SELECT n.*
            FROM notizie n, folders f
            WHERE not_folder = fol_folder
            AND fol_type = 'NORMAL'
            AND fol_protetto = 'NO'
            AND NOT_TIPOLOGIA='NEWS'
            AND NOT_VISIBILE='S'
            AND NOT_DATA BETWEEN '#dataInizio#' AND '#dataFine#'
            <cfif isDefined("Q_ID") AND Q_ID neq "">
            	AND NOT_ID<>#Q_ID#
            </cfif>
			<cfif (Left(REMOTE_ADDR,7) is not "160.97.") AND (Left(REMOTE_ADDR,12) is not "192.167.201.")>
            	AND  not_intranet='N'
            </cfif>
            <cfif isDefined("time_now") AND time_now neq "">
            	AND  not_data_in < '#time_now#'
                AND  not_data_out > '#time_now#'
            </cfif>
              
            ORDER BY NOT_DATA DESC
            
            LIMIT 0,#step#
        </CFQUERY>
                
		<cfreturn Get_This>
	</cffunction>

	<cffunction name="Get_NEWS_PIULETTE" access="public" returntype="query">
		<cfargument name="Q_ID" type="string" required="no">
        <cfargument name="time_now" type="string" required="no">
        <cfargument name="step" type="string" required="no" default="10">
		
		<CFQUERY dbtype = "ODBC" datasource = "#APP_DSN#" name = "Get_This">
            SELECT *
            FROM notizie, folders
            WHERE NOT_TIPOLOGIA='NEWS'
            AND not_folder = fol_folder
            AND fol_type = 'NORMAL'
            AND fol_protetto = 'NO'
            AND NOT_VISIBILE='S'
            AND not_data_in < '#time_now#'
        	AND not_data_out > '#time_now#'
            <cfif isDefined("Q_ID") AND Q_ID neq "">
            	AND NOT_ID<>#Q_ID#
            </cfif>
            AND NOT_DATA > '#Dateformat(now()-90,"yyyy-mm-dd")#'
            AND NOT_HITS > 0
            <cfif (Left(REMOTE_ADDR,7) is not "160.97.") AND (Left(REMOTE_ADDR,12) is not "192.167.201.")>
            	AND  not_intranet='N'
            </cfif>
            <cfif isDefined("time_now") AND time_now neq "">
            	AND  not_data_in < '#time_now#'
                AND  not_data_out > '#time_now#'
            </cfif>
            
            ORDER BY NOT_HITS DESC
            
            LIMIT 0,#step#
        </CFQUERY>
        
        <cfreturn Get_This>
	</cffunction>
    
	<cffunction name="All_Data" access="public" returntype="query">
		<cfargument name="time_now" type="string" required="yes">
		<cfargument name="Q_TIP" type="string" required="yes">
		<cfargument name="Q_TEM" type="string" required="yes">
		<cfargument name="Q_KEYS" type="string" required="yes">
		<cfargument name="Q_FOL" type="string" required="yes">
		<cfargument name="first" type="string" required="yes">
		<cfargument name="step" type="string" required="yes">
		
		<CFQUERY dbtype = "ODBC" datasource = "#APP_DSN#" name = "Get_This">
            SELECT *
            FROM notizie, folders
            WHERE not_visibile='S'
            AND not_idfolder = fol_id
            AND fol_type = 'NORMAL'
            <!---<cfif isDefined("time_now") AND time_now neq "">
                AND  not_data_in < '#time_now#'
                AND  not_data_out > '#time_now#'
            </cfif>--->
            <!---controllo intranet--->
            <cfif (Left(REMOTE_ADDR,7) is not "160.97.") AND (Left(REMOTE_ADDR,12) is not "192.167.201.")>
            AND  not_intranet='N'
            </cfif>
            <!---fine controllo intranet--->
            <cfif Q_TIP is not "">
            AND not_tipologia = '#Q_TIP#'
            <cfelse>
            AND ((not_tipologia = 'NEWS') OR (not_tipologia = 'DOC_SMALL'))
            </cfif>
            <cfif Q_TEM is not "">
            AND not_idtematica = #Q_TEM#
            </cfif>
            <cfif Q_KEYS is not "">
            AND (upper(not_titolo) LIKE '%#Ucase(Q_KEYS)#%' OR upper(not_sottotitolo) LIKE '%#Ucase(Q_KEYS)#%' OR upper(not_testo) LIKE '%#Ucase(Q_KEYS)#%')
            </cfif>
            <cfif Q_FOL is not "">
            AND not_folder = '#Q_FOL#'
            </cfif>
            AND not_pos > 1
 	 		ORDER BY  not_pos, not_sort, not_data DESC, not_id DESC
            
            LIMIT #first#,#step#
        </CFQUERY>
        <!--- <cfdump var="#Get_This#"> --->
        
		<cfreturn Get_This>
	</cffunction>
    
    <cffunction name="Count_Data" access="public" returntype="numeric">
		<cfargument name="time_now" type="string" required="yes">
		<cfargument name="Q_TIP" type="string" required="yes">
		<cfargument name="Q_TEM" type="string" required="yes">
		<cfargument name="Q_KEYS" type="string" required="yes">
		<cfargument name="Q_FOL" type="string" required="yes">
		
		<CFQUERY dbtype = "ODBC" datasource = "#APP_DSN#" name = "Get_This">
            SELECT COUNT(not_id) AS conteggio
            FROM notizie, folders
            WHERE not_visibile='S'
            AND not_idfolder = fol_id
            AND fol_type = 'NORMAL'
            <cfif isDefined("time_now") AND time_now neq "">
                AND  not_data_in < '#time_now#'
                AND  not_data_out > '#time_now#'
            </cfif>
            <!---controllo intranet--->
            <cfif (Left(REMOTE_ADDR,7) is not "160.97.") AND (Left(REMOTE_ADDR,12) is not "192.167.201.")>
            AND  not_intranet='N'
            </cfif>
            <!---fine controllo intranet--->
            <cfif Q_TIP is not "">
            AND not_tipologia = '#Q_TIP#'
            <cfelse>
            AND ((not_tipologia = 'NEWS') OR (not_tipologia = 'DOC_SMALL'))
            </cfif>
            <cfif Q_TEM is not "">
            AND not_idtematica = #Q_TEM#
            </cfif>
            <cfif Q_KEYS is not "">
            AND (upper(not_titolo) LIKE '%#Ucase(Q_KEYS)#%' OR upper(not_sottotitolo) LIKE '%#Ucase(Q_KEYS)#%' OR upper(not_testo) LIKE '%#Ucase(Q_KEYS)#%')
            </cfif>
            <cfif Q_FOL is not "">
            AND not_folder = '#Q_FOL#'
            </cfif>
            AND not_pos > 1
 	 		ORDER BY  not_pos, not_sort, not_data DESC, not_id DESC
        </CFQUERY>
        
		<cfreturn Get_This.conteggio>
	</cffunction>
    
    <cffunction name="Get_Prev_News" access="public" returntype="query">
    	<cfargument name="Q_ID" type="string" required="yes">
		<cfargument name="time_now" type="string" required="yes">
		<cfargument name="Q_TIP" type="string" required="no">
		<cfargument name="Q_TEM" type="string" required="no">
		<cfargument name="Q_KEYS" type="string" required="no">
		<cfargument name="Q_FOL" type="string" required="no">
		
		<CFQUERY dbtype = "ODBC" datasource = "#APP_DSN#" name = "Get_This">
            SELECT *
            FROM notizie, folders
            WHERE not_visibile='S'
            AND not_idfolder = fol_id
            AND fol_type = 'NORMAL'
            <cfif isDefined("time_now") AND time_now neq "">
                AND  not_data_in < '#time_now#'
                AND  not_data_out > '#time_now#'
            </cfif>
            <!---controllo intranet--->
            <cfif (Left(REMOTE_ADDR,7) is not "160.97.") AND (Left(REMOTE_ADDR,12) is not "192.167.201.")>
            AND  not_intranet='N'
            </cfif>
            <!---fine controllo intranet--->
            <cfif Q_TIP is not "">
            AND not_tipologia = '#Q_TIP#'
            <cfelse>
            AND ((not_tipologia = 'NEWS') OR (not_tipologia = 'DOC_SMALL'))
            </cfif>
            <cfif Q_TEM is not "">
            AND not_idtematica = #Q_TEM#
            </cfif>
            <cfif Q_KEYS is not "">
            AND (upper(not_titolo) LIKE '%#Ucase(Q_KEYS)#%' OR upper(not_sottotitolo) LIKE '%#Ucase(Q_KEYS)#%' OR upper(not_testo) LIKE '%#Ucase(Q_KEYS)#%')
            </cfif>
            <cfif Q_FOL is not "">
            AND not_folder = '#Q_FOL#'
            </cfif>
            AND not_pos > 1
 	 		ORDER BY  not_pos, not_sort, not_data DESC, not_id DESC
            
            LIMIT 0,20
        </CFQUERY>
        <!--- <cfdump var="#Get_This#"> --->
        
        <cfset pos = 0>
        <cfset k = 1 >
        <cfloop query="Get_This">
        	<cfif Get_This.not_id eq Q_ID>
            	<cfset pos = k>
                <cfbreak>
            </cfif>
            <cfset k = k + 1 >
        </cfloop>
        <cfif k eq Get_This.RecordCount>
        	<CFQUERY dbtype = "ODBC" datasource = "#APP_DSN#" name = "Get_This">
            	SELECT * FROM notizie WHERE 1=2
            </CFQUERY>
        	<cfreturn Get_This>
        </cfif>
        <cftry>
        	<cfset row = queryGetRow(Get_This, k + 1)>
            <cfcatch type="any">
                <CFQUERY dbtype = "ODBC" datasource = "#APP_DSN#" name = "Get_This">
                    SELECT * FROM notizie WHERE 1=2
                </CFQUERY>
                <cfreturn Get_This>
            </cfcatch>
        </cftry>
        <CFQUERY dbtype = "ODBC" datasource = "#APP_DSN#" name = "Get_This">
        	SELECT *
            FROM notizie
            WHERE not_id = '#row.not_id#'
        </CFQUERY>
        
		<cfreturn Get_This>
	</cffunction>
    
    <cffunction name="Get_Next_News" access="public" returntype="query">
    	<cfargument name="Q_ID" type="string" required="yes">
		<cfargument name="time_now" type="string" required="yes">
        <cfargument name="Q_TIP" type="string" required="no">
		<cfargument name="Q_TEM" type="string" required="no">
		<cfargument name="Q_KEYS" type="string" required="no">
		<cfargument name="Q_FOL" type="string" required="no">
		
		<CFQUERY dbtype = "ODBC" datasource = "#APP_DSN#" name = "Get_This">
            SELECT *
            FROM notizie, folders
            WHERE not_visibile='S'
            AND not_idfolder = fol_id
            AND fol_type = 'NORMAL'
            <cfif isDefined("time_now") AND time_now neq "">
                AND  not_data_in < '#time_now#'
                AND  not_data_out > '#time_now#'
            </cfif>
            <!---controllo intranet--->
            <cfif (Left(REMOTE_ADDR,7) is not "160.97.") AND (Left(REMOTE_ADDR,12) is not "192.167.201.")>
            AND  not_intranet='N'
            </cfif>
            <!---fine controllo intranet--->
            <cfif Q_TIP is not "">
            AND not_tipologia = '#Q_TIP#'
            <cfelse>
            AND ((not_tipologia = 'NEWS') OR (not_tipologia = 'DOC_SMALL'))
            </cfif>
            <cfif Q_TEM is not "">
            AND not_idtematica = #Q_TEM#
            </cfif>
            <cfif Q_KEYS is not "">
            AND (upper(not_titolo) LIKE '%#Ucase(Q_KEYS)#%' OR upper(not_sottotitolo) LIKE '%#Ucase(Q_KEYS)#%' OR upper(not_testo) LIKE '%#Ucase(Q_KEYS)#%')
            </cfif>
            <cfif Q_FOL is not "">
            AND not_folder = '#Q_FOL#'
            </cfif>
            AND not_pos > 1
 	 		ORDER BY  not_pos, not_sort, not_data DESC, not_id DESC
            
            LIMIT 0,20
        </CFQUERY>
        <!--- <cfdump var="#Get_This#"> --->
        
        <cfset pos = 0>
        <cfset k = 1 >
        <cfloop query="Get_This">
        	<cfif Get_This.not_id eq Q_ID>
            	<cfset pos = k>
                <cfbreak>
            </cfif>
            <cfset k = k + 1 >
        </cfloop>
        <cfif k eq 1>
        	<CFQUERY dbtype = "ODBC" datasource = "#APP_DSN#" name = "Get_This">
            	SELECT * FROM notizie WHERE 1=2
            </CFQUERY>
        	<cfreturn Get_This>
        </cfif>
        <cfset row = queryGetRow(Get_This, k - 1)>
        <CFQUERY dbtype = "ODBC" datasource = "#APP_DSN#" name = "Get_This">
        	SELECT *
            FROM notizie
            WHERE not_id = '#row.not_id#'
        </CFQUERY>
        
		<cfreturn Get_This>
	</cffunction>

</cfcomponent>