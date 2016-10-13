<CFSET oralocale = SetLocale ("Italian (Standard)") >
<table bgcolor="#003366" border=0 width=100% align="center" cellpadding="0" cellspacing="0">
<tr>
<cfoutput>
	<td width="10%" height="30"><p>&nbsp;</p></td>
	<td width="23%">
	<font color="##ffcc00" size=2 face="Verdana, arial">
	<cfif isdefined("Session.S_PER_ID") and (Session.S_PER_ID neq 0)>
		#Session.S_PER_NOME# #Session.S_PER_COGNOME#
	</cfif>
	</font>
	</td>
	<td align="center" width="34%">
		<font color="##ffcc00" size=2 face="Verdana, arial">#V_Titolo_Pagina#</font>
	</td>	
	<td align="right">
		<font color="##FFFF00" size=2 face="Verdana, arial">#LSDateFormat(Now(), "dddd dd mmmm yyyy")# - #TimeFormat(Now(), "HH:mm")#</font>
	</td>
</cfoutput>
</tr>
</table>

<!---Menu COMANDI--->
<cfif isdefined("Session.S_PER_ID") and (Session.S_PER_ID neq 0)>
<table border=0 width=100% cellpadding="0" cellspacing="0">
	<tr>
	    <!---Barra Menu COMANDI--->
		<td align="right"><cfinclude template="../login/command.cfm"></td>
		<!---Fine Barra Menu COMANDI--->
	</tr>
</table>
</cfif>
<p></p>
