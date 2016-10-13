<cfset V_FILTRO_FOL = "">
<cfif A_FOL_TYPE is not "">
	<cfset V_FILTRO_FOL = V_FILTRO_FOL & " AND fol_type = '#A_FOL_TYPE#'">
</cfif>
<!--- CASO FOLDERS CON AUTORIZZAZIONE ESPLICITA --->
<cfif Q_FOLDER_NAV is "">
  <!--- recupera pagine su cui si possiede un'abilitazione esplicita a livello ADMIN --->
  <cfmodule template="ab_authfolders.cfm" A_SERVICE="#A_SERVICE_VAL#" A_LEVEL="#Session.L_READ#" A_OUTPUT="V_PAGES">
  <cftree name="Folder" format="html" completepath="yes" fontsize="13px" font="Verdana, Geneva, sans-serif">
  
    <cfloop list="#V_PAGES#" index="t_page">
      <cfquery datasource="#APP_DSN#" name="Get_Folder" dbtype="ODBC">
        SELECT * FROM folders
        where fol_folder like '#t_page#%'
        #PreserveSingleQuotes(V_FILTRO_FOL)#
      </cfquery>
     
      <cftreeitem img="../images/ico_folder_tree2.png" imgopen="../images/ico_folder_open_tree.png"
          parent="#Get_Folder.fol_folder#" 
          display="#Get_Folder.fol_descr# <font color='##663300' size='-2'>(#Get_Folder.fol_label#)</font>" 
          value="#Get_Folder.fol_folder#" 
          expand="no"
          href="javascript:JS_Select('#Get_Folder.fol_folder#')">
      
      <cfloop query="Get_Folder">
        <cfquery datasource="#APP_DSN#" name="El_SubPages" dbtype="ODBC">
          SELECT * FROM folders
          WHERE fol_folder LIKE '#Get_Folder.fol_folder#%'
          #PreserveSingleQuotes(V_FILTRO_FOL)#
          ORDER BY fol_folder
        </cfquery>
      
        <cfset t_liv_padre=listlen(Get_Folder.fol_folder,"/")>
        
        <cfloop query="El_SubPages">
		  <cfset t_liv=listlen(fol_folder,"/")>
          
		  <cfif (t_liv - 1) is t_liv_padre>
            <cfmodule template="ab_testfolder.cfm" A_SERVICE="#A_SERVICE_VAL#" A_FOLDER="#fol_folder#" A_OUTPUT="t_l">
            
			<cfif t_l ge Session.L_READ>             
               <cftreeitem img="../images/ico_folder_tree2.png" imgopen="../images/ico_folder_open_tree.png"
                  parent="#Get_Folder.fol_folder#" 
                  display="#El_SubPages.fol_descr# <font color='##663300' size='-2'>(#El_SubPages.fol_label#)</font>" 
                  value="#El_SubPages.fol_folder#" 
                  expand="no"
                  href="javascript:JS_Select('#El_SubPages.fol_folder#')">
            </cfif>
            
          </cfif>
        
        </cfloop>
      
      </cfloop>
    
    </cfloop>
  
  </cftree>
<!--- FINE CASO FOLDERS CON AUTORIZZAZIONE ESPLICITA --->
<cfelse>

  <cftree name="Folder" format="html" completepath="yes" fontsize="13px" font="Verdana, Geneva, sans-serif"> 
    <cfquery datasource="#APP_DSN#" name="Get_Folder" dbtype="ODBC">
       SELECT * FROM folders
       where fol_folder like '#Q_FOLDER_NAV#%'
       #PreserveSingleQuotes(V_FILTRO_FOL)#
    </cfquery>
   
    <cftreeitem img="../images/ico_folder_tree2.png" imgopen="../images/ico_folder_open_tree.png"
        parent="#Get_Folder.fol_folder#" 
        display="#Get_Folder.fol_descr# <font color='##663300' size='-2'>(#Get_Folder.fol_label#)</font>" 
        value="#Get_Folder.fol_folder#" 
        expand="no"
        href="javascript:JS_Select('#Get_Folder.fol_folder#')">
   
    <cfloop query="Get_Folder"> 
        <cfquery datasource="#APP_DSN#" name="El_SubPages" dbtype="ODBC">
          SELECT * FROM folders
          WHERE fol_folder LIKE '#Get_Folder.fol_folder#%'
          #PreserveSingleQuotes(V_FILTRO_FOL)#
          ORDER BY fol_folder
        </cfquery>       
        <cfset t_liv_padre=listlen(Get_Folder.fol_folder,"/")>
        
        <cfloop query="El_SubPages">        
          <cfset t_liv=listlen(fol_folder,"/")>         
          
		  <cfif (t_liv - 1) is t_liv_padre>           
            <cfmodule template="ab_testfolder.cfm" A_SERVICE="#A_SERVICE_VAL#" A_FOLDER="#fol_folder#" A_OUTPUT="t_l">
            
			<cfif t_l ge Session.L_READ>            
               <cftreeitem img="../images/ico_folder_tree2.png" imgopen="../images/ico_folder_open_tree.png"
                  parent="#Get_Folder.fol_folder#" 
                  display="#El_SubPages.fol_descr# <font color='##663300' size='-2'>(#El_SubPages.fol_label#)</font>" 
                  value="#El_SubPages.fol_folder#" 
                  expand="no"
                  href="javascript:JS_Select('#El_SubPages.fol_folder#')">
            </cfif>
            
          </cfif>
        
        </cfloop>
    
    </cfloop>
    
  </cftree>
  
</cfif>
