<cfinclude template="header-login.cfm">
      
      
      <script type="text/javascript">
			function goSoldi()
			{
				location.href='http://svilmydimeg.echopress.it/portale_admin/login/login-soldi.cfm';
			}
			function goFirmaDigitale()
			{
				location.href='http://svilmydimeg.echopress.it/portale_admin/login/login-firma.cfm';
			}
		</script>
    </head>
    <body class="hold-transition login-page">
    <div class="login-box">
      <div class="login-logo">
        <a href="admin-esempio/index2.html"><b>Unical</b> Accesso</a>
      </div>
      <!-- /.login-logo -->
      <div class="login-box-body">
        <p class="login-box-msg">Scegli un metodo d'accesso</p>
        
        
        <div class="social-auth-links text-center">
        	<button type="button" onClick="goSoldi();" class="btn btn-primary btn-block btn-flat fa fa-money"> Accesso con credenziali SOLDI</button>
            <button type="button" onClick="goFirmaDigitale();" class="btn btn-primary btn-block btn-flat fa fa-lock"> Accesso con Firma Digitale</button>
            <button type="button" onClick="" class="btn btn-primary btn-block btn-flat fa fa-user"> Accesso ...</button>
        </div>
        <!-- /.social-auth-links -->
    
    
      </div>
      <!-- /.login-box-body -->
    </div>
    <!-- /.login-box -->
    
<cfinclude template="footer-login.cfm">