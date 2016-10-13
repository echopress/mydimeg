<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<HTML>
<HEAD>
	<TITLE>PORTALE UNICAL: Gestione Utenti</TITLE>
	<link rel=stylesheet type="text/css" href="style.css">
</HEAD>

<style type="text/css">
<!--
.styfields{font-family: Verdana; font-size: 8pt; color: black;}
.stybuttons{font-family: Verdana; font-size: 8pt; color: black; font-weight: bold;}
-->
</style>

<body  vlink="Blue" link="Blue" bgcolor="FFFFFF">

<cfset V_Titolo_Pagina="Password Dimenticata">
<cfinclude template="../common/header.cfm">

<center>
<form name="F_Main" method="POST" action="recupera_password_ok.cfm">
	
	<table width="75%" border="0" align="center" cellpadding="0">

<!--- titolo tabella --->
	<tr><td colspan="4">
	<table align="center" border=0 cellspacing="0" cellpadding=0 width="100%">
	<tr><!--- separatore --->
   	   	<td height="1" bgcolor="silver" align="center"><img src="../images/pixel.gif" width="1" height="1"></td>
	</tr>
	<tr>
   	   	<td height="1" bgcolor="silver" align="center"><font size="2" color="800000" face="Verdana, Arial"><b>Dati Account Utente</b></font></td>
	</tr>
	<tr><!--- separatore --->
   	   	<td height="1" bgcolor="silver" align="center"><img src="../images/pixel.gif" width="1" height="1"></td>
	</tr>
	</table>
	</td></tr>
<!--- fine titolo tabella --->

<!---Separatore orizzontale--->
    <tr height="10">
		<td colspan=4></td>
	</tr>
<!---Fine Separatore orizzontale--->
    <tr>
		<td colspan=4>
			<font face="Verdana" size="2" style="color:#FF0000">Inserisci la tua USERNAME e il tuo indirizzo E-MAIL utilizzato in fase di registrazione al portale ed INVIA questi dati, 
			   se entambi risulteranno essere corretti, riceverai una e-mail contenente la tua nuova PASSWORD</font></td>
	</tr>
<!---Separatore orizzontale--->
    <tr height="10">
		<td colspan=4></td>
	</tr>
<!---Fine Separatore orizzontale--->

<tr>
   	<td bgcolor="silver" align="center" colspan="4">&nbsp;</td>
</tr>
<!---Separatore orizzontale--->
    <tr height="10">
		<td colspan=4></td>
	</tr>
<!---Fine Separatore orizzontale--->	
<!--- username e enabled --->
	<tr>
	 	<td align="right" bgcolor="FFFFCC" width="25%">
			<font face="Verdana" size="2"><b>Username</b>:</font>
		</td>
		<td width="25%" align="left" bgcolor="FFFFCC">
			<font face="Verdana" size="2"><input size=10 maxlength=15 name="Q_PER_USERNAME" value=""></font>
		</td>
		<td align="right" bgcolor="FFFFCC" width="25%">
			<img src="../images/bul_busta.gif" border="0" align="absmiddle"><font size=2 face="Verdana, Arial"><b> E-Mail:</b></font>
		</td>
	 	<td width="25%" align="left" bgcolor="FFFFCC">
			<input size=20 maxlength=80 name="Q_PER_EMAIL" value="">
		</td>
	</tr>
	
<!---Separatore orizzontale--->
    <tr height="10">
		<td colspan=4></td>
	</tr>
<!---Fine Separatore orizzontale--->
	
	<tr bgcolor="003366">
	    <td width="25%">&nbsp;</td>
		<td align="center" width="25%">
			<input type="submit" VALUE="Invia Dati" class="stybuttons">
		</td>
		<td align="center" width="25%">	
			<input type="button" VALUE="Annulla" onClick="history.back()" class="stybuttons">
		</td>
		<td width="25%">&nbsp;</td>
	</tr>
	</table>

</form>
</center>

<p>&nbsp;</p>

<!---<cfinclude template="../common/footer.cfm">--->
</BODY>
</HTML>
