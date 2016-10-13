<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>Unical</title>
    <META name="author" content="">
    <META name="copyright" content="">
    <META name="keywords" content="">

<!--- MAPPA 
<cfset GOOGLE_MAP_KEY="">
<cfswitch expression="#listrest(CGI.SERVER_NAME,'.')#">
	<cfcase value="deis.unical.it">
		<cfset GOOGLE_MAP_KEY="ABQIAAAAmEFwfePolTei8iEvOg_nXhTl0uv2RI5FN56ypmEXbq8nXzew5RSjd-9w3P6dLZOgUy0EMe_kozYR3g">
	</cfcase>
	<cfcase value="echopress.it">
		<cfset GOOGLE_MAP_KEY="ABQIAAAAmEFwfePolTei8iEvOg_nXhTXGfbAOZdF4q_MzPOH5-XCYe3WBxSYdd5kKSq3-Yfx-uiRC2w-hI8Epg">
	</cfcase>
	<cfcase value="163">
		<cfset GOOGLE_MAP_KEY="ABQIAAAAOAte7certMQQ7LL0BheewhRFGMxH5cUa98H0y2Cw2e_SaGUC0RQWXX1_WU2hvgv3ilqev8QemSAHQw">
	</cfcase>
    <cfdefaultcase>
    	<cfset GOOGLE_MAP_KEY="ABQIAAAAOAte7certMQQ7LL0BheewhRFGMxH5cUa98H0y2Cw2e_SaGUC0RQWXX1_WU2hvgv3ilqev8QemSAHQw">
    </cfdefaultcase>
</cfswitch>
--->

<!--- Get USER --->

	<script src="http://maps.google.com/maps?file=api&amp;v=2&amp;key=<cfoutput>#API_KEY#</cfoutput>" type="text/javascript"></script>

    <script type="text/javascript">

    var map = null;
    var geocoder = null;
	
    function initialize() {
      if (GBrowserIsCompatible()) {
        map = new GMap2(document.getElementById("map"));
        //map.setCenter(new GLatLng(41.927180, 12.458210), 9);
		map.addControl(new GSmallMapControl());
        map.addControl(new GMapTypeControl());
        geocoder = new GClientGeocoder();
      }
    }	

	function JS_OnUnload() { //v1.3
		if (map != null) {
			GUnload();
		}
	}	

    function JS_LoadMap(address) {
	if (address==',') address='Via P. Bucci, 87036, Rende, Italia';
	if (geocoder) {
        geocoder.getLatLng(
          address,
          function(point) {
            if (!point) {
              alert(address + " non trovato. \n Probabilmente la via non e\' corretta!");
            } else {
              map.setCenter(point, 15);
              var marker = new GMarker(point);
              map.addOverlay(marker);
			  msg="<br><font face='Arial' size='-2' >Clicca sulla mappa nelle vicinanze del luogo da inserire, dopo chiudi la finestra ! <br><b>" + address + "</b></font>";
              marker.openInfoWindowHtml(msg);
            }
          }
        );
		
		GEvent.addListener(map, "click", function(overlay, point){
		map.clearOverlays();
		if (point) {
		  map.addOverlay(new GMarker(point));
		  map.panTo(point);
		  opener.document.F_Main.Q_LAT.value = point.lat();
		  opener.document.F_Main.Q_LON.value = point.lng();		 
		  document.getElementById("mypoint").innerHTML = msg;
		}
		});
		}
		// arrange for our onload handler to 'listen' for onload events
		if (window.attachEvent) {
		  window.attachEvent("onload", function() {
		  loadMap();	// Internet Explorer
		});
		} else {
		  window.addEventListener("load", function() {
		  loadMap(); // Firefox and standard browsers
		}, false);
		
      }	 	  
    }
	
    </script>
 
</head>			

<!--- PARAMETRI LOCALI --->

<cfset V_TMP_ADDRESS = "">
<cfset V_TMP_ADDRESS = Replace(Q_ADDRESS,"'","\'","ALL")>

<!---<body bgcolor="white" onLoad="initialize();JS_LoadMap('#Q_ADDRESS#')" onUnload="JS_OnUnload()">--->
<body bgcolor="white" onLoad="initialize();JS_LoadMap('<cfoutput>#V_TMP_ADDRESS#</cfoutput>');" onUnload="JS_OnUnload()">
		<div id="map" style="width: 700px; height: 600px"></div>
		<div id="mypoint" style="font-size:16pt;line-height:1.1em"></div>
</body>
</html>
