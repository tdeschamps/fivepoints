$(document).ready(function() {
	L.mapbox.accessToken = 'pk.eyJ1IjoidGhvbWFzZHVjaGFtcCIsImEiOiI3VWtQXzdBIn0.o8nQtuU21tFPiTTiDajong';
	var cityCoordinates =  $('#city-coordinates').data('url')
  var map = L.mapbox.map('map', 'thomasduchamp.3d50a81c', {
		zoomControl: true
	}).fitBounds([cityCoordinates[0] , cityCoordinates[1]], 12);
	map.doubleClickZoom.disable();
	map.scrollWheelZoom.disable();

  var myLayer = L.mapbox.featureLayer().addTo(map);
  
  var geolocations = $('#geolocations').data('url');
	var geojson = geolocations;
  

  if (geolocations) {
    myLayer.on('layeradd', function(e) {
      console.log("toto");
      var marker, popupContent, properties;
      marker = e.layer;
      properties = marker.feature.properties;
      popupContent = '<div class="popup">' + '<h3>' + properties.name + '</h3>' + '<p>' + properties.address + '</p>' + '</div>';
      
      return marker.bindPopup(popupContent, {
        closeButton: false,
        minWidth: 320
      });
    });
    myLayer.setGeoJSON(geojson);
  };  


});