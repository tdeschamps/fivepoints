$(document).ready(function() {
	L.mapbox.accessToken = 'pk.eyJ1IjoidGhvbWFzZHVjaGFtcCIsImEiOiI3VWtQXzdBIn0.o8nQtuU21tFPiTTiDajong';
	var cityBoundariesCoordinates =  $('#city-boundaries-coordinates').data('url')
  

  var map = L.mapbox.map('map', 'thomasduchamp.3d50a81c', {
		zoomControl: true
	}).setView([cityBoundariesCoordinates[0] , cityBoundariesCoordinates[1]], 12);
	map.touchZoom.disable();
  map.doubleClickZoom.disable();
  map.scrollWheelZoom.disable();


  var myLayer = L.mapbox.featureLayer().addTo(map);
  
  var geolocations = $('#geolocations').data('url');
	var geojson = geolocations;
  

  if (geolocations) {
    myLayer.on('layeradd', function(e) {
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
    map.fitBounds(myLayer.getBounds());

  }; 

  console.log(myLayer.getBounds());
  


  $(document).on('click', '#send-form', function(){
    //$('#new-place-form').fadeOut(200, function(){
    //  $('#new-place-form').find('input[type="text"]').val('');
    //})

    var featureLayer = L.mapbox.featureLayer({
        // this feature is in the GeoJSON format: see geojson.org
        // for the full specification
        type: 'Feature',
        geometry: {
            type: 'Point',
            // coordinates here are in longitude, latitude order because
            // x, y is the standard for GeoJSON and many formats
            coordinates: [$('input#longitude').val(),$('input#latitude').val()]
        },
        properties: {
            title: $('input#user_input_foursquare').val(),
            description: $('input#address').val(),
            // one can customize markers by adding simplestyle properties
            // https://www.mapbox.com/guides/an-open-platform/#simplestyle
            'marker-size': 'medium',
            'marker-symbol': 'circle',
            'marker-color': '#FF4A50'
        }
    }).addTo(map);

    featureLayer.eachLayer(function(layer) {
      console.log(layer);
      var properties = layer.feature.properties;
      console.log(properties);
      popupContent = '<div class="popup">' + '<h3>' + properties.title + '</h3>' + '<p>' + properties.description + '</p>' + '</div>';
      layer.bindPopup(popupContent);
    });
    //map.fitBounds(featureLayer.getBounds());
  }); 
});