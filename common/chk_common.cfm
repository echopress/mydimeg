<!--- 
CHK_COMMON v1.3
Valida e formatta valori di variabili di tipo comune
(i controlli specifici sono in files  chk_xxxxx  (es: chk_url, chk_path etc.)
Metodo di chiatata: CFMODULE
By A.Greco 1/6/2001

A_VALUE: valore da testare (default: "")
A_TYPE: tipo del valore (default: TEXT)
      uno tra:
	  TEXT     - testo
	  NUM      - numerico (intero)
	  DATE     - data  (formato richiesto in input: gg/mm/aaaa)
	  TIME     - ora  (formato richiesto in input: hh:mm)
	             NOTA BENE: il formato in output (variabile V_) e' hh:mm:00
	  EMAIL    - e-mail
A_REQUIRED: indica se il valore pou' essere nullo ("") oppore e' richiesto
	  (S: richiesto, N: opzionale) (default: N)
	  nota: prevale su MINLENGTH
A_LABEL: nome esterno del campo (usato per i messaggi di errore) (default: "")
A_MINLENGTH: lunghezza minima richiesta (in caratteri) (default: 0)
A_MAXLENGTH: lunghezza massima richiesta (in caratteri) (default: nessun limite)
A_REGEX: regular expression da testare contro il valore (default: nessun test)
       usata solo per il tipo TEXT (deve elencare i caratteri non ammissibili)
A_CASE: case richiesto per l'output (default: nessuna modifica del case)
	   UPPER:  Tutto in maiuscolo
	   LOWER: Tutto in minuscolo
	   FIRSTUP: mette in maiuscolo il primo carattere lascia inalterati gli altri
	   MIX: mette in maiuscolo il primo carattere di ogni parola, minuscoli gli altri
A_TRIM: effettua il trim del valore (S o N) (default: S)
A_RANGE: range dei valori ammissibili, 2 valori separati da virgola,
      (se di tipo data nel formato yyyy-mm-dd) (default: nessunt test)
A_STRIP0: rimuove gli 0 iniziali dai valori del tipo NUM (S o N) (default: S)
A_STRIPDBCHARS: rimuove i caratteri riservati del database (senza nessun avvertimento o errore
                (S o N) (default: S)
A_OUTPUT: nome della variabile in cui restituire il valore formattato (default: RESULT)
       le variabili di tipo data sono restituite nel formato yyyy-mm-dd
--->

<cfparam name="Attributes.A_VALUE" default="">
<cfparam name="Attributes.A_TYPE" default="TEXT">
<cfparam name="Attributes.A_REQUIRED" default="N">
<cfparam name="Attributes.A_LABEL" default="">
<cfparam name="Attributes.A_MINLENGTH" default=0>
<cfparam name="Attributes.A_MAXLENGTH" default="">
<cfparam name="Attributes.A_REGEX" default="">
<cfparam name="Attributes.A_CASE" default="">
<cfparam name="Attributes.A_TRIM" default="S">
<cfparam name="Attributes.A_RANGE" default="">
<cfparam name="Attributes.A_STRIP0" default="S">
<cfparam name="Attributes.A_STRIPDBCHARS" default="S">
<cfparam name="Attributes.A_OUTPUT" default="RESULT">


<!--- <cfloop collection="#Attributes#" item="key">
<cfoutput>
	key:#key# - value:#StructFind(Attributes,key)#<br>
</cfoutput>
</cfloop>
<br>
 --->

<cfset "caller.#Attributes.A_OUTPUT#"="">
<cfset res=Attributes.A_VALUE>

<!--- strip caratteri DB --->
<cfif Attributes.A_STRIPDBCHARS is "S">
	<cfset res=Replace(res,"|", "", "ALL")>	
</cfif>

<!--- prepara label per messaggi di errori (richiesti _ al posto degli spazi)--->
<cfset Attributes.A_LABEL=Replace(Attributes.A_LABEL," ","_","ALL")>

<!--- trim --->
<cfif Attributes.A_TRIM is "S">
	<cfset res=Trim(res)>
</cfif>

<!--- test required --->
<cfif Attributes.A_REQUIRED is "S">
	<cfif res is "">
		<cflocation url="../common/error.cfm?empty_field,#Attributes.A_LABEL#" addtoken="No">
	</cfif>
<cfelse>
	<cfif res is "">
		<cfset "caller.#Attributes.A_OUTPUT#"="">
		<cfexit method="ExitTag">
	</cfif>
</cfif>
	
<!--- test min length --->
<cfif Attributes.A_MINLENGTH is not 0>
	<cfif len(res) is 0>
		<cflocation url="../common/error.cfm?empty_field,#Attributes.A_LABEL#" addtoken="No">
	</cfif>
	<cfif len(res) lt Attributes.A_MINLENGTH>
		<cflocation url="../common/error.cfm?bad_len,#Attributes.A_LABEL#" addtoken="No">
	</cfif>
</cfif>

<!--- test max length --->
<cfif Attributes.A_MAXLENGTH is not "">
	<cfif len(res) gt Attributes.A_MAXLENGTH>
		<cflocation url="../common/error.cfm?bad_len,#Attributes.A_LABEL#" addtoken="No">
	</cfif>
</cfif>

<!--- case --->
<cfset L=Len(res)>
<cfswitch expression="#Attributes.A_CASE#">
	<cfcase value="UPPER">
		<cfset res=UCase(res)>
	</cfcase>
	<cfcase value="LOWER">
		<cfset res=LCase(res)>
	</cfcase>
	<cfcase value="FIRSTUP">
		<cfset res=UCase(Left(res,1)) & Mid(res,2,L)>
	</cfcase>
	<cfcase value="MIX">
		<cfset res=UCase(Left(res,1)) & lcase(Mid(res,2,L))>
		<cfset V_pos= REFind("[ '#chr(45)#][a-z]", res)>
		<cfloop condition="V_pos GT 0">
		   <cfset res=Left(res,V_pos-1) & UCase(Mid(res,V_pos,2)) & Mid(res,V_pos+2,L)> 
		   <cfset V_pos= REFind("[ '#chr(45)#][a-z]", res)>
		</cfloop>
	</cfcase>
</cfswitch>

<!--- controlli specifici per i tipi --->
<cfswitch expression="#Attributes.A_TYPE#">
<!--- TESTO --->
	<cfcase value="TEXT">
		<!--- test regexp --->
		<cfif Attributes.A_REGEX is not "">
			<cfif REFind(Attributes.A_REGEX, res) is not 0>
				<cflocation url="../common/error.cfm?bad_char,#Attributes.A_LABEL#" addtoken="No">
			</cfif>
		</cfif>
	</cfcase>
<!--- FINE TESTO --->

<!--- NUMERI --->
	<cfcase value="NUM">
		<cfif REFind("[^0-9]", res) is not 0>
			<cflocation url="../common/error.cfm?bad_value,#Attributes.A_LABEL#" addtoken="No">
		</cfif>
		<cfif Attributes.A_STRIP0 is "S">
			<cfset res=REReplace(res, "^0*", "")>
		</cfif>
		<cfif res is "">
			<cfset res=0>
		</cfif>
	</cfcase>
<!--- FINE NUMERI --->

<!--- DATE --->
	<cfcase value="DATE">
		<cfset V_DATA=res>
		<cfset V_DATA=ReplaceList(V_DATA, "-,\, ,.","/,/,/,/")>
		<!--- lunghezza --->
		<cfif (listlen(V_DATA,"/") LT 3)>
			<cflocation url="../common/error.cfm?bad_date,#Attributes.A_LABEL#" addtoken="No">
		</cfif>
		<!--- split data --->
		<cfset A_DATA=ListToArray(V_DATA,"/")>
		
		<cfif (A_DATA[1] LT 1) or (A_DATA[1] GT 31) or (A_DATA[2] LT 1) or (A_DATA[2] GT 12)>
			<cflocation url="../common/error.cfm?bad_date,#Attributes.A_LABEL#" addtoken="No">
		</cfif>
		<cfif (A_DATA[3] LT 1940)or (A_DATA[3] GT 2020)>
			<cflocation url="../common/error.cfm?bad_date,#Attributes.A_LABEL#" addtoken="No">
		</cfif>
		<cfif (A_DATA[1] GT 30) and ((A_DATA[2] EQ 4) or (A_DATA[2] EQ 6) or (A_DATA[2] EQ 9) or (A_DATA[2] EQ 11))>
			<cflocation url="../common/error.cfm?bad_date,#Attributes.A_LABEL#" addtoken="No">
		</cfif>
		<cfif (A_DATA[1] GT 29) and (A_DATA[2] EQ 2)>
			<cflocation url="../common/error.cfm?bad_date,#Attributes.A_LABEL#" addtoken="No">
		</cfif>
		<cfif (A_DATA[1] EQ 29) and (A_DATA[2] EQ 2)>
			<cfif (A_DATA[3] mod 4) EQ 0>
				<cfif  (A_DATA[3] mod 100) EQ 0>
					<cfif  (A_DATA[3] mod 400) IS NOT 0>
						<cflocation url="../common/error.cfm?bad_date,#Attributes.A_LABEL#" addtoken="No">
					</cfif>
				</cfif>
			<cfelse>
				<cflocation url="../common/error.cfm?bad_date,#Attributes.A_LABEL#" addtoken="No">
			</cfif>
		</cfif>
		<cfset D_DATA=CreateDate(A_DATA[3],A_DATA[2],A_DATA[1])>
		<cfset V_DATA=dateformat(D_DATA,"yyyy-mm-dd")>	
		<cfset res=V_DATA>
	</cfcase>
<!--- FINE DATE --->

<!--- TIME --->
	<cfcase value="TIME">
		<cfset V_TIME=res>
		<cfset V_TIME=Replace(V_TIME,".",":","ALL")>
		<!--- lunghezza --->
		<cfif (listlen(V_TIME,":") is not 2)>
			<cflocation url="../common/error.cfm?bad_time,#Attributes.A_LABEL#" addtoken="No">
		</cfif>
		<!--- split data --->
		<cfset A_TIME=ListToArray(V_TIME,":")>
		
		<cfif (A_TIME[1] LT 0) or (A_TIME[1] GT 23)>
			<cflocation url="../common/error.cfm?bad_time,#Attributes.A_LABEL#" addtoken="No">
		</cfif>
		<cfif (A_TIME[2] LT 0) or (A_TIME[2] GT 59)>
			<cflocation url="../common/error.cfm?bad_time,#Attributes.A_LABEL#" addtoken="No">
		</cfif>
		<cfset D_TIME=CreateTime(A_TIME[1],A_TIME[2],0)>
		<cfset V_TIME=timeformat(D_TIME,"HH:mm:ss")>	
		<cfset res=V_TIME>
	</cfcase>
<!--- FINE TIME --->


<!--- E-MAIL --->
	<cfcase value="EMAIL">
		<cfif (REFind("^[^.]+(\.[^.]+)*@[^.]+(\.[^.]+)+$", res)) is 0>
			<cflocation url="../common/error.cfm?bad_format,#Attributes.A_LABEL#" addtoken="No">
		</cfif>
	</cfcase>

	<cfdefaultcase>
		<cflocation url="../common/error.cfm?code,BAD_TYPE:#Attributes.A_TYPE#" addtoken="No">
	</cfdefaultcase>
</cfswitch>
<!--- FINE controlli specifici per i tipi --->


<!--- TEST RANGE --->
<cfif Attributes.A_RANGE is not "">
	<cfset rng=ListToArray(Attributes.A_RANGE)>
	<cfswitch expression="#Attributes.A_TYPE#">
		<cfcase value="TEXT,DATE,NUM">
			<cfif res lt rng[1] OR res gt rng[2]>
				<cflocation url="../common/error.cfm?bad_range,#Attributes.A_LABEL#" addtoken="No">
			</cfif>
		</cfcase>
		<cfdefaultcase>
			<cflocation url="../common/error.cfm?code,CANNOT_RANGE:#Attributes.A_TYPE#" addtoken="No">
		</cfdefaultcase>
	</cfswitch>
</cfif>

<!--- restituisci il valore in uscita --->
<cfset "caller.#Attributes.A_OUTPUT#"=res>

<!-- fine-->
