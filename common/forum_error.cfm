
<cfset V_ERROR=CGI.QUERY_STRING>

<!--- inizio nucleo forum --->
<!--- INIZIO CODICE FORUM --->
<table align="center" border="0" width="100%">
  <tr> 
    <td align="center"> 
      <span class="errore">Errore:</span>
      <cfswitch expression=#V_ERROR#>
        <cfcase value="generic">
        <span class="forumTesto1">Elemento non trovato?</span><br>
        </cfcase>
        <cfcase value="empty_obbl_field">
        <span class="forumTesto1">Campo Obbligatorio Vuoto</span><br>
        <span class="forumTesto2">Riempi tutti i campi contrassegnati con l'asterisco</span> 
        </cfcase>
        <cfcase value="empty_oggetto">
        <span class="forumTesto1">Oggetto del messaggio 
        vuoto</span><br>
        <span class="forumTesto2">Inserisci l'oggetto del messaggio nell'apposito campo</span> 
        </cfcase>
        <cfcase value="bad_oggetto">
        <span class="forumTesto1">Oggetto del messaggio non valido</span><br>
        <span class="forumTesto2">Carattere non ammesso nell'oggetto del messaggio</span> 
        </cfcase>
        <cfcase value="empty_body">
        <span class="forumTesto1">Testo del messaggio vuoto</span><br>
        <span class="forumTesto2">Inserisci il testo del messaggio nell'apposito campo</span> 
        </cfcase>
        <cfcase value="bad_body">
        <span class="forumTesto1">Carattere non ammesso nel testo del messaggio</span><br>
        </cfcase>
		<CFCASE VALUE="banned_element">
        <span class="forumTesto1">Elemento HTML non ammesso nel testo del messaggio</span><br>
        </CFCASE>
        <cfcase value="empty_nome">
        <span class="forumTesto1">Nome vuoto</span><br>
        <span class="forumTesto2">Inserisci il tuo nome nell'apposito campo</span> 
        </cfcase>
        <cfcase value="bad_nome">
        <span class="forumTesto1">Nome non valido</span><br>
        <span class="forumTesto2">Carattere non ammesso nel campo Nome</span> 
        </cfcase>
        <cfcase value="cant_post">
        <span class="forumTesto1">Non abilitato</span><br>
        <span class="forumTesto2">Utente non abilitato all'inserimento del messaggio</span> 
        </cfcase>
        <cfcase value="forum_closed">
        <span class="forumTesto1">Forum Chiuso</span><br>
        <span class="forumTesto2">Il forum &egrave; chiuso, non &egrave; pi&ugrave; possibile inserire nuovi messaggi</span> 
        </cfcase>
        <cfcase value="forum_visible_nodel">
        <span class="forumTesto1">Forum Visibile</span><br>
        <span class="forumTesto2">Il forum &egrave; visibile, non &egrave; possibile eliminarlo.</span> 
        </cfcase>
        <cfcase value="forum_open_nodel">
        <span class="forumTesto1">Forum Aperto</span><br>
        <span class="forumTesto2">Il forum &egrave; aperto, non &egrave; possibile eliminarlo.</span> 
        </cfcase>
		<cfcase value="forum_nosel">
        <span class="forumTesto1">Forum non selezionato</span><br>
        <span class="forumTesto2">Devi selezionare un forum.</span> 
        </cfcase>
      </cfswitch>
      <p>
	  <a href="javascript:history.back()" class="forumNav">Torna alla pagina precedente</a>
    </td>
  </tr>
</table>

