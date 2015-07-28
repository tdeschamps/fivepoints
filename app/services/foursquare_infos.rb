require 'open-uri'
require 'json'

class FoursquareInfos
	
	def initialize(place)
		@foursquare_id = ENV['FOURSQ_CLIENT_ID']
		@foursquare_secret = ENV['FOURSQ_CLIENT_SECRET']
		@place = place
	end

	def get_additional_infos
		place_id = @place.id
		foursquare_place_id = @place.foursquare_id
		foursquare_api_version = DateTime.now().strftime("%Y%m%d")

		foursquare_place_url = "https://api.foursquare.com/v2/venues/#{foursquare_place_id}?&client_id=#{@foursquare_id}&client_secret=#{@foursquare_secret}&v=#{foursquare_api_version}&locale=en"
		p foursquare_place_url
		response = open(foursquare_place_url)
		#p response
		venue = JSON.parse(response.read.to_s)['response']['venue']
		
		if venue['photos']['count'] > 0
			picture_group = venue['photos']['groups'][0]['items']
			
			
			picture_group.each do |picture|
      			picture_object = picture 
      			picture_url = "#{picture_object['prefix']}#{picture_object['width']}x#{picture_object['height']}#{picture_object['suffix']}"
      			FoursquarePicture.perform_later place_id, picture_url
    		end

			picture_object = picture_group[0] 
			foursquare_picture_url = "#{picture_object['prefix']}#{picture_object['width']}x#{picture_object['height']}#{picture_object['suffix']}"
			
		end
		
		foursquare_rating = venue['rating']
		social_infos = {}
		venue['contact'].each do |k,v| 
			social_infos[k.underscore.to_sym] = v
		end


		location = venue['location']
		
		location_infos = {
			address: location['address'],
			latitude: location['lat'],
			longitude: location['lng'],
			zipcode: location['postalCode'],
			city: location['city'],
			state: location['state']
		}


		categories = venue['categories']
		
		categories.each do |category|
			FoursquareCategory.perform_later place_id, category
		end

		if venue['description']
			description = venue['description']
		end	

		return {foursquare_picture_url: foursquare_picture_url, 
				foursquare_rating: foursquare_rating, 
				description: description}.merge(social_infos).merge(location_infos)
	
	end 

end