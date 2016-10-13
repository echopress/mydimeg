<html> 
<head> 
<title>Input form</title> 
</head> 
<body> 

<cfparam name="Q_FIRMADIGITALE" default="N">
<cfparam name="Q_CODICEFISCALE" default="">

<cfset xml_data = ToString(GetHttpRequestData().content) >

<cfdump var="#xml_data#" output="D:\WWW\mydimeg\portale_admin\test.txt" >


<cfform name="F_Main" action="testUnicalFormServerSide.cfm" method="post" enctype="multipart/form-data">
   
     <p> 
     
        First Name:  <input type="Text" name="nome" size="20"maxlength="35"><br> 
        Last Name: 	 <input type="Text" name="cognome" size="20" maxlength="35"><br> 
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