<cfinclude template="header-login.cfm">
      
      
      <script type="text/javascript">

			function login(){ 
		
				var pin = document.getElementById("pin").value;			          
							
								
				if(pin == "" ){
		
					alert("Attenzione: inserire il codice PIN!");
				}
				
				else{
				
				
                 var cfmScriptToXmlSigned = "http://svilmydimeg.echopress.it/portale_admin/login/auth.cfm";	
				 //var cfmScriptToXmlSigned = "http://svilmydimeg.echopress.it/portale_admin/unicalXmlTestForm.cfm";	
				 LoginSicuroApplet.loginSicuro(pin, cfmScriptToXmlSigned);
				
				
				}
				
				
			  
			}//login
			
			function pinOk(value){		
								
				//$("#pin").remove();
				document.myForm.cf.value=value;
				document.myForm.submit();
						
			  
			}//pinOk
			
			
			/*function pinCorretto(){		
				
				document.myForm.pin.value="";
				document.myForm.submit();
						
			  
			}//pinCorretto*/
			
			
			function pinErrato(errore){
				
				//alert("Attenzione: pin errato!");
				alert(errore);
				document.getElementById("pin").value="";
			  
			}//pinErrato 	
		
			
		
		</script>
    </head>
    <body class="hold-transition login-page">
    <div class="login-box">
      <div class="login-logo">
        <a href="admin-esempio/index2.html"><b>Unical</b> Secure Login</a>
      </div>
      <!-- /.login-logo -->
      <div class="login-box-body">
        <p class="login-box-msg">Accesso con Firma Digitale</p>
        
        <!---<form name="myForm" action="../unicalXmlTestForm.cfm" method="post">--->
         <input type = "password" name = "pin" id = "pin" placeholder="PIN">
         
         
         <form name="myForm" action="../login/auth.cfm" method="post">
          <!---<div class="form-group has-feedback">
          	<input type="email" class="form-control" placeholder="Email">
            <span class="glyphicon glyphicon-envelope form-control-feedback"></span>
          </div>--->
          <div class="form-group has-feedback">
           <!--- <input type = "password" name = "pin" id = "pin" placeholder="PIN">--->
            <input type = "hidden" name = "Q_CODICEFISCALE" id = "cf"  value="">
            <input type = "hidden" name = "Q_FIRMADIGITALE" value="S">
            <span class="glyphicon glyphicon-lock form-control-feedback"></span>
          </div>
          
          <div class="form-group">
          	<APPLET codebase="http://svilmydimeg.echopress.it/portale_admin" archive="LoginSicuroApplet.jar" CODE="com.loginsicuro/LoginSicuroAppletEnveloped.class" name="loginApplet" id="LoginSicuroApplet" WIDTH="100%" HEIGHT="50" style="margin-top:20px; margin-left_:720px"></APPLET>
          </div>
          
          
          <div class="row text-center">
            
            <div class="col-xs-12">
              <button type="button" onClick="login();" class="btn btn-primary btn-block btn-flat">Login</button>
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