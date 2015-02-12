require 'open-uri'
require 'json'

class FoursquareInfos
	
	def initialize(place)
		@foursquare_id = ENV['4SQ_CLIENT_ID']
		@foursquare_secret = ENV['4SQ_CLIENT_SECRET']
		@place = place
	end

	def get_additional_infos
		place_id = @place.id
		foursquare_place_id = @place.foursquare_id
		foursquare_api_version = DateTime.now().strftime("%Y%m%d")

		foursquare_place_url = "https://api.foursquare.com/v2/venues/#{foursquare_place_id}?&client_id=#{@foursquare_id}&client_secret=#{@foursquare_secret}&v=#{foursquare_api_version}"
		response = open(foursquare_place_url)
		p response
		json = JSON.parse(response.read.to_s)
		if json['response']['venue']['photos']['count'] > 0
			picture_object = json['response']['venue']['photos']['groups'][0]['items'][0] 
			picture_url = "#{picture_object['prefix']}#{picture_object['width']}x#{picture_object['height']}#{picture_object['suffix']}"
		end
		foursquare_rating = json['response']['venue']['rating']
		
		
		return {foursquare_picture_url: picture_url, foursquare_rating: foursquare_rating}
	
	end 

end