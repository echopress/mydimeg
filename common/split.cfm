<!--- 
SPLIT.CFM v1.0
Spezza una striga in tre parti
Metodo di chiatata: CFMODULE

A_TEXT:    testo da manipolare (default: "")
A_FILE:    file contenente il testo da manipolare  (default: "") 
           se indicato A_TEXT viene ignorato
A_START:   testo di inizio zona da estrarre
A_STOP:    testo di fine zona da estrarre
A_OUT_PRE, A_OUT_MID, A_OUT_POST: nomi di 3 variabili di output (default: "", RES_MID, "")
A_OUT_ERROR:   nome variabile di output per l'eventuale testo di errore
		   sevuoto non c'e' stato nessun errore (default: RES_ERROR)

Spezza il testo in tre zone:
	PRE: testo prima di A_START
	MID: testo contreso tra A_START e A_STOP
	POST: testo dopo A_STOP
	nota: le sottostringhe A_START e A_STOP non sono restituite in output
 --->

<cfparam name="Attributes.A_TEXT" default="">
<cfparam name="Attributes.A_FILE" default="">
<cfparam name="Attributes.A_START" default="__START__">
<cfparam name="Attributes.A_STOP" default="__STOP__">
<cfparam name="Attributes.A_OUT_PRE" default="">
<cfparam name="Attributes.A_OUT_MID" default="RES_MID">
<cfparam name="Attributes.A_OUT_POST" default="">
<cfparam name="Attributes.A_OUT_ERROR" default="RES_ERROR">

<!--- <cfoutput>
CALL text:#htmlcodeformat(Attributes.A_TEXT)#
start:#htmlcodeformat(Attributes.A_START)#
</cfoutput>
 --->

<cfif Attributes.A_OUT_PRE is not "">
	<cfset "caller.#Attributes.A_OUT_PRE#"="">
</cfif>
<cfset "caller.#Attributes.A_OUT_MID#"="">
<cfif Attributes.A_OUT_POST is not "">
	<cfset "caller.#Attributes.A_OUT_POST#"="">
</cfif>
<cfset "caller.#Attributes.A_OUT_ERROR#"="">

<cfif Attributes.A_FILE is not "">
	<cfif not FileExists(#Attributes.A_FILE#)>
		<cfset "caller.#Attributes.A_OUT_ERROR#"="File not found">
		<cfexit method="ExitTag">
	</cfif>
	<cffile action="READ" file=#Attributes.A_FILE# variable="Attributes.A_TEXT">
</cfif>

<cfif Attributes.A_TEXT is "">
	<cfexit method="ExitTag">
</cfif>	

<cfset l=len(Attributes.A_TEXT)>

<cfset l_start=len(Attributes.A_START)>
<cfset p_start=Find(Attributes.A_START,Attributes.A_TEXT)>
<cfif p_start is 0>
	<cfset "caller.#Attributes.A_OUT_ERROR#"="Start not found">
	<cfexit method="ExitTag">
</cfif>	

<cfset l_stop=len(Attributes.A_STOP)>
<cfset p_stop=Find(Attributes.A_STOP,Attributes.A_TEXT,p_start+l_start)>
<cfif p_stop is 0>
	<cfset "caller.#Attributes.A_OUT_ERROR#"="Stop not found">
	<cfexit method="ExitTag">
</cfif>	

<!---
<cfoutput>
<pre>
text:#htmlcodeformat(Attributes.A_TEXT)#
l:#l#<br>
l_start:#l_start#<br>
p_start:#p_start#<br>
l_stop:#l_stop#<br>
p_stop:#p_stop#<br>
</pre>
</cfoutput>
 --->
<cfif Attributes.A_OUT_PRE is not "">
	<cfif p_start is 1>
		<cfset "caller.#Attributes.A_OUT_PRE#"="">
	<cfelse>
		<cfset "caller.#Attributes.A_OUT_PRE#"=left(Attributes.A_TEXT,p_start-1)>
	</cfif>
</cfif>	

<cfset "caller.#Attributes.A_OUT_MID#"=mid(Attributes.A_TEXT,p_start+l_start,p_stop-p_start-l_start)>

<cfif Attributes.A_OUT_POST is not "">
	<cfif (l-(p_stop+l_stop-1)) is 0>
		<cfset "caller.#Attributes.A_OUT_POST#"="">
	<cfelse>	
		<cfset "caller.#Attributes.A_OUT_POST#"=right(Attributes.A_TEXT,l-(p_stop+l_stop-1))>
	</cfif>	
</cfif>	

<!--- fine --->
