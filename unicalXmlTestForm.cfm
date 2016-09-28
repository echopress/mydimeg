<html> 
<head> 
<title>Input form</title> 
</head> 
<body> 

<form name="F_Main" action="testUnicalFormServerSide.cfm" method="post" >

    <p> 
    First Name: <input type="Text" name="FirstName" size="20"maxlength="35"><br> 
    Account: <input type="Text" name="account" size="20" maxlength="35"><br> 
    </p> 
    
    <!--- Reset button. ---> 
    <input type="Reset" name="ResetForm" value="Clear Form"> 
    
    <!--- submit button ---> 
    <input type="Submit" name="SubmitForm" value="Submit"> 

</form>	


</body> 
</html>