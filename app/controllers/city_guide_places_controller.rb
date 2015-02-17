class CityGuidePlacesController < ApplicationController
	respond_to :html, :js
	
	def update_row_order
		@city_guide_place = CityGuidePlace.find(city_guide_place_params[:city_guide_place_id])
		previous_rank = @city_guide_place.row_order
		@city_guide_place.row_order = city_guide_place_params[:row_order_position]
		@city_guide_place.save
		@city_guide_place.place.update_score(previous_rank, city_guide_place_params[:row_order].to_i)
		render nothing: true
	end

	private

	def city_guide_place_params
		params.require(:city_guide_place).permit(:city_guide_place_id, :row_order, :row_order_position, :city_guide_id, :place_id)
	end

end
