class PlacesController < ApplicationController
	respond_to :html, :js
	before_action :foursquare_place_params, only: [:create_place_from_city_guide]
	
	def index
	end

	def create_place_from_city_guide

		@place = Place.new(@foursquare_place_params)
		@city_guide_id = @foursquare_place_params[:city_guide_places_attributes]["0"][:city_guide_id]
		respond_to do |format|
      		if @place.save
      			
      			@city_guide_place = @place.city_guide_places.where(city_guide_id: @city_guide_id).first
      			format.html { redirect_to @place, notice: 'Place was successfully created.' }
      			format.json { render action: 'create_new_place', status: :created, location: city_guide_place(@city_guide_place) }
      			# added:
      			format.js   { render action: 'create_new_place', status: :created, locals: {place: @place, city_guide_place: @city_guide_place} }
      		else
      			format.html { render action: 'new' }
      			format.json { render json: @place.errors, status: :unprocessable_entity }
      			# added:
      			format.js   { render json: @place.errors, status: :unprocessable_entity }
      		end
      	end
	end

	def new
		@place = Place.new()
	end

	private
	
	def foursquare_place_params
		@foursquare_place_params = params.require(:place).permit(:foursquare_id, :city, :zipcode, :name, :address, :category, :state, :story, city_guide_places_attributes: [:id, :city_guide_id])
	end
end
