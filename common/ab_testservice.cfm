<!--- 
AB_TESTSERVICE.CFM v1.0
Testa l'abilitazione ad un servizio
Metodo di chiamata: CFMODULE

A_SERVICE: Codice del servizio da testare (default: ALL)
           valore "ANY": qualsiasi servizio
A_ABILITAZIONI: stringa che codifica le abilitazioni da testare (default: Session.S_ABILITAZIONI)
A_OUTPUT: nome della variabile di output (default: RESULT)

Restituisce il massimo livello di accesso posseduto sul servizio (in qualunque folder)

codifica richiesta per A_ABILITAZIONI: lista di quadruple
ciascuna quadrupla formata da    servizio:livello:folder:recurse
 --->

<cfparam name="Attributes.A_SERVICE" default="ALL">
<cfparam name="Attributes.A_ABILITAZIONI" default="#Session.S_ABILITAZIONI#">
<cfparam name="Attributes.A_OUTPUT" default="RESULT">

<cfset "caller.#Attributes.A_OUTPUT#"=0>
<cfset res=0>

<cfloop list=#Attributes.A_ABILITAZIONI# index="t_quad">
	<cfset a_quad=listtoarray(t_quad,":")>
	<cfif (a_quad[1] is Attributes.A_SERVICE) or (a_quad[1] is "ALL") or (Attributes.A_SERVICE) is "ANY">
		<cfif a_quad[2] gt res>
			<cfset res = a_quad[2]>
		</cfif>
	</cfif>
</cfloop>
<cfset "caller.#Attributes.A_OUTPUT#"=res>

