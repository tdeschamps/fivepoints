class CityGuidePlacesController < ApplicationController
	respond_to :html, :js
	before_action :set_city_guide_place, only: :send_to_archive 
	
	def update_position
		@city_guide_place = CityGuidePlace.find(city_guide_place_params[:city_guide_place_id])
		previous_rank = @city_guide_place.position
		@city_guide_place.insert_at city_guide_place_params[:position].to_i
		#@city_guide_place.save
		@city_guide_place.place.update_score(previous_rank, city_guide_place_params[:position].to_i)
		render nothing: true
	end

	def send_to_archive

		@city_guide_place.remove_from_list
		@city_guide_place.save

	
	    render nothing: true

	end
	
	private

	def set_city_guide_place
		@city_guide_place = CityGuidePlace.find(params[:id]);
	end

	def city_guide_place_params
		params.require(:city_guide_place).permit(:city_guide_place_id, :position, :city_guide_id, :place_id)
	end

end
