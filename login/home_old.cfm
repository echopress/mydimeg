<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>PORTALE UNICAL: Servizi di Amministrazione</title>
    
<style type="text/css">
<!--
.servizi {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 12px;
	color: #000066;
	display:inline;
	float:left;
	width:45%;
	padding: 10px;
	border: 1px dotted #900;
	margin: 10px;
}
.listaservizi {
	width:100%;
	margin-left:auto;
	margin-right:auto;
	border: 1px solid #999;
	padding: 10px;	
}
.footerservizi {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 12px;
	color: #000066;
	display:inline;
	float:left;
	width:100%;
	padding-top: 50px;
	text-align: center;
}

-->
</style>
    
</head>

<body  vlink="Blue" link="Blue" bgcolor="#FFFFFF">

<cfif (not isdefined("Session.S_PER_ID")) or (Session.S_PER_ID is 0)>
	<cflocation url="login.cfm" addtoken="No">
</cfif>

<table border=0 width=100% align="center">
  <tr>
  	<td width="30%">
		<img src="../images/logo_unical_w.gif" border=0 alt="" align="middle"><P>
	</td>

    <td align="center" width="40%">  
        <h1><font color="#000066">Content Management System<br>
          Portale Universit&agrave; della Calabria </font></h1>
    <p> <font color="darkblue" size=3 face="Verdana"> Home Page Amministrazione </font>    </p></td>

  	<td width="30%">&nbsp;
		
	</td>
  </tr>
</table>

<p>&nbsp;</p>

<table border=0 width=70% align="center">
	<tr>
		<td>
			<font color="darkblue" size=3 face="Verdana">
			<cfoutput>
			Benvenuto/a #Session.S_PER_NOME# #Session.S_PER_COGNOME#.<br>
			Il tuo ultimo accesso &egrave; stato #DateFormat(Session.S_PER_LASTLOG,"dddd,dd/mm/yyyy")# #TimeFormat(Session.S_PER_LASTLOG,"HH:mm")#.<br>
			</cfoutput>
			</font>
		</td>
	</tr>
</table>

