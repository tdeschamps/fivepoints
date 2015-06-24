namespace :reset_ranking do 
	
	desc 'reset ranking'
	task reset_places_ranking: :environment do
		Place.find_each do |place|
			place.ranking = 0
			place.save
		end
	end

	desc 'set proper ranking'
	task set_places_ranking: :environment do 
		Place.includes(:black_book_places).where.not(black_book_places: {position: nil}).find_each do |place|
			ranking = place.black_book_places.count
			place.ranking = ranking
			place.save
		end
	end
end