<!--- Get USER --->


<!--- imposta ponte unical --->
<cfset MAP_lat="39.361289">
<cfset MAP_lng="16.226195">
<cfset MAP_zoom=15> 




<cfoutput>

<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title>GReverseGeocoder v1.0.7</title>
    <script src="http://maps.google.com/maps?file=api&amp;v=2&amp;key=#API_KEY#" type="text/javascript"></script>
    <script src="../common/greversegeocoderv107.js" type="text/javascript"></script>
    <script type="text/javascript">

// GMap2 object
var map;
// GReverseGeocoder object
var rg;
// text input fields
var lat;
var lng;
// result div
var info;

function load() {
  if (GBrowserIsCompatible()) {
    lat = document.getElementById("lat");
    lng = document.getElementById("lng");
    info = document.getElementById("info");

    map = new GMap2(document.getElementById("map"));
	var center = new GLatLng(#MAP_lat#, #MAP_lng#);
    map.setCenter(new GLatLng(#MAP_lat#, #MAP_lng#), #MAP_zoom#);
    map.addControl(new GLargeMapControl());
	
	var marker = new GMarker(center, {draggable: true});
	
    rg = new GReverseGeocoder(map);

    // add listners for the results
    //GEvent.addListener(marker, "dragstart", rg, "load", goodresult);
	//GEvent.addListener(marker, "dragend", rg, "load", goodresult);
	
	//map.addOverlay(marker);
    
	GEvent.addListener(rg, "load", goodresult);
	GEvent.addListener(rg, "error", badresult);
    // Clicking on the map fills in the lat and lng fields
    // Just handy
    GEvent.addListener(map, "click", handleClicks);
  }
}

// is called with a placemark if the reverse geocode request was successfull
// sets the result div
function goodresult(placemark) {
  var html = placemark.address + '<br />' + '<b>Country code:</b> ' + placemark.AddressDetails.Country.CountryNameCode;
  info.innerHTML = html;
  var postalcodenumber = rg.getPlacemarkProperty(placemark,"PostalCodeNumber");
  //if (postalcodenumber != null) alert("Postal Code Number: " + postalcodenumber);
  //else alert("Postal Code Number Unknown");
}

// is called if the reverse geocode request was unsuccessfull
function badresult() {
  info.innerHTML = "Unable to reverse geocode";
}

// get the input form lat and lng fields and issue a reverse geocode
// request
function reverse(){
  var point = new GLatLng(lat.value,lng.value);
  rg.reverseGeocode(point);
}

// handy method to fill in the lat and lng fields by clicking on the map.
function handleClicks(marker, point){
  lat.value=point.lat();
  lng.value=point.lng();
}

function JS_CopyXY(){
  opener.document.F_Main.Q_LAT.value = lat.value;
  opener.document.F_Main.Q_LON.value = lng.value;  
}


  </script>

</head>

<body onLoad="load()" onUnload="GUnload()">

<form name="F_Main" action="" method="get">
  <table width="100%" border="0" cellpadding="2" cellspacing="2">
    <tr>
    <td width="12%">Latitude (WGS84):      </td>
    <td width="88%"><input id="lat" type="text" size="20" value="" />
      <input type="button" onClick="reverse()" value=" Get Address "></td>
    </tr>
    <tr>
    	<td>Longitude (WGS84):   	      </td>
        <td><input id="lng" type="text" size="20" value="" />
        <input type="button" onClick="JS_CopyXY()" value="Copia Coordinate"></td>
    </tr>
    <tr>
    	<td>&nbsp;</td>
    <td><div id="info"></div></td>
    </tr>
    <tr>
    	<td align="center" colspan="2"><div id="map" style="width:700px; height:600px; border:solid 1px"></div></td>
    </tr>
</table>
</form>

</body>
</html>

</cfoutput>