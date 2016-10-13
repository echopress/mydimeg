<!--- 
GET_ABILITAZIONI v1.0
Recupera le abilitazioni di un utente
Metodo di chiatata: CFMODULE

A_USER: Codice dell'utente (numerico) di cui recuperare le abilitazioni (default: 0)
A_DSN: Data Source Name su cui effettuare la ricerca (default: "")
A_OUTPUT: nome della variabile di output (default: RESULT)

Recupera le abilitazioni dell'utente e le restituisce in forma di lista di quadruple
ciascuna quadrupla formata da    servizio:livello:folder:recurse
 --->

<cfparam name="Attributes.A_USER" default="0">
<cfparam name="Attributes.A_DSN" default="">
<cfparam name="Attributes.A_OUTPUT" default="RESULT">

<cfset "caller.#Attributes.A_OUTPUT#"="">
<cfset res=0>

<cfquery name="Get_Abilitazioni" datasource="#Attributes.A_DSN#" dbtype="ODBC">
	SELECT * FROM abilitazioni
	WHERE abi_idper = #Attributes.A_USER#
	ORDER BY abi_idser, abi_folder, abi_livello DESC
</cfquery>
		
<cfloop query="Get_Abilitazioni">
	<cfset res=listappend(res,"#abi_idser#:#abi_livello#:#abi_folder#:#abi_recurse#")>
</cfloop>

<cfset "caller.#Attributes.A_OUTPUT#"=res>

