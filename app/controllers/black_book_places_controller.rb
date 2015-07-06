class BlackBookPlacesController < ApplicationController
	respond_to :html, :js
	before_action :set_black_book_place, only: [:send_to_archive, :edit, :update] 
	
	def edit
		@user = @black_book_place.black_book.user
	end

	def update
		black_book_place_params[:file] ? @black_book_place.uploaded_files.create(file: black_book_place_params[:file]) : @black_book_place.update(black_book_place_params)
		@black_book_place.save

		redirect_to edit_black_book_place_path @black_book_place
	end

	def update_position
		@black_book_place = BlackBookPlace.find(black_book_place_params[:black_book_place_id])
		
		@black_book_place.insert_at black_book_place_params[:position].to_i
		#@black_book_place.save
		render nothing: true
	end

	def send_to_archive

		@black_book_place.remove_from_list
		@black_book_place.save

		@place.ranking -= 1
		@place.save

	
	    render nothing: true

	end
	
	private

	def set_black_book_place
		@black_book_place = BlackBookPlace.includes(:place).find(params[:id]);
		@place = @black_book_place.place
	end

	def black_book_place_params
		params.require(:black_book_place).permit(:black_book_place_id, :position, :black_book_id, :place_id, :file, :story)
	end

end
