namespace :update_foursquare_infos do 

	desc 'update foursquare infos' 
	
	task update_foursquare_infos: :environment do
		Place.find_each(start: 50, batch_size: 10) do |place|
			set_foursquare_infos place
		end
	end

	def set_foursquare_infos(place)
		foursquare_additional_infos = FoursquareInfos.new(place).get_additional_infos()
		place.update(foursquare_additional_infos)
	end
end