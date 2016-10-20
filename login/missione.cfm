<cfparam name="Q_ID" default="">

<cfset title = "Nuova Missione">
<cfif Q_ID neq "">
</cfif>

<cfinclude template="header-login.cfm">


<cfinclude template="main-header.cfm">
<cfinclude template="main-sidebar.cfm">
<cfinclude template="main-content.cfm">


<cfoutput>
<div class="box box-warning">
    <div class="box-header with-border">
      <h3 class="box-title">#title#</h3>
    </div>
    <!-- /.box-header -->
    <div class="box-body">
      <form role="form">
      	<div class="row">
        	<div class="col-lg-6 col-xs-12">
            	<div class="form-group">
                  <label>Il sottoscritto</label>
                  <input name="nome_richiedente" class="form-control" placeholder="Enter ..." disabled="" type="text" value="MARIO ROSSI">
                </div>
            </div>
            <div class="col-lg-6 col-xs-12">
            	<div class="form-group">
                  <label>Codice Fiscale</label>
					<input name="cf_richiedente" class="form-control" placeholder="Enter ..." disabled="" type="text" value="RSSMRA1234567890">
                </div>
            </div>
            <div class="col-lg-6 col-xs-12">
            	<div class="form-group">
                	in servizio presso il Dipartimento di Ingegneria Meccanica Energetica e Gestionale, con la <label>qualifica di</label>
					<input name="qualifica_richiedente" class="form-control" placeholder="Enter ..." disabled="" type="text" value="QUALIFICA">
                </div>
            </div>
            <div class="col-lg-12 col-xs-12">
            	<div class="text-center">
                	<h3>CHIEDE</h3>
                    <br />
                </div>
            </div>
            <div class="col-lg-6 col-xs-12">
            	<div class="text-right">
                	di essere autorizzato/a a compiere la missione a: 
                </div>
            </div>
            <div class="col-lg-6 col-xs-12">
            	<div class="form-group">
					<input name="luogo_richiesta" class="form-control" placeholder="Enter ..." type="text" value="LUOGO RICHIESTA MISSIONE">
                </div>
            </div>
            <div class="col-lg-6 col-xs-12">
            	<div class="text-right">
                	oggetto della missione: 
                </div>
            </div>
            <div class="col-lg-6 col-xs-12">
            	<div class="form-group">
					<input name="oggetto_missione" class="form-control" placeholder="Enter ..." type="text" value="OGGETTO RICHIESTA MISSIONE">
                </div>
            </div>
            
            <div class="col-lg-6 col-xs-12">
            	<div class="text-right">
                	dalle ore: 
                </div>
            </div>
            <div class="col-lg-6 col-xs-12">
            	<div class="form-group">
					<input class="form-control timepicker" name="dal_al_missione" type="text">
                </div>
            </div>
            <div class="col-lg-6 col-xs-12">
            	<div class="text-right">
                	dal - al: 
                </div>
            </div>
            <div class="col-lg-6 col-xs-12">
            	<div class="form-group">
					<input class="form-control rangedatepicker" name="dal_al_missione" type="text">
                </div>
            </div>
            
            
        </div>
        <!-- text input
        <div class="form-group">
          <label>Text</label>
          <input class="form-control" placeholder="Enter ..." type="text">
        </div>
         -->

        <!-- textarea -->
        <div class="form-group">
          <label>Textarea</label>
          <textarea class="form-control" rows="3" placeholder="Enter ..."></textarea>
        </div>
        <div class="form-group">
          <label>Textarea Disabled</label>
          <textarea class="form-control" rows="3" placeholder="Enter ..." disabled=""></textarea>
        </div>

        <!-- input states -->
        <div class="form-group has-success">
          <label class="control-label" for="inputSuccess"><i class="fa fa-check"></i> Input with success</label>
          <input class="form-control" id="inputSuccess" placeholder="Enter ..." type="text">
          <span class="help-block">Help block with success</span>
        </div>
        <div class="form-group has-warning">
          <label class="control-label" for="inputWarning"><i class="fa fa-bell-o"></i> Input with
            warning</label>
          <input class="form-control" id="inputWarning" placeholder="Enter ..." type="text">
          <span class="help-block">Help block with warning</span>
        </div>
        <div class="form-group has-error">
          <label class="control-label" for="inputError"><i class="fa fa-times-circle-o"></i> Input with
            error</label>
          <input class="form-control" id="inputError" placeholder="Enter ..." type="text">
          <span class="help-block">Help block with error</span>
        </div>

        <!-- checkbox -->
        <div class="form-group">
          <div class="checkbox">
            <label>
              <input type="checkbox">
              Checkbox 1
            </label>
          </div>

          <div class="checkbox">
            <label>
              <input type="checkbox">
              Checkbox 2
            </label>
          </div>

          <div class="checkbox">
            <label>
              <input disabled="" type="checkbox">
              Checkbox disabled
            </label>
          </div>
        </div>

        <!-- radio -->
        <div class="form-group">
          <div class="radio">
            <label>
              <input name="optionsRadios" id="optionsRadios1" value="option1" checked="" type="radio">
              Option one is this and that&mdash;be sure to include why it's great
            </label>
          </div>
          <div class="radio">
            <label>
              <input name="optionsRadios" id="optionsRadios2" value="option2" type="radio">
              Option two can be something else and selecting it will deselect option one
            </label>
          </div>
          <div class="radio">
            <label>
              <input name="optionsRadios" id="optionsRadios3" value="option3" disabled="" type="radio">
              Option three is disabled
            </label>
          </div>
        </div>

        <!-- select -->
        <div class="form-group">
          <label>Select</label>
          <select class="form-control">
            <option>option 1</option>
            <option>option 2</option>
            <option>option 3</option>
            <option>option 4</option>
            <option>option 5</option>
          </select>
        </div>
        <div class="form-group">
          <label>Select Disabled</label>
          <select class="form-control" disabled="">
            <option>option 1</option>
            <option>option 2</option>
            <option>option 3</option>
            <option>option 4</option>
            <option>option 5</option>
          </select>
        </div>

        <!-- Select multiple-->
        <div class="form-group">
          <label>Select Multiple</label>
          <select multiple="" class="form-control">
            <option>option 1</option>
            <option>option 2</option>
            <option>option 3</option>
            <option>option 4</option>
            <option>option 5</option>
          </select>
        </div>
        <div class="form-group">
          <label>Select Multiple Disabled</label>
          <select multiple="" class="form-control" disabled="">
            <option>option 1</option>
            <option>option 2</option>
            <option>option 3</option>
            <option>option 4</option>
            <option>option 5</option>
          </select>
        </div>

      </form>
    </div>
    <!-- /.box-body -->
  </div>




</cfoutput>
<cfinclude template="main-content-closed.cfm">
<cfinclude template="footer-login.cfm">