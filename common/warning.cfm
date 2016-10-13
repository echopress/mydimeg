<!--- 
WARNING.CFM v1.0
Visualizza un messaggio di Warning non bloccante
Metodo di chiatata: CFMODULE

A_MESSAGE: messaggio da visualizzare (default: "")
 --->
 
<cfparam name="Attributes.A_MESSAGE" default="">
 
<div align="center">
	<table align="center" cellpadding="2" cellspacing="0" border="0" bordercolor="black" width="90%">
	<tr><td align="center">
	<img src="../images/message.gif" height="20">
	<font face="verdana, arial" size="3" color="Red">
	<b>ATTENZIONE:</b><cfoutput>#Attributes.A_MESSAGE#</cfoutput>
	</font>
	</td></tr>
	</table>
</div>