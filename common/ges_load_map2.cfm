<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>Unical</title>
    <META name="author" content="">
    <META name="copyright" content="">
    <META name="keywords" content="">


	<!--<script src="http://maps.google.com/maps?file=api&amp;v=2&amp;key=<cfoutput>#API_KEY#</cfoutput>" type="text/javascript"></script>-->
    
	
    <script type="text/javascript" src="http://maps.googleapis.com/maps/api/js?key=<cfoutput>#API_KEY#</cfoutput>&amp;sensor=false"></script>
<script type="text/javascript">
var map;
var marker=false;
function initialize() {
	var myLatlng = new google.maps.LatLng(39.361289,16.226195);
	
	var myOptions = {
		zoom: 17,
		center: myLatlng,
		mapTypeId: google.maps.MapTypeId.ROADMAP
	}
	var content = "<font face='Arial' size='-2' >Clicca sulla mappa nelle vicinanze del luogo da inserire, dopo chiudi la finestra!</font>";
	
	map = new google.maps.Map(document.getElementById("gmap"), myOptions);
	
	marker = new google.maps.Marker({
		position: myLatlng, 
		map: map
	});
	
	google.maps.event.addListener(map, 'click', function(event) {
		var clickedLocation = event.latLng;
		opener.document.F_Main.Q_LAT.value = clickedLocation.lat();
		opener.document.F_Main.Q_LON.value = clickedLocation.lng();
		//alert(clickedLocation.lat()+' '+clickedLocation.lng());
		placeMarker(event.latLng);
			window.setTimeout(function() {
			map.panTo(marker.getPosition());
			//infowindow.open(map,marker);
		}, 400);
	});
	  
	google.maps.event.addListener(map, 'zoom_changed', function() {
		zoomLevel = map.getZoom();
	});
	google.maps.event.addListener(marker, 'dblclick', function() {
		zoomLevel = map.getZoom()+1;
		if (zoomLevel == 20) {
			 zoomLevel = 10;
		}    
		map.setZoom(zoomLevel); 
	});
  
    var infowindow = new google.maps.InfoWindow({
        content: content
    });
	infowindow.open(map,marker);	
}//initialize
  
function placeMarker(location) {
	var clickedLocation = new google.maps.LatLng(location);
	marker.setPosition(location);
}
window.onload = function(){
	initialize();
	};

</script>

<!--- PARAMETRI LOCALI --->

<cfset V_TMP_ADDRESS = "">
<cfset V_TMP_ADDRESS = Replace(Q_ADDRESS,"'","\'","ALL")>
<style>
	div#gmap {
		width: 100%;
		height: 100%;
	}
</style>
</head>	


<body>
    <center>
        <div id="gmap"></div>
    </center>
</body>
</html>
