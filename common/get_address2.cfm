<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>Unical</title>
    <META name="author" content="">
    <META name="copyright" content="">
    <META name="keywords" content="">
<cfif Q_LAT eq "">
	<cfset Q_LAT="39.361289">
    <cfset Q_LON="16.226195">
</cfif>

	<script type="text/javascript" src="http://maps.googleapis.com/maps/api/js?key=AIzaSyAsyxdSngvcJtQZVOyyFzcHjigQQ14cKLM&amp;sensor=false"></script>
<script type="text/javascript">
var geocoder;
var map;
var marker;
var lat=<cfoutput>#Q_LAT#</cfoutput>;
var lng=<cfoutput>#Q_LON#</cfoutput>;

function initialize() {
	geocoder = new google.maps.Geocoder();
	var myLatlng = new google.maps.LatLng(lat,lng);
	
	var myOptions = {
		zoom: 17,
		center: myLatlng,
		mapTypeId: google.maps.MapTypeId.ROADMAP
	}
	map = new google.maps.Map(document.getElementById("gmap"), myOptions);	
}//initialize
  

window.onload = function(){
	initialize();
	JS_Reverse();
	};

function JS_RecuperaCoordinate(){
	var indirizzo=document.getElementById('indirizzo').value;
	
    geocoder.geocode( { 'address': indirizzo}, function(results, status) {
      if (status == google.maps.GeocoderStatus.OK) {
        map.setCenter(results[0].geometry.location);
		marker = new google.maps.Marker({
            map: map, 
            position: results[0].geometry.location
        });
		//alert(results[0].geometry.location.lat() +' '+results[0].geometry.location.lng());
		lat = results[0].geometry.location.lat();
		lng = results[0].geometry.location.lng();
      } else {
        alert("Attenzione! Problema con la risoluzione dell'indirizzo. Errore: " + status);
      }
    });
	}//JS_RecuperaCoordinate()

function JS_Reverse(){
	var latlng = new google.maps.LatLng(lat, lng);
    geocoder.geocode({'latLng': latlng}, function(results, status) {
      if (status == google.maps.GeocoderStatus.OK) {
        if (results[0]) {
          map.setZoom(17);
          marker = new google.maps.Marker({
              position: latlng,
              map: map
          });
		  document.getElementById('indirizzo').value=results[0].formatted_address;
		  //alert(results[1].formatted_address);
          //infowindow.setContent(results[1].formatted_address);
          //infowindow.open(map, marker);
        }
      } else {
        alert("Latitudine e Longitudine non risolte in un indirizzo! ERRORE: " + status);
      }
    });

	}	

function JS_Conferma(){
	opener.document.F_Main.Q_LAT.value = lat;
	opener.document.F_Main.Q_LON.value = lng;
	window.close();
	}
</script>

<!--- PARAMETRI LOCALI --->
<cfset Q_ADDRESS="Via P.Bucci, 87036, Italia">
<cfset V_TMP_ADDRESS = "">
<cfset V_TMP_ADDRESS = Replace(Q_ADDRESS,"'","\'","ALL")>
<style>
	div#gmap {
		width: 100%;
		height: 95%;
	}
</style>
</head>	


<body>
	Indirizzo: <input type="text" id="indirizzo" size="50" />
    <input type="button" value="Recupera le Coordinate" onclick="JS_RecuperaCoordinate();" />
    <input type="button" value="Conferma" onclick="JS_Conferma();" style="font-weight: bold; color:green;" />
    <br /><br />
    <center>
        <div id="gmap"></div>
    </center>
</body>
</html>
