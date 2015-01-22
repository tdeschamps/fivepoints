require 'open-uri'
require 'json'

class FoursquarePicture
	
	def initialize(params = {})
		@foursquare_id = params[:foursquare_id]
		@foursquare_secret = params[:foursquare_secret]
		@city_guide_place_id = params[:city_guide_place_id]
		@place_id = params[:place_id]
	end

	def GetAdditionalInfos
		@foursquare_place_id = Place.find(@place_id).foursquare_id
		response = open("https://api.foursquare.com/v2/venues/#{@foursquare_place_id}?&client_id=#{@foursquare_id}&client_secret=#{@foursquare_secret}&v=20140806")
		json = JSON.parse(response.read.to_s)
		picture_object = json['response']['venue']['photos']['groups'][0]['items'][0]
		foursquare_rating = json['response']['venue']['rating']
		picture_url = "#{picture_object['prefix']}#{picture_object['width']}x#{picture_object['height']}#{picture_object['suffix']}"
		return {foursquare_picture_url: picture_url, foursquare_rating: foursquare_rating}
	end 

end