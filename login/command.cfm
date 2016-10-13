<style type="text/css">
<!--
.listaservizi {
	width:100%;
	margin-left:auto;
	margin-right:auto;
	border: 1px solid #999;
	padding: 2px;
}

.servizi {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 12px;
	color: #000066;
	display:inline;
	float:left;
	/*padding: 5px;*/
	padding-left:4px;
	padding-right:4px;
	padding-top:4px;
	padding-bottom:4px;
	text-align:center;
}

.servizi a {text-decoration:none;
/*	border:1px solid #ccc;*/
}

.servizi a:hover {
	text-decoration:none;
	background-color:#7DBEFF;
	/*border:1px solid #ccc;*/
}

.icona {
	color: #000066;
	width:32px;
	text-align:center;
	margin-left:auto;
	margin-right:auto;
}

.txt {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 10px;
	color: #000066;
	text-align: center;
}

/*.icona img{
   border: 1px solid #FFFFFF;
}

.icona a:hover {
	border: 1px solid #FF0000;
}*/

-->
</style>

<cfoutput>
	<div style="height:50px; background:##F3F3F3; border:1px solid ##003366; margin-top:2px; width:auto; min-width:50%; float:right;">
      <!--- GESTIONE ELENCO NEWS HP --->
      <cfmodule template="#APP_ADMIN_URL#/common/ab_testfolder.cfm" A_SERVICE="HPNEWS" A_FOLDER="/" A_OUTPUT="t_livello">
      <cfif t_livello ge Session.L_PUBLISH>
        <div class="servizi">
        <div class="icona">
            <a href="#APP_ADMIN_URL#/adm_newsHP/el_cartelle_hp.cfm" >
            <img src="#APP_ADMIN_URL#/images/ico_elencohp.gif" width="32" height="32" border="0" align="left" alt="Gestione Del Template Elenco News"></a>
        </div>
        <div class="txt">Elenco HP</div>
        </div>
      </cfif>


	  <!--- GESTIONE NEWS --->
      <cfmodule template="#APP_ADMIN_URL#/common/ab_testservice.cfm" A_SERVICE="NEWS" A_OUTPUT="t_livello">
      <cfif t_livello ge Session.L_READ>
          <div class="servizi">
          <div class="icona">
          <a href="#APP_ADMIN_URL#/adm_news/el_cartelle.cfm" >
          <img src="#APP_ADMIN_URL#/images/ico_documenti.gif" width="32" height="32" border="0" align="left" alt="Inserimento, modifica e aggiornamento di News, Comunicati, Eventi e Links"></a>
		  </div>
		<div class="txt">Documenti</div>
        </div>
      </cfif>

	  <!--- GESTIONE VERBALI --->
      <cfmodule template="#APP_ADMIN_URL#/common/ab_testservice.cfm" A_SERVICE="VERBALI" A_OUTPUT="t_livello">
      <cfif t_livello ge Session.L_PUBLISH>
          <div class="servizi">
          <div class="icona">
          <a href="#APP_ADMIN_URL#/adm_verbali/el_cartelle.cfm" ><img src="#APP_ADMIN_URL#/images/ico_verbali.png" width="32" height="32" border="0" align="left" alt="Gestione Verbali"></a>
		  </div>
		<div class="txt">Verbali</div>
        </div>
      </cfif>

      <!--- GESTIONE CONCORSI --->
      <cfmodule template="#APP_ADMIN_URL#/common/ab_testfolder.cfm" A_SERVICE="BANDI" A_FOLDER="/" A_OUTPUT="t_livello">
      <cfif t_livello ge Session.L_READ>
      	  <div class="servizi">
          <div class="icona">
          <a href="#APP_ADMIN_URL#/adm_bandi/el_bandi.cfm" ><img src="#APP_ADMIN_URL#/images/ico_bandiconcorsi.gif" width="32" height="32" border="0" align="left" alt="Gestione Concorsi"></a>
          </div>
		<div class="txt">Concorsi</div>
        </div>
      </cfif>
      
      <!--- GESTIONE BANDI --->
      <cfmodule template="#APP_ADMIN_URL#/common/ab_testservice.cfm" A_SERVICE="PROCEDURE" A_FOLDER="/procedure/" A_OUTPUT="t_livello">
      <cfif t_livello ge Session.L_READ>
      	  <div class="servizi">
          <div class="icona">
          <a href="#APP_ADMIN_URL#/adm_procedure/el_cartelle.cfm" ><img src="#APP_ADMIN_URL#/images/ico_bandiconcorsi.gif" width="32" height="32" border="0" align="left" alt="Gestione Bandi - AAN"></a>
          </div>
		<div class="txt">Bandi</div>
        </div>
      </cfif>

      <!--- GESTIONE TESI --->
      <cfmodule template="#APP_ADMIN_URL#/common/ab_testfolder.cfm" A_SERVICE="TESI" A_FOLDER="/strutture/dipartimenti/deis/" A_OUTPUT="t_livello">
      <cfif t_livello ge Session.L_READ>
          <div class="servizi">
          <div class="icona">
          <a href="#APP_ADMIN_URL#/adm_tesi/el_tesi.cfm" ><img src="#APP_ADMIN_URL#/images/ico_tesi.gif" width="32" height="32" border="0" align="left" alt="Gestione Tesi, Seminari di Laurea e Proposte di Tesi"></a>
          </div>
		<div class="txt">Tesi</div>
        </div>
      </cfif>

	  <!--- GESTIONE ANAGRAFE --->
      <cfmodule template="#APP_ADMIN_URL#/common/ab_testservice.cfm" A_SERVICE="ANAG" A_OUTPUT="t_livello">
      <cfif (t_livello ge Session.L_READ) >
          <div class="servizi">
          <div class="icona">
          <a href="#APP_ADMIN_URL#/adm_ana/el_cartelle.cfm" ><img src="#APP_ADMIN_URL#/images/ico_anagrafica.gif" width="32" height="32" border="0" align="left" alt="Gestione Anagrafe:Inserimento, e aggiornamento dell'Anagrafica d'Ateneo"></a>
          </div>
		<div class="txt">Anagrafe</div>
        </div>
      </cfif>

	  <!--- GESTIONE PHONE --->
      <cfmodule template="#APP_ADMIN_URL#/common/ab_testservice.cfm" A_SERVICE="ANAG" A_OUTPUT="t_livello">
      <cfif (t_livello ge Session.L_ADMIN) and ((Session.S_PER_USERNAME is "MIMMO") or (Session.S_PER_USERNAME is "SALVIO") or (Session.S_PER_USERNAME is "DIMAIO")) >
          <div class="servizi">
          <div class="icona">
          <a href="#APP_ADMIN_URL#/adm_phone/el_ana.cfm" ><img src="#APP_ADMIN_URL#/images/ico_phone.jpg" width="32" height="32" border="0" align="left" alt="Gestione Elenco Telefonico"></a>
          </div>
		<div class="txt">Rubrica</div>
        </div>
      </cfif>

	  <!--- GESTIONE NEWSLETTER --->
       <cfmodule template="#APP_ADMIN_URL#/common/ab_testfolder.cfm" A_SERVICE="NEWSLETTER"  A_FOLDER="/newsletter/" A_OUTPUT="t_livello">
       <cfif t_livello ge Session.L_READ>
      	  <div class="servizi">
          <div class="icona">
          <a href="#APP_ADMIN_URL#/adm_newsletter/el_cartelle.cfm" ><img src="#APP_ADMIN_URL#/images/ico_newsletter.gif" width="32" height="32" border="0" align="left" alt="Gestione NewsLetter"></a>
          </div>
		<div class="txt">NewsLetter</div>
        </div>
      </cfif>

      <!--- GESTIONE INDIRIZZARI --->
       <cfmodule template="#APP_ADMIN_URL#/common/ab_testservice.cfm" A_SERVICE="INDIRIZZARI" A_OUTPUT="t_livello">
       <cfif t_livello ge Session.L_READ>
         <div class="servizi">
          <div class="icona">
            <a href="#APP_ADMIN_URL#./adm_indirizzari/el_cartelle.cfm"><img src="#APP_ADMIN_URL#/images/ico_indirizzari.gif" width="32" height="32" border="0" align="left" alt="Gestione Indirizzari"></a>
         </div>
		<div class="txt">Indirizzari</div>
        </div>
      </cfif>

	 <!--- GESTIONE FORUM --->
     <cfmodule template="#APP_ADMIN_URL#/common/ab_testservice.cfm" A_SERVICE="FORUM" A_OUTPUT="t_livello">
     <cfif t_livello ge Session.L_READ>
         <div class="servizi">
          <div class="icona">
        <a href="#APP_ADMIN_URL#/adm_forum/el_cartelle.cfm" ><img src="#APP_ADMIN_URL#/images/ico_forum.gif" width="32" height="32" border="0" align="left" alt="Gestione Forum"></a>
        </div>
		<div class="txt">Forum</div>
        </div>
    </cfif>

     <!--- GESTIONE CHAT --->
     <cfmodule template="#APP_ADMIN_URL#/common/ab_testfolder.cfm" A_SERVICE="CHAT" A_FOLDER="/orientamento/inunical/servizi/counselling/" A_OUTPUT="t_livello">
     <cfif t_livello ge Session.L_ADMIN>
         <div class="servizi">
          <div class="icona">
        <a href="#APP_ADMIN_URL#/adm_chat/el_cartelle.cfm" ><img src="#APP_ADMIN_URL#/images/ico_chat.png" width="32" height="32" border="0" align="left" alt="Gestione Chat"></a>
        </div>
		<div class="txt">Chat</div>
        </div>
    </cfif>



	<!--- GESTIONE PAGINE --->
	<cfmodule template="#APP_ADMIN_URL#/common/ab_testservice.cfm" A_SERVICE="PAGES" A_OUTPUT="t_livello">
	<cfif t_livello ge Session.L_ADMIN>
	<div class="servizi">
		<div class="icona">
		   <a href="#APP_ADMIN_URL#/adm_pages/el_cartelle.cfm" title="Gestione Pagine"><img src="#APP_ADMIN_URL#/images/ico_pagine.png" width="32" height="32" border="0" align="left" alt="Gestione Pagine"></a>
		</div>
		<div class="txt"><a href="#APP_ADMIN_URL#/adm_pages/el_cartelle.cfm" title="Gestione Pagine">Pagine</a></div>
	</div>
	</cfif>

	<!--- GESTIONE FOLDERS --->
	<cfmodule template="#APP_ADMIN_URL#/common/ab_testservice.cfm" A_SERVICE="FOLDERS" A_OUTPUT="t_livello">
	<cfif t_livello ge Session.L_ADMIN>
	<div class="servizi">
		<div class="icona">
		   <a href="#APP_ADMIN_URL#/adm_folder/el_folders.cfm" title="Gestione Folders"><img src="#APP_ADMIN_URL#/images/ico_folder.png" width="32" height="32" border="0" align="left" alt="Gestione Folders"></a>
		</div>
		<div class="txt"><a href="#APP_ADMIN_URL#/adm_folder/el_folders.cfm" title="Gestione Folders">Folders</a></div>
	</div>
	</cfif>

	<!--- GESTIONE UTENTI --->
	<cfmodule template="#APP_ADMIN_URL#/common/ab_testservice.cfm" A_SERVICE="USERS" A_OUTPUT="t_livello">
	<cfif t_livello ge Session.L_ADMIN>
	<div class="servizi">
		<div class="icona">
		   <a href="#APP_ADMIN_URL#/adm_users/el_cartelle.cfm" title="Gestione Utenti"><img src="#APP_ADMIN_URL#/images/ico_user_abil.png" width="32" height="32" border="0" align="left" alt="Gestione Utenti"></a>
		</div>
		<div class="txt"><a href="#APP_ADMIN_URL#/adm_users/el_cartelle.cfm" title="Gestione Utenti">Utenti</a></div>
	</div>
	</cfif>

	<!--- UTILITY --->
	<cfmodule template="#APP_ADMIN_URL#/common/ab_testfolder.cfm" A_SERVICE="UTILITY" A_FOLDER="/" A_OUTPUT="t_livello">
	<cfif t_livello ge Session.L_ADMIN>
	<div class="servizi">
		<div class="icona">
		   <a href="#APP_ADMIN_URL#/utility/home_utility.cfm" title="Utility"><img src="#APP_ADMIN_URL#/images/ico_utility.png" width="32" height="32" border="0" align="left" alt="Utility"></a>
		</div>
		<div class="txt"><a href="#APP_ADMIN_URL#/utility/home_utility.cfm" title="Utility">Utility2</a></div>
	</div>
	</cfif>

	<!--- UTILITY --->
	<cfmodule template="#APP_ADMIN_URL#/common/ab_testfolder.cfm" A_SERVICE="PASSWORD" A_FOLDER="/" A_OUTPUT="t_livello">
	<cfif t_livello ge Session.L_READ>
	<div class="servizi">
		<div class="icona">
		   <a href="#APP_ADMIN_URL#/adm_users/mod_dati_utente.cfm" title="Modifica Password"><img src="#APP_ADMIN_URL#/images/ico_password.png" width="32" height="32" border="0" align="left" alt="Utility"></a>
		</div>
		<div class="txt"><a href="#APP_ADMIN_URL#/adm_users/mod_dati_utente.cfm" title="Modifica Password">Password</a></div>
	</div>
	</cfif>
    
    <!--- Gestione prenotazioni --->
	<cfmodule template="../common/ab_testservice.cfm" A_SERVICE="AULE" A_OUTPUT="t_livello">
        <cfif t_livello ge Session.L_READ>
        <div class="servizi">
          <div class="icona"> 
            <a href="#APP_ADMIN_URL#/adm_aule/ad_richieste.cfm" title="Prenotazione Aule"><img src="#APP_ADMIN_URL#/images/gest_docenti.gif" width="32" height="32" border="0" align="left"></a>
          </div>
          <div class="txt"><a href="#APP_ADMIN_URL#/adm_aule/ad_richieste.cfm" title="Prenotazione Aule">Prenotazione Aule</a></div>
        </div>
        </cfif>


</div>
</cfoutput>

