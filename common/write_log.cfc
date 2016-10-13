<cfcomponent>
	<cffunction name="WriteLog" access="public" returntype="string">
		<cfargument name="v_filename" type="string" required="yes">		
		<!---Inserimento dati in tabella --->
		<cfargument name="v_appdns" type="string" required="yes">
		<cfargument name="v_oggetto3" type="string" required="no">
		<cfargument name="v_folder" type="string" required="no">
		<cfargument name="v_tab_cod" type="string" required="no">
		<!---Fine Inserimento dati in tabella --->	
		<cfargument name="v_servizio" type="string" required="yes">
		<cfargument name="v_azione" type="string" required="yes">
		<cfargument name="v_oggetto1" type="string" required="no">
		<cfargument name="v_oggetto2" type="string" required="no">
				
		<cfif v_oggetto2 is "PRENOTAZIONESPAZI">
        	<cfset mylog="#dateformat(now(),"dd/mm/yyyy")# #timeformat(now(),"HH:MM:SS")# - #v_servizio# - #v_azione# - #v_oggetto1# - #v_oggetto2# from #REMOTE_ADDR#">
            <cfset Session.S_PER_USERNAME="WEBUSER">
        <cfelse>	
			<cfset mylog="#dateformat(now(),"dd/mm/yyyy")# #timeformat(now(),"HH:MM:SS")# - #v_servizio# - #v_azione# - #v_oggetto1# - #v_oggetto2# - da #Session.S_PER_ID# #Session.S_PER_USERNAME# - from #REMOTE_ADDR#">
		</cfif>
        		
		<cfif v_servizio is not "NEWSLETTER" AND v_servizio is not "NEWTEMPLATE">
        	 <cftry>
                <cffile action="APPEND" file="#v_filename#" output="#mylog#">
                <cfcatch type="Any">
                    <cflocation url="error.cfm?try_file,Can't_write_RSSfile" addtoken="No">
                </cfcatch>
            </cftry>
        </cfif>
       
		
       <!--- Inserimento dati in tabella --->
	   
	    <cftransaction isolation="READ_COMMITTED">
		<cfquery name="GET_Code" datasource="#v_appdns#" dbtype="ODBC">
			SELECT cod_count FROM codici WHERE cod_table = 'log_action'
		</cfquery>
	
		<cfset V_CODICE=GET_Code.cod_count+1>
	
		<cfquery name="INC_Code" datasource="#v_appdns#" dbtype="ODBC">
			UPDATE codici SET
			cod_count = #V_CODICE#
			WHERE cod_table = 'log_action'
		</cfquery>
	    </cftransaction>
		
	
	    <cfquery name="Query_Insert" datasource = "#v_appdns#" dbtype="ODBC">
			INSERT INTO log_action 
				(	log_id,
					log_doc_id,
					log_tab_cod,
					log_folder,
					log_servizio,
					log_azione,
					log_user,
					log_data,
					log_ip,
					log_free2,
					log_free3 )
			VALUES 
				(	#V_CODICE#,
					'#v_oggetto1#',
					'#v_tab_cod#',
					'#v_folder#',
					'#v_servizio#',
					'#v_azione#',
					'#Session.S_PER_USERNAME#',
					'#DateFormat(Now(),"yyyy-mm-dd")# #TimeFormat(Now(),"HH:mm:ss")#',
					'#REMOTE_ADDR#',
					'#v_oggetto2#',
					'#v_oggetto3#')
	     </cfquery>
		 
		 <!---Fine Inserimento dati in tabella --->

<!---<cfset myResult="foo">
     <cfreturn myResult>--->	
	</cffunction>
</cfcomponent>