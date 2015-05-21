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

	def choose_black_book_place_background(black_book_place)
		return "background-color: #{%w(lightpink royalblue lightblue lightgreen lightcyan lightsteelblue).sample};" if black_book_place.nil?
		if black_book_place.uploaded_files.last
			"background-image: url('#{ black_book_place.uploaded_files.last.file.url(:large)}');"
		elsif black_book_place.place.foursquare_picture_url
			"background-image: url('#{ black_book_place.place.foursquare_picture_url}');"
		else
			"background-color: #{%w(lightpink royalblue lightblue lightgreen lightcyan lightsteelblue).sample};"
		end					
	end		
end
