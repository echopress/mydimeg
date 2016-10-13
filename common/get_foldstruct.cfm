<!--- 
GET_FOLDSTRUCT v1.0
Recupera la stuttura dei folders
Metodo di chiatata: CFMODULE

A_ROOT: recupera i solo i folder a partire da qui (default: "/")
A_DSN: Data Source Name su cui effettuare la ricerca (default: "")
A_OUTPUT: nome della variabile di output (default: RESULT)

Recupera i folders in una struttura con chiave su fol_folder e valore su fol_label
 --->

<cfparam name="Attributes.A_ROOT" default="/">
<cfparam name="Attributes.A_DSN" default="">
<cfparam name="Attributes.A_OUTPUT" default="RESULT">

<cfset "caller.#Attributes.A_OUTPUT#"="">
<cfset res=structnew()>

<cfquery datasource="#Attributes.A_DSN#" name="Get_Folders" dbtype="ODBC">
	SELECT * FROM folders
	ORDER BY fol_folder
</cfquery>

<cfloop query="Get_Folders">
	<cfif Find(Attributes.A_ROOT,fol_folder) is 1>
		<cfset x=StructInsert(res,fol_folder,fol_label,TRUE)>
	</cfif>
</cfloop>

<cfset "caller.#Attributes.A_OUTPUT#"=StructCopy(res)>

