<!--- 
GET_TEMASTRUCT v1.0
Recupera la stuttura delle tematiche
Metodo di chiatata: CFMODULE

A_BASE: recupera i solo le tematiche con questo prefisso (default: "")
A_DSN: Data Source Name su cui effettuare la ricerca (default: "")
A_OUTPUT: nome della variabile di output (default: RESULT)

Recupera le tematiche in una struttura con chiave su tem_id e valore su tem_label
 --->

<cfparam name="Attributes.A_BASE" default="">
<cfparam name="Attributes.A_DSN" default="">
<cfparam name="Attributes.A_OUTPUT" default="RESULT">

<cfset "caller.#Attributes.A_OUTPUT#"="">
<cfset res=structnew()>

<cfquery datasource="#Attributes.A_DSN#" name="Get_Tematiche" dbtype="ODBC">
	SELECT * FROM tematiche
	<cfif Attributes.A_BASE is not "">
		WHERE tem_codice LIKE '#Attributes.A_BASE#.%'
	</cfif>
	ORDER BY tem_label
</cfquery>

<cfloop query="Get_Tematiche">
	<cfset x=StructInsert(res,tem_id,tem_label,TRUE)>
</cfloop>

<cfset "caller.#Attributes.A_OUTPUT#"=StructCopy(res)>

