<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>ERRORE</title>
</head>


<body bgcolor="white">


<cfset V_ERROR=ListFirst(CGI.QUERY_STRING)>
<cfset V_PARAM=Replace(ListLast(CGI.QUERY_STRING),"_"," ","ALL")>

<cfset V_Titolo_Pagina="Rilevato Errore">
<!---<cfinclude template="../common/header.cfm">--->

<center><p>
<table width="600" border="0" cellspacing="1" cellpadding="1" align="center">
<tr>
	<td colspan="1" align="center" bgcolor="0000A0">
		<font face="verdana, arial" size="2" color="White">
		<b>AMMINISTRAZIONE PORTALE UNICAL - ERRORE</b>
		</font>
	</td>
</tr>

<tr>
	<td colspan="1" align="center" bgcolor="FFFFCC">
	<img src="../images/message.gif"> 
	<font face="Verdana, Arial, Helvetica" size="5" color="maroon">Attenzione:</font>
	</td>
</tr>

<tr>
	<td colspan="1" align="center" bgcolor="EFEFEF">

<cfoutput>
<CFSWITCH EXPRESSION=#V_ERROR#>
<!--- errori generici --->
        <CFCASE VALUE="empty_field">
			<font face="Verdana, Arial, Helvetica" size="4" color="black">Campo obbligatorio vuoto</font><br>
			<font face="Verdana, Arial, Helvetica" size="3" color="black">Inserisci un valore nel campo <b>#V_PARAM#</b></font>
        </CFCASE>
        <CFCASE VALUE="bad_char">
			<font face="Verdana, Arial, Helvetica" size="4" color="black">Carattere non ammesso</font><br>
			<font face="Verdana, Arial, Helvetica" size="3" color="black">Il campo <b>#V_PARAM#</b> contiene un carattere non ammissibile</font>
        </CFCASE>
        <CFCASE VALUE="bad_date">
			<font face="Verdana, Arial, Helvetica" size="4" color="black">Data non valida</font><br>
			<font face="Verdana, Arial, Helvetica" size="3" color="black">Il formato della data nel campo <b>#V_PARAM#</b> non e' valido, usa il formato gg/mm/aaaa</font>
        </CFCASE>
        <CFCASE VALUE="bad_time">
			<font face="Verdana, Arial, Helvetica" size="4" color="black">Ora non valida</font><br>
			<font face="Verdana, Arial, Helvetica" size="3" color="black">Il formato dell'ora nel campo <b>#V_PARAM#</b> non e' valido, usa il formato hh:mm</font>
        </CFCASE>
        <CFCASE VALUE="bad_range">
			<font face="Verdana, Arial, Helvetica" size="4" color="black">Valore fuori range</font><br>
			<font face="Verdana, Arial, Helvetica" size="3" color="black">Il campo <b>#V_PARAM#</b> contiene un valore che e' al di fuori dell'intervallo dei valori ammissibili</font>
        </CFCASE>
        <CFCASE VALUE="bad_value">
			<font face="Verdana, Arial, Helvetica" size="4" color="black">Valore non ammesso</font><br>
			<font face="Verdana, Arial, Helvetica" size="3" color="black">Il campo <b>#V_PARAM#</b> contiene un valore non ammesso</font>
        </CFCASE>
        <CFCASE VALUE="bad_format">
			<font face="Verdana, Arial, Helvetica" size="4" color="black">Formato non valido</font><br>
			<font face="Verdana, Arial, Helvetica" size="3" color="black">Il formato del campo <b>#V_PARAM#</b> non e' valido</font>
        </CFCASE>
        <CFCASE VALUE="bad_len">
			<font face="Verdana, Arial, Helvetica" size="4" color="black">Lunghezza non valida</font><br>
			<font face="Verdana, Arial, Helvetica" size="3" color="black">La lunghezza del valore inserito nel campo <b>#V_PARAM#</b> non e' valida</font>
        </CFCASE>
        <CFCASE VALUE="no_match">
			<font face="Verdana, Arial, Helvetica" size="4" color="black">Valori non compatibili</font><br>
			<font face="Verdana, Arial, Helvetica" size="3" color="black">I valori inseriti in <b>#V_PARAM#</b> non sono compatibili</font>
        </CFCASE>
        <CFCASE VALUE="key_exist">
			<font face="Verdana, Arial, Helvetica" size="4" color="black">Valore univoco gia' esistente</font><br>
			<font face="Verdana, Arial, Helvetica" size="3" color="black">Il campo chiave <b>#V_PARAM#</b> contiene un valore già esistente, scegli un altro valore</font>
        </CFCASE>
        <CFCASE VALUE="ref_notexist">
			<font face="Verdana, Arial, Helvetica" size="4" color="black">Riferimento mancante</font><br>
			<font face="Verdana, Arial, Helvetica" size="3" color="black">Il valore di <b>#V_PARAM#</b> non trova riscontro nel database,<br> il relativo oggetto potrebe essere stato cancellato</font>
        </CFCASE>
        <CFCASE VALUE="sel_notexist">
			<font face="Verdana, Arial, Helvetica" size="4" color="black">Oggetto selezionato non trovato</font><br>
			<font face="Verdana, Arial, Helvetica" size="3" color="black">L'oggetto selezionato (#V_PARAM#) non e' stato trovato nel database,<br> l'oggetto potrebe essere stato cancellato</font>
        </CFCASE>
        <CFCASE VALUE="obj_notexist">
			<font face="Verdana, Arial, Helvetica" size="4" color="black">Oggetto non trovato</font><br>
			<font face="Verdana, Arial, Helvetica" size="3" color="black">L'oggetto <b>#V_PARAM#</b> non e' stato trovato nel database,<br> l'oggetto potrebe essere stato cancellato</font>
        </CFCASE>
        <CFCASE VALUE="bad_login">
			<font face="Verdana, Arial, Helvetica" size="4" color="black">Username o Password Errata</font><br>
			<font face="Verdana, Arial, Helvetica" size="3" color="black">Assicurati che il tasto BLOCCA MAIUSCOLE non sia attivo.
			</font>
        </CFCASE>
        <CFCASE VALUE="bad_user_login">
			<font face="Verdana, Arial, Helvetica" size="4" color="black">Utente già connesso con l'USERNAME specificata</font><br>
			<font face="Verdana, Arial, Helvetica" size="3" color="black">Non è possibile accedere da due PC con la stessa USERNAME.<br>
			Si consiglia di utilizzare il tasto LOGOUT per uscire dall'applicazione.
			</font>
        </CFCASE>			        
        <CFCASE VALUE="no_auth">
			<font face="Verdana, Arial, Helvetica" size="4" color="black">Utente non Abilitato</font><br>
			<font face="Verdana, Arial, Helvetica" size="3" color="black">Per usare la funzione richiesta (#V_PARAM#) è necessaria un'abilitazione.<br>
			Contattare il gestore del sistema per ulteriori chiarimenti.
			</font>
        </CFCASE>
        <CFCASE VALUE="no_auth_zone">
			<font face="Verdana, Arial, Helvetica" size="4" color="black">Utente non Abilitato</font><br>
			<font face="Verdana, Arial, Helvetica" size="3" color="black">Non sei abilitato ad usare la funzione richiesta in questa zona di protezione (#V_PARAM#).<br>
			Contattare il gestore del sistema per ulteriori chiarimenti.
			</font>
        </CFCASE>
        <CFCASE VALUE="no_allow">
			<font face="Verdana, Arial, Helvetica" size="4" color="black">Terminale non Abilitato</font><br>
			<font face="Verdana, Arial, Helvetica" size="3" color="black">Per accedere al sistema è necessario usare un terminale abilitato.<br>
			Contattare il gestore del sistema per ulteriori chiarimenti.
			</font>
        </CFCASE>
        <CFCASE VALUE="fatal">
			<font face="Verdana, Arial, Helvetica" size="4" color="black">Errore irreversibile</font><br>
			<font face="Verdana, Arial, Helvetica" size="3" color="black">Si è verificato un errore irreversibile nel sistema.<br>
			Chiudere tutte le applicazioni e riavviare il computer.
			</font>
        </CFCASE>
        <CFCASE VALUE="code">
			<font face="Verdana, Arial, Helvetica" size="4" color="black">Errore</font><br>
			<font face="Verdana, Arial, Helvetica" size="3" color="black">Errore di flusso del codice (#V_PARAM#).</font>
        </CFCASE>
        <CFCASE VALUE="modifica_aula">
			<font face="Verdana, Arial, Helvetica" size="4" color="black">Errore</font><br>
			<font face="Verdana, Arial, Helvetica" size="3" color="black">L'Aula selezionata non pu&oacute; essere prenotata perch&eacute; la data odierna &eacute; troppo vicina a quella di prenotazione.</font>
        </CFCASE>
<!--- FINE errori generici --->

<!--- errori specifici --->
<!--- gli errori specifici dei servizi si trovano nelle cartelle ../adm_servizio --->
<!--- FINE errori specifici --->
		
</CFSWITCH>
</cfoutput>

	</tr>
	<tr bgcolor="808080"> 
		<td colspan=1 width="600"><img src="../images/wspace.gif" width=600 height=1 border=0 alt=""></td>
	</tr>
</table>


<p>
   <form>
	<INPUT TYPE="button" VALUE="<< Torna alla pagina precedente"  OnClick="history.back()">
   </form>

</center>

<!---<cfinclude template="../common/footer.cfm">--->

</body>
</html>
