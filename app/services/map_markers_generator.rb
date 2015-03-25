class MapMarkersGenerator

	def initialize(places)
		@places = places
	end

	def create_markers
		geolocations = Array.new

		@places = [@places] if @places.class == Place
		@places.each_with_index do |place, index|
		  geolocations << {
		    type: 'Feature',
		    geometry: {
		      type: 'Point',
		      coordinates: [place.longitude, place.latitude]
		    },
		    properties: {
		      name: place.name,
		      address: place.address,
		      :'marker-color' => '#FF4A50',
		      :'marker-symbol' => index + 1,
		      :'marker-size' => 'medium'
		    }
		  }
		end
		return geolocations.to_json
	end
end