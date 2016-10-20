<html> 
<head> 
<title>Input-form</title> 
</head> 
<body> 

<cfform name="F_Main" action="testUnicalFormServerSide.cfm" method="post" enctype="multipart/form-data">
   
     <p> 
     
        First Name:  <input type="text" name="nome" size="20"maxlength="35"><br /> 
        Last Name: 	 <input type="text" name="cognome" size="20" maxlength="35"><br /> 
        PDF File:    <input type="file" name="filePDF" />
        			 <input type="hidden" name="nomeform" value="PatientRecord">
    </p> 
   
     <!--- Reset button. ---> 
    <input type="Reset" name="ResetForm" value="Cancella"> 
    
    <!--- submit button ---> 
    <input type="Submit" name="SubmitForm" value="Invia"> 
    
</cfform>

</body> 
</html>