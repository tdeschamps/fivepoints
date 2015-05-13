module BlackBookPlacesHelper
	def choose_black_book_place_picture(black_book_place)

		if black_book_place.uploaded_files.last
			black_book_place.uploaded_files.last.file.url(:large)
		elsif black_book_place.place.foursquare_picture_url
			black_book_place.place.foursquare_picture_url
		else
			false
		end					
	end	
end