<div class="listaservizi">
       
      <!--- GESTIONE ELENCO NEWS HP --->
      <cfmodule template="../common/ab_testfolder.cfm" A_SERVICE="HPNEWS" A_FOLDER="/" A_OUTPUT="t_livello">
      <cfif t_livello ge Session.L_PUBLISH>
        <div class="servizi">
            <a href="../adm_newsHP/el_cartelle_hp.cfm" ><img src="../images/ico_elencohp.gif" width="48" height="48" border="1" align="left">Gestione Elenco HP</a>
            <br>(Gestione Del Template Elenco News)
        </div>
      </cfif>
              
	  <!--- GESTIONE NEWS --->
      <cfmodule template="../common/ab_testservice.cfm" A_SERVICE="NEWS" A_OUTPUT="t_livello">
      <cfif t_livello ge Session.L_READ>
          <div class="servizi">
          <a href="../adm_news/el_cartelle.cfm" ><img src="../images/ico_documenti.gif" width="48" height="48" border="1" align="left">Gestione Documenti</a>
          <br>(Inserimento, modifica e aggiornamento di News, Comunicati, Eventi e Links)
		  </div>
      </cfif>              

	  <!--- GESTIONE VERBALI --->
      <cfmodule template="../common/ab_testservice.cfm" A_SERVICE="VERBALI" A_OUTPUT="t_livello">
      <cfif t_livello ge Session.L_PUBLISH>
          <div class="servizi">
          <a href="../adm_verbali/el_cartelle.cfm" ><img src="../images/ico_verbali.png" width="48" height="48" border="1" align="left">Gestione Verbali</a>
          <br>(Gestione Verbali)
		  </div>
      </cfif>
      
      <!--- GESTIONE BANDI ---> 
      <!---<cfmodule template="../common/ab_testfolder.cfm" A_SERVICE="BANDI" A_FOLDER="/" A_OUTPUT="t_livello">--->
	  <cfmodule template="../common/ab_testservice.cfm" A_SERVICE="PROCEDURE" A_OUTPUT="t_livello">
      <cfif t_livello ge Session.L_READ>
      	  <div class="servizi">
		  <a href="../adm_procedure/el_cartelle.cfm"><img src="../images/ico_bandiconcorsi.gif" width="48" height="48" border="1" align="left">Gestione Bandi – Att. Negoziali</a>
          <br>(Inserimento, modifica e aggiornamento di bandi, avvisi di gara, etc.)
          </div>
      </cfif>
      
      <!--- GESTIONE BANDI NEW ---> 
      <!---<cfmodule template="../common/ab_testfolder.cfm" A_SERVICE="BANDI" A_FOLDER="/" A_OUTPUT="t_livello">--->
	  <cfmodule template="../common/ab_testservice.cfm" A_SERVICE="PROCEDURE" A_OUTPUT="t_livello">
      <cfif t_livello ge Session.L_READ>
      	  <div class="servizi">
		  <a href="../adm_procedure_new/el_cartelle.cfm"><img src="../images/ico_bandiconcorsi.gif" width="48" height="48" border="1" align="left">Gestione Bandi – Att. Negoziali NUOVA VERSIONE</a>
          <br>(Inserimento, modifica e aggiornamento di bandi, avvisi di gara, etc.)
          </div>
      </cfif>
      
      
      <!--- GESTIONE CONCORSI ---> 
      <cfmodule template="../common/ab_testfolder.cfm" A_SERVICE="BANDI" A_FOLDER="/ateneo/concorsi/" A_OUTPUT="t_livello">
      <cfif t_livello ge Session.L_READ>
      	  <div class="servizi">
		  <a href="../adm_bandi/el_bandi.cfm"><img src="../images/ico_bandiconcorsi.gif" width="48" height="48" border="1" align="left">Gestione Concorsi</a>
          <br>(Inserimento, modifica e aggiornamento di concorsi, borse di studio, etc.)
          </div>
      </cfif>
      
      <!--- GESTIONE TESI --->
      <cfmodule template="../common/ab_testfolder.cfm" A_SERVICE="TESI" A_FOLDER="/strutture/dipartimenti/deis/" A_OUTPUT="t_livello">
      <cfif t_livello ge Session.L_READ>
          <div class="servizi">
          <a href="../adm_tesi/el_tesi.cfm" ><img src="../images/ico_tesi.gif" width="48" height="48" border="1" align="left">Gestione Tesi, Seminari di Laurea e Proposte di Tesi</a>
      	  <br>(Inserimento, modifica e aggiornamento di Tesi, Seminari di Laurea e Proposte di Tesi) 
          </div>
      </cfif>

	  <!--- GESTIONE ANAGRAFE --->
      <cfmodule template="../common/ab_testservice.cfm" A_SERVICE="ANAG" A_OUTPUT="t_livello">
      <cfif (t_livello ge Session.L_READ) >
          <div class="servizi">
          <a href="../adm_ana/el_cartelle.cfm" ><img src="../images/ico_anagrafica.gif" width="48" height="48" border="1" align="left">Gestione Anagrafe</a>
          <br>(Inserimento, e aggiornamento dell'Anagrafica d'Ateneo)
          </div>
      </cfif>
      
	  <!--- GESTIONE PHONE --->
      <cfmodule template="../common/ab_testservice.cfm" A_SERVICE="ANAG" A_OUTPUT="t_livello">
      <cfif (t_livello ge Session.L_ADMIN) and ((Session.S_PER_USERNAME is "MIMMO") or (Session.S_PER_USERNAME is "SALVIO") or (Session.S_PER_USERNAME is "DIMAIO") or (Session.S_PER_USERNAME is "CIRINO")) >
          <div class="servizi">
          <a href="../adm_phone/el_ana.cfm" ><img src="../images/ico_phone.jpg" width="48" height="48" border="1" align="left">Gestione Elenco Telefonico</a>
          <br>(Inserimento, e aggiornamento dell'Elenco Telefonico d'Ateneo)
          </div>
      </cfif>
      
      
	  <!--- GESTIONE PAGINE --->
      <cfmodule template="../common/ab_testservice.cfm" A_SERVICE="PAGES" A_OUTPUT="t_livello">
		<cfif t_livello ge Session.L_WRITE>
          <div class="servizi">
          <img src="../images/ico_pagine.gif" width="48" height="48" border="1" align="left"> 
            <a href="../adm_pages/el_cartelle.cfm" >Gestione Pagine</a>
            <br>(Configurazione dei templates relativi alle cartelle delle strutture)
          </div>
      	</cfif>
      
		<!--- GESTIONE UTENTI --->
        <cfmodule template="../common/ab_testservice.cfm" A_SERVICE="USERS" A_OUTPUT="t_livello">
        <cfif t_livello ge Session.L_ADMIN>
          <div class="servizi">
          <img src="../images/ico_user_abil.gif" width="48" height="48" border="1" align="left"> 
            <a href="../adm_users/el_cartelle.cfm" >Gestione Utenti-Abilitazioni</a> 
            <br>(Inserimento, e aggiornamento degli utenti abilitati ad usare il sistema di gestione dei contenuti) 
          </div>
        </cfif>	  
      

		<!--- MODIFICA DATI UTENTE --->
        <!---<cfmodule template="../common/ab_testservice.cfm" A_SERVICE="USERS" A_OUTPUT="t_livello">
        <cfif t_livello ge Session.L_ADMIN>--->
        	<div class="servizi">
            <a href="../adm_users/mod_dati_utente.cfm" ><img src="../images/ico_modify.gif" width="48" height="48" border="1" align="left">Modifica dati Utente</a>
            <br>(Modifica dei propri dati Utente)
            </div>
        <!---</cfif>--->

			
	  <!--- GESTIONE NEWSLETTER --->
       <cfmodule template="../common/ab_testfolder.cfm" A_SERVICE="NEWSLETTER"  A_FOLDER="/newsletter/" A_OUTPUT="t_livello">
       <cfif t_livello ge Session.L_READ>
      	  <div class="servizi">
          <a href="../adm_newsletter/el_cartelle.cfm" ><img src="../images/ico_newsletter.gif" width="48" height="48" border="1" align="left">Gestione NewsLetter</a>
          <br>(Impostazione, creazione e gestione NewsLetter)
          </div>
      </cfif>
      
	 <!--- GESTIONE MULTIMEDIA --->
      <cfmodule template="../common/ab_testservice.cfm" A_SERVICE="MEDIA" A_OUTPUT="t_livello">
      <cfif t_livello ge Session.L_READ>  
      <div class="servizi">
      <img src="../images/ico_media.gif" width="48" height="48" border="1" align="left"><a href="../adm_media/el_cartelle.cfm" >
        Gestione Multimedia</a><br>
        (Inserimento, modifica e aggiornamento di foto e video)
      </div>
      </cfif>  

      
      <!--- GESTIONE INDIRIZZARI --->
       <cfmodule template="../common/ab_testservice.cfm" A_SERVICE="INDIRIZZARI" A_OUTPUT="t_livello">
       <cfif t_livello ge Session.L_READ>
         <div class="servizi">
            <a href="../adm_indirizzari/el_cartelle.cfm"><img src="../images/ico_indirizzari.gif" width="48" height="48" border="1" align="left">Gestione Indirizzari</a>
            <br>(Impostazione, creazione e gestione Indirizzari)
         </div>
      </cfif>
				
	 <!--- GESTIONE FORUM --->
     <cfmodule template="../common/ab_testservice.cfm" A_SERVICE="FORUM" A_OUTPUT="t_livello">
     <cfif t_livello ge Session.L_READ>
         <div class="servizi">
        <a href="../adm_forum/el_cartelle.cfm" ><img src="../images/ico_forum.gif" width="48" height="48" border="1" align="left">Gestione Forum</a>
        <br>(Impostazione, moderazione e gestione Forum)
        </div>
    </cfif>
    
     <!--- GESTIONE CHAT --->
     <cfmodule template="../common/ab_testfolder.cfm" A_SERVICE="CHAT" A_FOLDER="/orientamento/inunical/servizi/counselling/" A_OUTPUT="t_livello">
     <cfif t_livello ge Session.L_ADMIN>
         <div class="servizi">
        <a href="../adm_chat/el_cartelle.cfm" ><img src="../images/ico_chat.png" width="48" height="48" border="1" align="left">Gestione Chat</a>
        <br>(Impostazione, moderazione e gestione Forum)
        </div>
    </cfif>              
              

	<!--- GESTIONE FOLDERS --->
    <cfmodule template="../common/ab_testservice.cfm" A_SERVICE="FOLDERS" A_OUTPUT="t_livello">
    <cfif t_livello ge Session.L_WRITE>
      <div class="servizi">
      <img src="../images/ico_folder.gif" width="48" height="48" border="1" align="left"> 
        <a href="../adm_folder/el_folders.cfm" >Gestione Folders</a><br>
        (Inserimento, e Aggiornamento delle cartelle relative alle strutture)
        </div> 
  	</cfif>


	<!--- GESTIONE TEMATICHE --->
    <cfmodule template="../common/ab_testfolder.cfm" A_SERVICE="TEMATICHE" A_FOLDER="/" A_OUTPUT="t_livello">
    <cfif t_livello ge Session.L_ADMIN>
      <div class="servizi">
      <img src="../images/ico_tematiche.gif" width="48" height="48" border="1" align="left">
      <a href="../adm_tema/el_tematiche.cfm" >Gestione Argomenti</a>
      </div>
    </cfif>

    <!--- UTILITY --->
  <cfmodule template="../common/ab_testfolder.cfm" A_SERVICE="UTILITY" A_FOLDER="/" A_OUTPUT="t_livello">
  <cfif t_livello ge Session.L_ADMIN>
      <div class="servizi">
        <img src="../images/ico_utility.gif" width="48" height="48" border="1" align="left"> 
          <a href="../utility/el_news.cfm" >Utility Log Documenti</a>
      </div>
    </cfif>

    <!--- UTILITY --->
	<cfif Session.S_PER_USERNAME is "SALVIO" OR Session.S_PER_USERNAME is "FRAMATO" OR Session.S_PER_USERNAME is "DIMAIO" OR Session.S_PER_USERNAME is "cirino">
    <div class="servizi">
        <a href="../utility/home_utility.cfm" ><img src="../images/ico_utility.gif" width="48" height="48" border="1" align="left">Utility Admin</a>
    </div>
    </cfif>
    
    <!--- Gestione prenotazioni --->
	<cfmodule template="../common/ab_testservice.cfm" A_SERVICE="AULE" A_OUTPUT="t_livello">
        <cfif t_livello ge Session.L_READ>
          <div class="servizi"><img src="../images/gest_docenti.gif" width="48" height="48" border="1" align="left"> 
            <a href="../adm_aule/ad_richieste.cfm">Gestione Prenotazioni</a><br>
            <font color="darkblue" size=1 face="Verdana"> (Visualizza la prenotazione delle aule)</font> 
          </div>
        </cfif>
        
    <cfif Session.S_PER_USERNAME is "cirino">
    <!--- Gestione prenotazioni --->
	<cfmodule template="../common/ab_testservice.cfm" A_SERVICE="AULE" A_FOLDER="/" A_OUTPUT="t_livello">
        <cfif t_livello ge Session.L_READ>
          <div class="servizi"><img src="../images/gest_docenti.gif" width="48" height="48" border="1" align="left"> 
            <a href="../adm_aule/el_cartelle.cfm">Gestione Prenotazioni ADMIN</a><br>
            <font color="darkblue" size=1 face="Verdana"> (Visualizza la prenotazione delle aule)</font> 
          </div>
        </cfif>
    </cfif>    
     
</div>

<div class="footerservizi">
Per maggiore sicurezza ricordati di usare il bottone LOG OFF in fondo alla pagina per terminare la tua sessione di lavoro
<cfinclude template="../common/footer.cfm">
</div>


</body>
</html>
