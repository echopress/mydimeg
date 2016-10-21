<cfset fileUrl = "" >
<cfset xmlBinenCode = "" >
 
 
<cfif filePDF IS NOT "">

    <cffile
        action="UPLOAD"
        filefield="Form.filePDF"
        destination="D:\WWW\mydimeg\portale_admin\"
        nameconflict="MAKEUNIQUE">
        
        
	<cfset Uploaded_File_Name = CFFile.ClientFile>
   
    <cfset fileUrl = "D:\WWW\mydimeg\portale_admin\" & "#Uploaded_File_Name#" >   
    
     
	<!--- Read in a binary data file. ---> 
    <cffile action="readbinary"  file = "#fileUrl#" variable = "binimage"> 
    
    <!--- Convert the read data to binary encoding ---> 
    <cfscript> 
        binencode = BinaryEncode(binimage, "Base64");
    </cfscript> 
    
  
     
     <cfset xmlBinenCode = '<AttachBase64Econcode>' & "#binencode#" & '</AttachBase64Econcode>' >
        
</cfif>




<ul>
    <cfoutput>
    <cfset v_temp = '<?xml version="1.0" encoding="UTF-8"?>' & '<#FORM.nomeForm#>'>
    <cfset v_temp_tot="">
    
     <cfset v_temp_tot=v_temp_tot&v_temp>  
     
        <cfloop list="#form.fieldNames#" index="i">
           
                  <cfif len(trim(form[i])) neq 0>
                					              
                      <cfif (#i# IS NOT "SUBMITFORM") AND (#i# IS NOT "FILEPDF") AND (#i# IS NOT "NOMEFORM") >
                                                  
                           <cfset v_temp="<"&#LCase(i)#&">#FORM[i]#</"&#LCase(i)#&">" >
                           
                           <cfset v_temp_tot=v_temp_tot&v_temp>  
                       
                      </cfif>    
         
                
               </cfif>
             
        </cfloop>
        
        
		<cfset v_temp_tot=v_temp_tot &  xmlBinenCode >         
      
         
        <cfset v_temp_tot=v_temp_tot & "</#FORM.nomeForm#>">  
        
       
        <!--- scrivo file xml generato dalla form su disco --->
       <cfset nomeFile  = "D:\WWW\mydimeg\portale_admin\" & "#FORM.nomeForm#" & ".xml">      
        <!--- <cffile action="write" file = "#nomeFile#" output="#v_temp_tot#">--->
        
       
        
    </cfoutput>
    
</ul>

<HTML> 
<HEAD> 

<TITLE>Form to Sign</TITLE> 

<script type="text/javascript">


	  
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
	  
	  function firmaXmlOK(data){
	  
	  //alert(data);
	  document.myForm.pin.value="";

	  //JS_WriteQuery();
	  //location.href = "http://svilmydimeg.echopress.it/portale_admin/login/login.html";
	  
	}//firmaXmlOK
	


</script>

</HEAD> 

<BODY> 

<cfset postData="">


    <table width="500" border="1" cellpadding="0">
       
             
              <cfloop list="#form.fieldNames#" index="i">
              
                 <cfoutput>
                  <tr>
                  
                     <th>#i#</th>
                     
                     <td>
                     
                     <cfif #i# eq "StartDate" >
                     
                     #DateFormat(form[i])#
                     
                     <cfelse>
                     
                     #form[i]#
                     
                      </cfif>
                     
                     </td>                 
                                      
                  </tr>
                  
                  <cfset postData = postData & "$" & "#form[i]#" >
                 
                 </cfoutput>
                 
              </cfloop>
              
          <cfoutput>   
        #postData#
         </cfoutput>
        
    </table>
    
<br /><br />

	<form name=myForm action=""> 
			
		<input type = "password" name = "pin" id = "pin"> 
		<input type=button value="Salva e Firma" onClick="salvaAndFirma();">
        <input type=button value="Salva" onClick="salva();">
       
			
	</form>

	<APPLET codebase="http://svilmydimeg.echopress.it/portale_admin" archive="LoginSicuroApplet.jar" CODE="com.loginsicuro/LoginSicuroAppletEnveloped.class" name="loginApplet" id="LoginSicuroApplet" WIDTH="400" HEIGHT="50"></APPLET> 
    
    <script>
	
	  function salva(){ 
  
	 	  
		  var dataToSend = {
			
			'Q_QUERY' : '<cfoutput>#postData#</cfoutput>',
			'Q_NOME_FORM' : '<cfoutput>#FORM.nomeForm#</cfoutput>',
            'Q_V_TEMP_TOT' : '<cfoutput>#v_temp_tot#</cfoutput>'
			
		  };
		
			
		$.ajax({
			
			type:"POST",	
			url:"writeDB.cfm",		
			data: dataToSend,
			cache:false,
			timeout:120000,
			async:false,		
			
			success:function(data){
			
			  alert("Dati inviati con successo!");
							
			},
			
			error:function(data){
				
			   alert("Errore nella connessione al server!");
			  
			   //location.reload(true);
						  
			}
		
		});//end ajax_call
  
      }//salva
  
  
  
  	function salvaAndFirma(){ 
	
			
		salva();	
		

		var pin = document.myForm.pin.value;
		var v = '<cfoutput>#FORM.nomeForm#</cfoutput>'+'.xml';
		
		var urlToSigning = 'http://svilmydimeg.echopress.it/portale_admin/' + '<cfoutput>#FORM.nomeForm#</cfoutput>'+'.xml';
		
		var cfmScriptToSigned =  'http://svilmydimeg.echopress.it/portale_admin/testHTTPUnical.cfm?val1=' + '<cfoutput>#FORM.nomeForm#</cfoutput>'+'Signed';
		
		
		
		
<!---		var urlToSigning = "http://svilmydimeg.echopress.it/portale_admin/PatientRecord.xml";	
		var cfmScriptToSigned =  "http://svilmydimeg.echopress.it/portale_admin/testHTTPUnical.cfm?val1=PatientRecordSigned";	--->	
		       
		LoginSicuroApplet.loginSicuroXml(pin, urlToSigning, cfmScriptToSigned);
		
		document.myForm.pin.value="";
	 
	}   
	
	  
	</script>
    
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	
</BODY> 

</HTML>