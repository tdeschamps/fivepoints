require 'open-uri'
require 'json'

class FoursquareInfos
	
	def initialize(place)
		@foursquare_id = ENV['FOURSQ_CLIENT_ID']
		@foursquare_secret = ENV['FOURSQ_CLIENT_SECRET']
		@place = place
		@venue = nil
	end

	def get_additional_infos
		place_id = @place.id
		foursquare_place_id = @place.foursquare_id
		foursquare_api_version = DateTime.now().strftime("%Y%m%d")

		foursquare_place_url = "https://api.foursquare.com/v2/venues/#{foursquare_place_id}?&client_id=#{@foursquare_id}&client_secret=#{@foursquare_secret}&v=#{foursquare_api_version}&locale=en"
		response = open(foursquare_place_url)
		#p response
		@venue = JSON.parse(response.read.to_s)['response']['venue']
		
		foursquare_picture_url = handle_pictures
		
		foursquare_rating = @venue['rating']
		social_infos = {}
		@venue['contact'].each do |k,v| 
			social_infos[k.underscore.to_sym] = v
		end


		location = @venue['location']
		
		location_infos = {
			address: location['address'],
			latitude: location['lat'],
			longitude: location['lng'],
			zipcode: location['postalCode'],
			city: location['city'],
			state: location['state']
		}

		price_info = {}
		if @venue['price']
			price_info = {price: @venue['price']['tier'],
						price_description: @venue['price']['message']
			}
		end
		


		categories = @venue['categories']
		
		categories.each do |category|
			FoursquareCategory.perform_later place_id, category
		end

		if @venue['description']
			description = @venue['description']
		end	

		return {foursquare_picture_url: foursquare_picture_url, 
				foursquare_rating: foursquare_rating, 
				description: description}.merge(social_infos).merge(location_infos).merge(price_info)
	
	end 

	def handle_pictures
		pictures = @place.uploaded_files.map(&:file_file_name)
		if @venue['photos']['count'] > 0
			picture_group = @venue['photos']['groups'][0]['items']
			
			
			picture_group.each do |picture|
      			picture_object = picture 
      			picture_url = "#{picture_object['prefix']}#{picture_object['width']}x#{picture_object['height']}#{picture_object['suffix']}"
      			FoursquarePicture.perform_later @place.id, picture_url unless pictures.include? picture_object['suffix'].gsub('/','')
    		end

			picture_object = picture_group[0] 
			return "#{picture_object['prefix']}#{picture_object['width']}x#{picture_object['height']}#{picture_object['suffix']}"
			
		end
	end

end