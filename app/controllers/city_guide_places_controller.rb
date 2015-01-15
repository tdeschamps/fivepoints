class CityGuidePlacesController < ApplicationController
	respond_to :html, :js
	
	def update_rank
		@city_guide_place = CityGuidePlace.find(city_guide_place_params[:city_guide_place_id])
		@city_guide_place.rank = city_guide_place_params[:rank]
		@city_guide_place.save

		render nothing: true
	end

	private

	def city_guide_place_params
		params.require(:city_guide_place).permit(:city_guide_place_id, :rank, :city_guide_id, :place_id)
	end
end
