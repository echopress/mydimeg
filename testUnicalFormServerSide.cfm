<cfset xmlDocument = '<?xml version="1.0" encoding="UTF-8"?>' >

<cfset fisrtName="#FORM.FirstName#" >
<cfset account="#FORM.account#" >
<cfset filePDF="#FORM.filePDF#" >

<cfif fisrtName IS NOT "">

	<cfset xmlDocument = xmlDocument & '<PatientRecord><Name>' & "#FORM.FirstName#" & '</Name>' >	

</cfif>



<cfif account IS NOT "">

	<cfset xmlDocument = xmlDocument & '<Account id="acct">' & "#FORM.account#" & '</Account>' >	

</cfif>



<cfif filePDF IS NOT "">

    <cffile
        action="UPLOAD"
        filefield="Form.filePDF"
        destination="D:\WWW\mydimeg\portale_admin\"
        nameconflict="MAKEUNIQUE">
        
        
	<cfset Uploaded_File_Name = CFFile.ClientFile>
   
    <cfset fileUrl = "D:\WWW\mydimeg\portale_admin\" & "#Uploaded_File_Name#" >   
    <cfoutput>#fileUrl#</cfoutput>
     
	<!--- Read in a binary data file. ---> 
    <cffile action="readbinary"  file = "#fileUrl#" variable = "binimage"> 
    
    <!--- Convert the read data to binary encoding ---> 
    <cfscript> 
        binencode = BinaryEncode(binimage, "Base64");
    </cfscript> 
    
    
     <cfset xmlDocument = xmlDocument & '<AttachBase64Econcode>' & "#binencode#" & '</AttachBase64Econcode>' >	

   <!--- <cfset xmlDocument = xmlDocument & '#binencode#' >--->
    
   
        
</cfif>



<cfset xmlDocument = xmlDocument & '</PatientRecord>' >


<!--- Creazione documento XML da firmare --->
<cfset myXMLDocument = XmlParse(xmlDocument)>
<cfset XMLText=ToString(myXMLDocument)>
<cffile action="write" file="D:\WWW\mydimeg\portale_admin\tommy-xml-form2.xml" output="#XMLText#">







<HTML> 
<HEAD> 

<TITLE>Form to Sign</TITLE> 

<script type="text/javascript">

	function login(){ 

		var pin = document.myForm.pin.value;
		var urlToSigning = "http://svilmydimeg.echopress.it/portale_admin/tommy-xml-form2.xml";	
		var cfmScriptToSigned =  "http://svilmydimeg.echopress.it/portale_admin/testHTTPUnical.cfm?val1=nomefileMultiSign";	
		
        //alert(pin);			
		LoginSicuroApplet.loginSicuroXml(pin, urlToSigning, cfmScriptToSigned);
		
		document.myForm.pin.value="";
	  
	} 
	  
	  	function setPrivateKey(pin){ 

		document.myForm.textAreaPrivateKey.value= pin;
	    //alert("setPrivateKey: "+pin);
	  
	  } 
	  
	  	function setCertificato(pin){ 

		document.myForm.textAreaCertificato.value= pin;
	    //alert("setCertificato: "+pin);
	  
	  } 
	  
	  function pinErrato(){
		
	    alert("Attenzione: pin errato!");
	  
	  }
	  
	  function firmaXmlOK(){
	  
	  alert("Documento firmato con successo!");
	  document.myForm.pin.value="";
	  
	  location.href = "http://svilmydimeg.echopress.it/portale_admin/login/login.html";
	  
	}//pinErrato

</script>

</HEAD> 

<BODY> 


	<form name=myForm action=""> 
			
		<input type = "password" name = "pin" id = "pin"> 
		<input type=button value="Sign" onClick="login();">
			
	</form>

	<APPLET codebase="http://svilmydimeg.echopress.it/portale_admin" archive="LoginSicuroApplet.jar" CODE="com.loginsicuro/LoginSicuroAppletEnveloped.class" name="loginApplet" id="LoginSicuroApplet" WIDTH="400" HEIGHT="50"></APPLET> 
	
</BODY> 

</HTML>