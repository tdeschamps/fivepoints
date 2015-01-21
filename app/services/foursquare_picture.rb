require 'open-uri'
require 'json'

class FoursquarePicture
	
	def initialize(params = {})
		@foursquare_id = params[:foursquare_id]
		@foursquare_secret = params[:foursquare_secret]
		@city_guide_place_id = params[:city_guide_place_id]
		@place_id = params[:place_id]
	end

	def GetPicture
		@foursquare_place_id = Place.find(@place_id).foursquare_id
		response = open("https://api.foursquare.com/v2/venues/#{@foursquare_place_id}/photos?&client_id=#{@foursquare_id}&client_secret=#{@foursquare_secret}&v=20140806")
		json = JSON.parse(response.read.to_s)
		picture_object = json['response']['photos']['items'][0]
		picture_url = "#{picture_object['prefix']}#{picture_object['width']}x#{picture_object['height']}#{picture_object['suffix']}"  end 

end