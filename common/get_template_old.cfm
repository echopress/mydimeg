<!--- 
GET_TEMPLATE.CFM v1.0
Recupera dati da un template
Metodo di chiatata: CFMODULE

A_FILE:    file del template (required)
A_MODE:    uno tra SHORT (recupera info generiche, default) e FULL (recupera tutto)
A_OUTPUT: nome di una variabile di output
A_OUT_ERROR:   nome variabile di output per l'eventuale testo di errore
		     se vuoto non c'e' stato nessun errore (default: RES_ERROR)

Legge il template e ne restutuisce i dati in una struttura
 --->

<cfparam name="Attributes.A_FILE" default="">
<cfparam name="Attributes.A_MODE" default="SHORT">
<cfparam name="Attributes.A_OUTPUT" default="RESULT">
<cfparam name="Attributes.A_OUT_ERROR" default="RES_ERROR">

<cfset "caller.#Attributes.A_OUTPUT#"="">
<cfset "caller.#Attributes.A_OUT_ERROR#"="">
<cfset res=structnew()>

<cfif Attributes.A_FILE is "">
	<cfset "caller.#Attributes.A_OUT_ERROR#"="No File">
	<cfexit method="ExitTag">
</cfif>

<cfmodule template="../common/split.cfm"
	A_FILE="#Attributes.A_FILE#"
	A_START="<!--- TEMPLATE START --->"
	A_STOP="<!--- TEMPLATE STOP --->"
	A_OUT_MID="V_TEMPLATE_TEXT"
	A_OUT_ERROR="V_ERROR"
>

<cfif V_ERROR is not "">
	<cfset "caller.#Attributes.A_OUT_ERROR#"=V_ERROR>
	<cfexit method="ExitTag">
</cfif>

<cfmodule template="../common/split.cfm"
	A_TEXT=#V_TEMPLATE_TEXT#
	A_START="<!--- TEMPLATE NAME:"
	A_STOP="--->"
	A_OUT_MID="V_VALUE"
>
<cfset res.tpl_name=trim(V_VALUE)>

<cfmodule template="../common/split.cfm"
	A_TEXT=#V_TEMPLATE_TEXT#
	A_START="<!--- TEMPLATE DESCRIPTION:"
	A_STOP="--->"
	A_OUT_MID="V_VALUE"
>
<cfset res.tpl_descr=trim(V_VALUE)>

<cfmodule template="../common/split.cfm"
	A_TEXT=#V_TEMPLATE_TEXT#
	A_START="<!--- TEMPLATE HELPFILE:"
	A_STOP="--->"
	A_OUT_MID="V_VALUE"
>
<cfset res.tpl_helpfile=trim(V_VALUE)>

<!--- se il mode e' short abbiamo finito --->
<cfif Attributes.A_MODE is "SHORT">
	<cfset "caller.#Attributes.A_OUTPUT#"=StructCopy(res)>
	<cfset x=StructClear(res)>
	<cfexit method="ExitTag">
</cfif>

<cfset res.numfields=0>
<cfset res.fields=ArrayNew(1)>
<cfloop condition="TRUE">
	<cfmodule template="../common/split.cfm"
	A_TEXT=#V_TEMPLATE_TEXT#
	A_START="<!--- TEMPLATE FIELD"
	A_STOP="--->"
	A_OUT_MID="V_FIELD_TEXT"
	A_OUT_POST="V_TEMPLATE_TEXT"
	A_OUT_ERROR="V_ERROR"
	>
	<cfif V_ERROR is not "">
		<CFBREAK>
	</cfif>
	<cfset nf=res.numfields+1>
	<cfset res.numfields=nf>
	<cfset res.fields[nf]=StructNew()>
	<cfset x=StructInsert(res.fields[nf],"CONTAINER","CFSET","TRUE")>
	<cfloop condition="V_FIELD_TEXT is not ''">
 		<cfset v_pos=ReFind("([a-zA-Z][a-z_A-Z0-9]*) *= *(['""`])",V_FIELD_TEXT,1,"TRUE")>
		<cfif (v_pos.pos[1] is 0)>
			<CFBREAK>
		</cfif>
		<cfset V_FIELD_NAME=ucase(mid(V_FIELD_TEXT,v_pos.pos[2],v_pos.len[2]))>
		<cfset t_sep=mid(V_FIELD_TEXT,v_pos.pos[3],1)>
		<cfset p_start=v_pos.pos[3]+1>
		<cfset p_end=find(t_sep,V_FIELD_TEXT,p_start)>
		<cfif (p_end is 0)>
			<CFBREAK>
		</cfif>
		<cfif p_start is p_end>
			<cfset V_FIELD_VALUE="">
		<cfelse>
			<cfset V_FIELD_VALUE=mid(V_FIELD_TEXT,p_start,p_end-p_start)>
		</cfif>
		<cfset x=StructInsert(res.fields[nf],V_FIELD_NAME,V_FIELD_VALUE,"TRUE")>
		<cfset V_FIELD_TEXT=mid(V_FIELD_TEXT,p_end+1,len(V_FIELD_TEXT))>

<!--- 		<cfoutput>name:#V_FIELD_NAME#, value:#V_FIELD_VALUE#<br></cfoutput>
 --->
	</cfloop>
	<!--- get current value --->

	<cfset res.fields[nf].field_editable="N">
	<cfswitch expression=#res.fields[nf].CONTAINER#>
		<cfcase value="CFSET">
			<cfset v_pos=refindnocase("<cfset +([a-zA-Z][a-z_A-Z0-9]*) *= *""([^""]*)"" *>",V_TEMPLATE_TEXT,1,"TRUE")>
			<cfif v_pos.pos[1] is not 0>
				<cfset res.fields[nf].VARNAME=mid(V_TEMPLATE_TEXT,v_pos.pos[2],v_pos.len[2])>
				<cfset res.fields[nf].VALUE=mid(V_TEMPLATE_TEXT,v_pos.pos[3],v_pos.len[3])>
				<cfif not StructKeyExists(res.fields[nf],"LABEL")>
					<cfset res.fields[nf].LABEL=res.fields[nf].VARNAME>
				</cfif>
				<cfset res.fields[nf].field_editable="S">
			</cfif>
		</cfcase>
		<cfdefaultcase>
		</cfdefaultcase>

	</cfswitch>
<!--- <cfoutput>#res.fields[nf].VARNAME#=#res.fields[nf].VALUE#</cfoutput>
 --->
</cfloop>

<cfset "caller.#Attributes.A_OUTPUT#"=StructCopy(res)>

<!--- fine --->
