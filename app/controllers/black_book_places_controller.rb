class BlackBookPlacesController < ApplicationController
	respond_to :html, :js
	before_action :set_black_book_place, only: :send_to_archive 
	
	def update_position
		@black_book_place = BlackBookPlace.find(black_book_place_params[:black_book_place_id])
		previous_rank = @black_book_place.position
		@black_book_place.insert_at black_book_place_params[:position].to_i
		#@black_book_place.save
		@black_book_place.place.update_score(previous_rank, black_book_place_params[:position].to_i)
		render nothing: true
	end

	def send_to_archive

		@black_book_place.remove_from_list
		@black_book_place.save

	
	    render nothing: true

	end
	
	private

	def set_black_book_place
		@black_book_place = BlackBookPlace.find(params[:id]);
	end

	def black_book_place_params
		params.require(:black_book_place).permit(:black_book_place_id, :position, :black_book_id, :place_id)
	end

end
