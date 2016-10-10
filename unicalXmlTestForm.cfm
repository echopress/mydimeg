<html> 
<head> 
<title>Input form</title> 
</head> 
<body> 




<cfform name="F_Main" action="testUnicalFormServerSide.cfm" method="post" enctype="multipart/form-data">
   
     <p> 
        First Name: <input type="Text" name="FirstName" size="20"maxlength="35"><br> 
        Account: <input type="Text" name="account" size="20" maxlength="35"><br> 
        PDF File:    <input type="file" name="filePDF" />
    </p> 
   
     <!--- Reset button. ---> 
    <input type="Reset" name="ResetForm" value="Clear Form"> 
    
    <!--- submit button ---> 
    <input type="Submit" name="SubmitForm" value="Submit"> 
    
</cfform>




</body> 
</html>