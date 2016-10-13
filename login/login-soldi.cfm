<cfinclude template="header-login.cfm">
      
      
      <script type="text/javascript">

			function login(){ 
		
				var pin = document.myForm.pin.value;
				var urlToSigning = "http://svilmydimeg.echopress.it/portale_admin/tommy-xml-form2.xml";	
				var cfmScriptToXmlSigned =  "http://svilmydimeg.echopress.it/portale_admin/testHTTPUnical.cfm?val1=nomefileMultiSign";	
				
						
				//LoginSicuroApplet.loginSicuro(pin, urlToSigning, cfmScriptToXmlSigned);
				if(document.myForm.pin.value === "" ){
		
					alert("Attenzione: inserire il codice PIN!");
				}
				
				else{
				
				
				 LoginSicuroApplet.loginSicuro(pin);
				 document.myForm.pin.value="";
				
				}
				
				
			  
			}//login
			
			
			function pinCorretto(){		
				
				document.myForm.pin.value="";
				document.myForm.submit();
						
			  
			}//pinCorretto
			
			
			function pinErrato(errore){
				
				//alert("Attenzione: pin errato!");
				alert(errore);
				document.myForm.pin.value="";
			  
			}//pinErrato 	
		
			
		
		</script>
    </head>
    <body class="hold-transition login-page">
    <div class="login-box">
      <div class="login-logo">
        <a href="admin-esempio/index2.html"><b>Unical</b> Login SOLDI</a>
      </div>
      <!-- /.login-logo -->
      <div class="login-box-body">
        <p class="login-box-msg">Accesso con Credenziali SOLDI</p>
        
        <form name="myForm" action="../unicalXmlTestForm.cfm" method="post">
          <div class="form-group has-feedback">
          	<input type="matricola" class="form-control" placeholder="Matricola">
            <span class="glyphicon glyphicon-user form-control-feedback"></span>
          </div>
          <div class="form-group has-feedback">
            <input type = "pin" name = "pin" id = "pin" placeholder="PIN">
            <span class="glyphicon glyphicon-lock form-control-feedback"></span>
          </div>
          
          
          <div class="row text-center">
            
            <div class="col-xs-12">
              <button type="button" onClick="" class="btn btn-primary btn-block btn-flat">Login</button>
            </div>
            <!-- /.col -->
          </div>
        </form>
		
        <!---
        <div class="social-auth-links text-center">
          <p>- OR -</p>
          <a href="##" class="btn btn-block btn-social btn-facebook btn-flat"><i class="fa fa-facebook"></i> Sign in using
            Facebook</a>
          <a href="##" class="btn btn-block btn-social btn-google btn-flat"><i class="fa fa-google-plus"></i> Sign in using
            Google+</a>
        </div>
        <!-- /.social-auth-links -->
		
        <a href="##">I forgot my password</a><br>
        <a href="admin-esempio/pages/examples/register.html" class="text-center">Register a new membership</a>
		--->
      </div>
      <!-- /.login-box-body -->
    </div>
    <!-- /.login-box -->
    
 <cfinclude template="footer-login.cfm">