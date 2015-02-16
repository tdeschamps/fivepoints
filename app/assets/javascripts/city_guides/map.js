$(document).ready(function() {
	L.mapbox.accessToken = 'pk.eyJ1IjoidGhvbWFzZHVjaGFtcCIsImEiOiI3VWtQXzdBIn0.o8nQtuU21tFPiTTiDajong';
	var cityCoordinates =  $('#city-coordinates').data('url')
  var map = L.mapbox.map('map', 'examples.map-i86nkdio', {
		zoomControl: false
	}).setView([cityCoordinates[0] , cityCoordinates[1]], 12);
	map.doubleClickZoom.disable();
	map.scrollWheelZoom.disable();
  
  var geolocations = $('#geolocations').data('url');
	geojson = geolocations
  

  if (geolocations) {
    map.featureLayer.setGeoJSON(geojson)
    map.featureLayer.on('layeradd', function(e) {
      var marker, popupContent, properties;
      marker = e.layer;
      properties = marker.feature.properties;
      popupContent = '<div class="popup">' + '<h3>' + properties.name + '</h3>' + '<p>' + properties.address + '</p>' + '</div>';
      return marker.bindPopup(popupContent, {
        closeButton: false,
        minWidth: 320
      });
    });
  };  


});