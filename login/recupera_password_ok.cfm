<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<HTML>
<HEAD>
	<TITLE>PORTALE UNICAL: Gestione Utenti</TITLE>
	<link rel=stylesheet type="text/css" href="style.css">
</HEAD>

<cfparam name="Q_PER_EMAIL" default="">
<cfparam name="Q_PER_USERNAME" default="">

<body  vlink="Blue" link="Blue" bgcolor="FFFFFF">

<!--- Controllo Username --->
<!---<cfmodule template="../common/chk_common.cfm" 
	A_TYPE="TEXT"
	A_LABEL="Username"
	A_VALUE=#Q_PER_USERNAME#
	A_REQUIRED="S"
	A_CASE=""
	A_REGEX="[^a-zA-Z0-9]"
	A_OUTPUT="V_PER_USERNAME"
>--->
<!---<cfif V_PER_PASSWORD is not "">
	<cfset V_PER_PASSWORD2=Trim(Q_PER_PASSWORD2)>
	<cfif V_PER_PASSWORD is not V_PER_PASSWORD2>
		<cflocation url="../common/error.cfm?no_match,Password_e_Verifica_Password" addtoken="No">
	</cfif>
</cfif>--->

<!--- Encrypt Password --->
<!---<cfmodule template="..\common\enkript.cfm" A_STRING="#Q_PER_PASSWORD#" A_OUTPUT="V_PER_PASSWORD">--->

<!--- Controllo Username --->
<cfmodule template="../common/chk_common.cfm" 
	A_TYPE="TEXT"
	A_LABEL="Username"
	A_VALUE=#Q_PER_USERNAME#
	A_REQUIRED="S"
	A_CASE=""
	A_REGEX="[^a-zA-Z0-9]"
	A_OUTPUT="V_PER_USERNAME"
>

<!--- Controllo Email --->
<cfmodule template="../common/chk_common.cfm" 
	A_TYPE="EMAIL"
	A_LABEL="E-Mail"
	A_VALUE=#Q_PER_EMAIL#
	A_REQUIRED="S"
	A_CASE="LOWER"
	A_OUTPUT="V_PER_EMAIL"
>	

<cfif Q_PER_USERNAME is "">
	<!--- ACCESSO ANONIMO --->
	<cflocation url="../common/error.cfm?bad_loginrecover" addtoken="NO">
<cfelse>
	<!--- ACCESSO CON USERNAME--->
	<cfquery name="Get_Login" datasource="#APP_DSN#" dbtype="ODBC">
		SELECT * FROM personale 
		WHERE per_username = '#ucase(V_PER_USERNAME)#'
		AND per_email = '#V_PER_EMAIL#'
		AND per_enabled = 'S'
	</cfquery>

	<cfif Get_Login.RecordCount is 0 OR Get_Login.RecordCount gt 1>
		<cflocation url="../common/error.cfm?bad_loginrecover" addtoken="NO">
	</cfif>
	
    
 <cfparam name="attributes.length" default=10>  
 <cfparam name="attributes.varName" default="passwd">  
   
 <cfif isNumeric(attributes.length)>  
     <cfset lunghezza = attributes.length>  
     <cfset varName = attributes.varName>  
 <cfelse>  
     <cfabort showerror="<b>CF_passwdGen</b>: Error in length argument">  
 </cfif>  
   
 <cfset vocali = "a,e,i,o,u">  
 <cfset dittonghi = "ae,ai,ao,au,ea,ei,eo,eu,ia,ie,io,iu,ua,ue,ui,uo">  
   
 <cfset cons = "b,c,d,f,g,h,k,l,n,m,p,q,r,s,t,v,z">  
 <cfset consDoppie = "bb,cc,dd,ff,gg,ll,nn,mm,pp,rr,ss,tt,vv,zz">  
   
 <!--- Suddivido per stare vicino agli 80 caratteri --->  
 <cfset consAmiche="bl,br,ch,cl,cr,dl,dm,dr,fl,fr,gh,gl,gn,gr,lb,lp,ld,lf,lg,lm">  
 <cfset consAmiche=listAppend(consAmiche,"lt,lv,lz,mb,mp,nd,nf,ng,nt,nv,nz,pl,pr,ps")>  
 <cfset consAmiche=listAppend(consAmiche,"rb,rc,rd,rf,rg,rl,rm,rn,rp,rs,rt,rv,rz")>  
 <cfset consAmiche=listAppend(consAmiche,"sb,sc,sd,sf,sg,sl,sm,sn,sp,sr,st,sv,tl,tr,vl,vr")>  
   
   
 <cfset listaVocali = listAppend(vocali,dittonghi)>   
 <cfset listaCons = listAppend(cons,consDoppie)>  
 <cfset listaCons = listAppend(listaCons,consAmiche)>  
   
 <cfset nrVocali = listLen(listaVocali)>  
 <cfset nrConsonanti = listLen(listaCons)>  
   
 <cfset passwd = "">  
 <cfset giri = lunghezza>  
   
 <!--- Decido se iniziare la password con una consonante --->  
 <cfif randRange(1,10) GT 5>  
     <cfset inizioC = "TRUE">  
     <cfset giri = lunghezza -1>  
       
     <!--- La prima lettera deve essere una consonante singola --->      
     <cfset passwd = listGetAt(cons,randRange(1,listLen(cons)))>  
     <cfset passwd = passwd & listGetAt(listaVocali,randRange(1,nrVocali))>  
       
 <cfelse>  
     <cfset inizioC = "FALSE">  
 </cfif>  
   
 <!--- Compongo la password alternando vocali/consonanti --->  
 <cfloop index="counter" from="1" to="#giri#">  
   
     <cfset qualeV = listGetAt(listaVocali,randRange(1,nrVocali))>  
     <cfset qualeC = listGetAt(listaCons,randRange(1,nrConsonanti))>  
       
     <cfif inizioC>  
         <cfset passwd = passwd & qualeC & qualeV>       
     <cfelse>  
         <cfset passwd = passwd & qualeV & qualeC>  
     </cfif>  
       
 </cfloop>  
   
 <!--- Taglio la password al numero massimo di caratteri richiesto --->  
 <cfset passwd = mid(passwd,1,lunghezza)>  
   
 <!--- Controllo e sostituisco eventuali consDoppie alla fine --->  
 <cfloop index="counter" list="#consDoppie#">  
     <cfset result = Find(counter,passwd,(lunghezza-1))>  
     <cfif result>  
         <cfset passwd = removeChars(passwd,(lunghezza-1),1)>  
         <cfset passwd = passwd & listGetAt(vocali,randRange(1,listLen(vocali)))>  
         <cfbreak>  
     </cfif>  
 </cfloop>  

 <!--- Restituisco la password   
 <cfset "caller.#varName#" = passwd>--->
    
	<cfset Session.S_PER_ID=#Get_Login.per_id#>
    <cfset Session.S_PER_USERNAME="#Get_Login.per_username#">
	
