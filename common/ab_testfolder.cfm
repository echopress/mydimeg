<!--- 
AB_TESTFOLDER.CFM v1.0
Testa l'abilitazione in un folder
Metodo di chiatata: CFMODULE

A_SERVICE: Codice del servizio da testare (default: ALL)
           valore "ANY": qualsiasi servizio
A_FOLDER: Folder su cui effettuare il test (default: /)
A_RECURSE: Usa il parametro recurse nel calcolo (default: S)
A_ABILITAZIONI: stringa che codifica le abilitazioni da testare (default: Session.S_ABILITAZIONI)
A_OUTPUT: nome della variabile di output (default: RESULT)

Restituisce il livello di accesso posseduto dall'utente nel folder per il servizio richiesto

codifica richiesta per A_ABILITAZIONI: lista di quadruple
ciascuna quadrupla formata da    servizio:livello:folder:recurse
 --->

<cfparam name="Attributes.A_SERVICE" default="ALL">
<cfparam name="Attributes.A_FOLDER" default="/">
<cfparam name="Attributes.A_RECURSE" default="S">
<cfparam name="Attributes.A_ABILITAZIONI" default="#Session.S_ABILITAZIONI#">
<cfparam name="Attributes.A_OUTPUT" default="RESULT">

<cfset "caller.#Attributes.A_OUTPUT#"=0>
<cfset res=0>

<cfset match_len=0>
<cfloop list=#Attributes.A_ABILITAZIONI# index="t_quad">
	<cfset a_quad=listtoarray(t_quad,":")>
	<cfif (a_quad[1] is Attributes.A_SERVICE) or (a_quad[1] is "ALL") or (Attributes.A_SERVICE) is "ANY">
		<cfif (a_quad[4] is "S") and (Attributes.A_RECURSE is "S")>
			<cfif find(a_quad[3], Attributes.A_FOLDER) is 1>
				<cfif len(a_quad[3]) gt match_len>
					<cfset res = a_quad[2]>
					<cfset match_len = len(a_quad[3])>
				</cfif>
			</cfif>
		<cfelse>
			<cfif a_quad[3] is Attributes.A_FOLDER>
				<cfif len(a_quad[3]) gt match_len>
					<cfset res = a_quad[2]>
					<cfset match_len = len(a_quad[3])>
				</cfif>
			</cfif>
		</cfif>
	</cfif>
</cfloop>

<cfset "caller.#Attributes.A_OUTPUT#"=res>
