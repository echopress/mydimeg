<!--- 
AB_AUTHFOLDERS.CFM v1.0
Restituisce i folders dove si e' abilitati ditrettamente (non ereditata per ricorsione)
Metodo di chiatata: CFMODULE

A_SERVICE: Codice del servizio da testare (default: ALL)
           valore "ANY": qualsiasi servizio
A_LEVEL: Livello di abilitazione minimo richiesto (default: 0)
A_ABILITAZIONI: stringa che codifica le abilitazioni da testare (default: Session.S_ABILITAZIONI)
A_OUTPUT: nome della variabile di output (default: RESULT)

Restituisce l'elenco dei folders in cui si possiede il livello A_LEVEL sul servizio A_SERVICE (non ereditata per ricorsione)

codifica richiesta per A_ABILITAZIONI: lista di quadruple
ciascuna quadrupla formata da    servizio:livello:folder:recurse
 --->

<cfparam name="Attributes.A_SERVICE" default="ALL">
<cfparam name="Attributes.A_LEVEL" default="0">
<cfparam name="Attributes.A_ABILITAZIONI" default="#Session.S_ABILITAZIONI#">
<cfparam name="Attributes.A_OUTPUT" default="RESULT">

<cfset "caller.#Attributes.A_OUTPUT#"="">
<cfset res="">

<cfloop list=#Attributes.A_ABILITAZIONI# index="t_quad">
	<cfset a_quad=listtoarray(t_quad,":")>
	<cfif (a_quad[1] is Attributes.A_SERVICE) or (a_quad[1] is "ALL") or (Attributes.A_SERVICE) is "ANY">
		<cfif a_quad[2] ge Attributes.A_LEVEL>
			<cfset res = listappend(res,a_quad[3])>
		</cfif>
	</cfif>
</cfloop>

<cfset "caller.#Attributes.A_OUTPUT#"=res>
