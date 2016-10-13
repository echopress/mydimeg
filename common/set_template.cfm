<!--- 
SET_TEMPLATE.CFM v1.0
Aggiorna i dati in un template
Metodo di chiatata: CFMODULE

A_FILE:    file del template (required)
A_STRUCT: nome di una variabile di ingresso contenente la struttura da riortare nel template
A_OUT_ERROR:   nome variabile di output per l'eventuale testo di errore
		     se vuoto non c'e' stato nessun errore (default: RES_ERROR)

Legge il template e lo riscrive con i dati aggiornati in base a una struttura
 --->

<cfparam name="Attributes.A_FILE" default="">
<cfparam name="Attributes.A_STRUCT" default="">
<cfparam name="Attributes.A_OUT_ERROR" default="RES_ERROR">

<cfset "caller.#Attributes.A_OUT_ERROR#"="">

<cfif Attributes.A_FILE is "">
	<cfset "caller.#Attributes.A_OUT_ERROR#"="No File">
	<cfexit method="ExitTag">
</cfif>

<cfmodule template="../common/split.cfm"
	A_FILE="#Attributes.A_FILE#"
	A_START="<!--- TEMPLATE START --->"
	A_STOP="<!--- TEMPLATE STOP --->"
	A_OUT_PRE="V_PRE"
	A_OUT_MID="V_TEMPLATE_TEXT"
	A_OUT_POST="V_POST"
	A_OUT_ERROR="V_ERROR"
>
<cfif V_ERROR is not "">
	<cfset "caller.#Attributes.A_OUT_ERROR#"="Template: #V_ERROR#">
	<cfexit method="ExitTag">
</cfif>

<cfset STR=structcopy(Attributes.A_STRUCT)>

<cfloop from="1" to=#str.numfields# index="nf">
	<cfif STR.fields[nf].field_editable is "S">
		<cfswitch expression=#STR.fields[nf].CONTAINER#>
			<cfcase value="CFSET">
				<cfset v_pos=ReFindNoCase("<cfset +#STR.fields[nf].VARNAME# *= *""([^""]*)"" *>",V_TEMPLATE_TEXT,1,"TRUE")>
				<cfif v_pos.pos[1] is not 0>
					<cfset v_value=Replace(STR.fields[nf].VALUE,"""","`","ALL")>
					<cfset V_TEMPLATE_TEXT="#left(V_TEMPLATE_TEXT, v_pos.pos[2]-1)##v_value##mid(V_TEMPLATE_TEXT, v_pos.pos[2]+v_pos.len[2],len(V_TEMPLATE_TEXT))#">
				<cfelse>
					<cfset "caller.#Attributes.A_OUT_ERROR#"="Template: Container not found (#STR.fields[nf].VARNAME#)">
				</cfif>
			</cfcase>
			<cfdefaultcase>
			</cfdefaultcase>
		</cfswitch>
	</cfif>
</cfloop>	

<cfset v_body=V_PRE & "<!--- TEMPLATE START --->" & V_TEMPLATE_TEXT & "<!--- TEMPLATE STOP --->" & V_POST>
<cftry>
	<cffile action="WRITE" file=#Attributes.A_FILE# addnewline="No" output=#v_body#>
	<cfcatch type="Any">
		<cfset "caller.#Attributes.A_OUT_ERROR#"="Template: Connot write template">
		<cfexit method="ExitTag">
	</cfcatch>
</cftry>
<cfinclude template="/config.cfm">
<cfquery datasource="#APP_DSN#" name="Get_Subfolders" dbtype="ODBC">
    REPLACE INTO custom_configs (folder, content, last_data, last_user) VALUES ('#Q_CURR_PAGE#', '#Replace(v_body, "'","_squot_", "ALL")#', '#LsDateformat(NOW(), 'Y-mm-dd')&"T"&LsTimeformat(NOW(), 'HH:mm:ss')#', '#Session.S_PER_USERNAME#');
</cfquery>

<!--- fine --->
