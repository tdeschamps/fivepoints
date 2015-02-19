class CityGuidePlacesController < ApplicationController
	respond_to :html, :js
	before_action :set_city_guide_place, only: :send_to_archive 
	
	def update_row_order
		@city_guide_place = CityGuidePlace.find(city_guide_place_params[:city_guide_place_id])
		previous_rank = @city_guide_place.row_order
		@city_guide_place.row_order = city_guide_place_params[:row_order_position]
		@city_guide_place.save
		@city_guide_place.place.update_score(previous_rank, city_guide_place_params[:row_order].to_i)
		render nothing: true
	end

	def send_to_archive
		@city_guide_place.row_order = 0
		@city_guide_place.save

	
	    render nothing: true
		

	end
	private

	def set_city_guide_place
		@city_guide_place = CityGuidePlace.find(params[:id]);
	end

	def city_guide_place_params
		params.require(:city_guide_place).permit(:city_guide_place_id, :row_order, :row_order_position, :city_guide_id, :place_id)
	end

end
