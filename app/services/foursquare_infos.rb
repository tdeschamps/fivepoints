require 'open-uri'
require 'json'

class FoursquareInfos
	
	def initialize(place_id)
		@foursquare_id = ENV['4SQ_CLIENT_ID']
		@foursquare_secret = ENV['4SQ_CLIENT_SECRET']
		@place_id = place_id
	end

	def get_additional_infos

		@foursquare_place_id = Place.find(@place_id).foursquare_id
		response = open("https://api.foursquare.com/v2/venues/#{@foursquare_place_id}?&client_id=#{@foursquare_id}&client_secret=#{@foursquare_secret}&v=20150206")
		json = JSON.parse(response.read.to_s)
		picture_object = json['response']['venue']['photos']['groups'][0]['items'][0]
		foursquare_rating = json['response']['venue']['rating']
		picture_url = "#{picture_object['prefix']}#{picture_object['width']}x#{picture_object['height']}#{picture_object['suffix']}"
		
		return {foursquare_picture_url: picture_url, foursquare_rating: foursquare_rating}
	
	end 

end