</cfif>

<!--- Encrypt Password --->
<cfmodule template="..\common\enkript.cfm" A_STRING="#passwd#" A_OUTPUT="V_PER_PASSWORD">

<!--- Modifica la pasword dell'utente --->
<cfquery name="Modify_Personale" datasource="#APP_DSN#" dbtype="ODBC">
	UPDATE personale SET
		per_password   = '#V_PER_PASSWORD#'
	WHERE per_id = #Get_Login.per_id#
</cfquery>


<cfmail from="#V_ROBOT#" to="#V_PER_EMAIL#" subject="Recupero Password Dimenticata">
     Gentile Utente, 
	 a seguito della sua richiesta di "Password dimenticata"
	 le ricordiamo che la sua nuova PASSWORD è :<cfoutput>#passwd#</cfoutput>
     Se volesse cambiarla può effettuare il login e modificarla dal modulo Modifica Dati Utente.
</cfmail>
	
<!---START SCRIVO LOG--->	
	<cfinvoke
		component="#APP_FOLDERS_COMPONENT#" method="WriteLog" returnVariable="">
		<cfinvokeargument name="v_filename" value="#APP_ADMIN_FOLDERS_ROOT#\log.txt">		
	<!---Scrittura tabella--->
		<cfinvokeargument name="v_appdns" value="#APP_DSN#">
		<cfinvokeargument name="v_oggetto3" value="">
		<cfinvokeargument name="v_folder" value="#Get_Login.per_folder#">
		<cfinvokeargument name="v_tab_cod" value="PERSONALE">
	<!---Fine Scrittura tabella--->		
		<cfinvokeargument name="v_servizio" value="PASSWORD DIMENTICATA">
		<cfinvokeargument name="v_azione" value="PASSWORD DIMENTICATA">
		<cfinvokeargument name="v_oggetto1" value="#Get_Login.per_id#">
		<cfinvokeargument name="v_oggetto2" value="#Get_Login.per_username#">    		
	</cfinvoke>
<!---FINE SCRIVO LOG--->

<cfset V_Titolo_Pagina="Recupero Password">
<cfinclude template="../common/header.cfm">

<center>
<p>
<font size="4" face="verdana, arial" color="black">
Richiesta nuova Password effettuata con successo</font></p>

<p>
  <a href="../login/login.cfm">
    <font style="color:#003366; font-weight:bold; text-decoration:none; font:Arial, Helvetica, sans-serif; font-size:18px; background-color:bgcolor="003366"">Login</font>
  </a>
</p>

</center>
<!---<p>

<input type="button" VALUE="Indietro" onClick="history.back()" class="stybuttons">

</center>
<p>--->

<!---<cfinclude template="../common/footer.cfm">--->
</BODY>
</HTML>
