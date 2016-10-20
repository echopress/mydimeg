<html> 
<head> 
<title>Input-form</title> 
</head> 
<body> 


<form name="F_Main" action="testUnicalFormServerSide.cfm" method="Post" enctype="multipart/form-data"> 
   
    Start Date:  
    <input type="text" name="StartDate" size="16" maxlength="16"><br /> 
    
    Salary:  
    <input type="text" name="Salary" size="10" maxlength="10"><br /> 
        
    PDF File:    <input type="file" name="filePDF" />
       			 <input type="hidden" name="nomeform" value="PatientRecord">
                    
                     <br /><br /> 
                    
    <input type="reset"  name="ResetForm" value="Clear Form"> 
        
    <input type="submit"  name="SubmitForm" value="Insert Data"> 
    
</form> 

</body> 
</html>