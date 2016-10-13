<!--- 
GET_TEMPLATE.CFM v2.0
Recupera dati da un template
Metodo di chiatata: CFMODULE

A_FILE:    file del template (required)
A_MODE:    uno tra SHORT (recupera info generiche, default), 
                   FULL (recupera tutto tranne i gadgets)
		   		 e GADGETS (recupera tutto compresi i gadgets)
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
<cfset res.params=StructNew()>

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

<!--- PARAMATRI TEMPLATE VECCHIO FORMATO --->
<cfmodule template="../common/split.cfm"
	A_TEXT=#V_TEMPLATE_TEXT#
	A_START="<!--- TEMPLATE NAME:"
	A_STOP="--->"
	A_OUT_MID="V_VALUE"
>
<cfset x=StructInsert(res.params,"NAME",trim(V_VALUE),"TRUE")>

<cfmodule template="../common/split.cfm"
	A_TEXT=#V_TEMPLATE_TEXT#
	A_START="<!--- TEMPLATE DESCRIPTION:"
	A_STOP="--->"
	A_OUT_MID="V_VALUE"
>
<cfset x=StructInsert(res.params,"DESCRIPTION",trim(V_VALUE),"TRUE")>

<cfmodule template="../common/split.cfm"
	A_TEXT=#V_TEMPLATE_TEXT#
	A_START="<!--- TEMPLATE HELPFILE:"
	A_STOP="--->"
	A_OUT_MID="V_VALUE"
>
<cfset x=StructInsert(res.params,"HELPFILE",trim(V_VALUE),"TRUE")>
<!--- PARAMATRI TEMPLATE VECCHIO FORMATO --->

<!--- PARAMATRI TEMPLATE NUOVO FORMATO --->
<cfmodule template="../common/split.cfm"
	A_TEXT=#V_TEMPLATE_TEXT#
	A_START="<!--- TEMPLATE PARAMS"
	A_STOP="--->"
	A_OUT_MID="V_TEMPLATE_PARAMS"
>

<cfloop condition="V_TEMPLATE_PARAMS is not ''">
 		<cfset v_pos=ReFind("([a-zA-Z][a-z_A-Z0-9]*) *= *(['""`])",V_TEMPLATE_PARAMS,1,"TRUE")>
		<cfif (v_pos.pos[1] is 0)>
			<CFBREAK>
		</cfif>
		<cfset V_PARAM_NAME=ucase(mid(V_TEMPLATE_PARAMS,v_pos.pos[2],v_pos.len[2]))>
		<cfset t_sep=mid(V_TEMPLATE_PARAMS,v_pos.pos[3],1)>
		<cfset p_start=v_pos.pos[3]+1>
		<cfset p_end=find(t_sep,V_TEMPLATE_PARAMS,p_start)>
		<cfif (p_end is 0)>
			<CFBREAK>
		</cfif>
		<cfif p_start is p_end>
			<cfset V_PARAM_VALUE="">
		<cfelse>
			<cfset V_PARAM_VALUE=mid(V_TEMPLATE_PARAMS,p_start,p_end-p_start)>
		</cfif>
		<cfset x=StructInsert(res.params,V_PARAM_NAME,V_PARAM_VALUE,"TRUE")>
		<cfset V_TEMPLATE_PARAMS=mid(V_TEMPLATE_PARAMS,p_end+1,len(V_TEMPLATE_PARAMS))>
		
</cfloop>
<!--- FINE PARAMATRI TEMPLATE NUOVO FORMATO --->

<!--- se il mode e' short abbiamo finito --->
<cfif Attributes.A_MODE is "SHORT">
	<cfset "caller.#Attributes.A_OUTPUT#"=StructCopy(res)>
	<cfset x=StructClear(res)>
	<cfexit method="ExitTag">
</cfif>

<!--- RECUPERA FIELDS --->

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
</cfloop>

<!--- FINE RECUPERA FIELDS --->

<cfset res.numzones="0">
<cfset res.zones=ArrayNew(1)>

<!--- se il mode e' full abbiamo finito --->
<cfif Attributes.A_MODE is "FULL">
	<cfset "caller.#Attributes.A_OUTPUT#"=StructCopy(res)>
	<cfset x=StructClear(res)>
	<cfexit method="ExitTag">
</cfif>

<!--- ZONE E GADGETS --->
<cfset res.numzones="0">
<cfmodule template="../common/split.cfm"
	A_FILE="#Attributes.A_FILE#"
	A_START="<!--- GZONE START "
	A_STOP=" --->"
	A_OUT_MID="V_ZONE_LAB"
	A_OUT_POST="V_ZONES_REST"
>
<cfset p=find("<!--- GZONE STOP #V_ZONE_LAB#",V_ZONES_REST)>
<cfif p is not 0>
	<cfset V_ZONE_REST=left(V_ZONES_REST,p)>
<cfelse>
	<cfset V_ZONE_REST="">
</cfif>

<cfloop condition="V_ZONE_LAB is not ''">
	<cfset nz=res.numzones+1>
	<cfset res.numzones=nz>
	<cfset res.zones[nz]=StructNew()>
	<cfset res.zones[nz].label=V_ZONE_LAB>
	<cfset res.zones[nz].numgadgets=0>
	<cfset res.zones[nz].gadgets=arraynew(1)>
    <cfmodule template="../common/split.cfm"
		A_TEXT=#V_ZONE_REST#
		A_START="<!--- GADGET START "
		A_STOP=" --->"
		A_OUT_MID="V_GADGET_INFO"
		A_OUT_POST="V_GADGET_REST"
	>
	<cfloop condition="V_GADGET_INFO is not ''">
		<cfset ng=res.zones[nz].numgadgets+1>
		<cfset res.zones[nz].numgadgets=ng>
		<cfset res.zones[nz].gadgets[ng]=StructNew()>
		<cfset g_file=trim(listfirst(V_GADGET_INFO,' '))>
		<cfset g_label=trim(listrest(V_GADGET_INFO,' '))>
		
	    <cfset res.zones[nz].gadgets[ng].filename=g_file>
		<cfloop condition="left(g_label,1) is '_'">
			<!--- get NOMOVE, NODELETE and NOCONFIG flags (added 09/12/2004) --->
			<cfset fk=mid(listfirst(g_label,' '),2,20)>
			<cfset x=structinsert(res.zones[nz].gadgets[ng],fk,"Yes")>
			<cfset g_label=trim(listrest(g_label,' '))>
		</cfloop>
		<cfset res.zones[nz].gadgets[ng].label=g_label>
		<cfmodule template="../common/split.cfm"
			A_TEXT=#V_GADGET_REST#
			A_START="<!--- GADGET START "
			A_STOP=" --->"
			A_OUT_MID="V_GADGET_INFO"
			A_OUT_POST="V_GADGET_REST"
		>
	</cfloop>	
	<cfmodule template="../common/split.cfm"
		A_TEXT=#V_ZONES_REST#
		A_START="<!--- GZONE START "
		A_STOP=" --->"
		A_OUT_MID="V_ZONE_LAB"
		A_OUT_POST="V_ZONES_REST"
	>
	<cfset p=find("<!--- GZONE STOP #V_ZONE_LAB#",V_ZONES_REST)>
	<cfif p is not 0>
		<cfset V_ZONE_REST=left(V_ZONES_REST,p)>
	<cfelse>
		<cfset V_ZONE_REST="">
	</cfif>
</cfloop>

<cfset "caller.#Attributes.A_OUTPUT#"=StructCopy(res)>

<!--- fine --->
