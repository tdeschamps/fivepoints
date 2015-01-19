class PlacesController < ApplicationController
	respond_to :html, :js
	before_action :foursquare_place_params, only: [:create_place_from_city_guide]

	def index
	end
	
	def create
		@place = Place.create(place_params)
	end
	
	def create_place_from_city_guide

		@place = Place.find_or_create_by(foursquare_id: @foursquare_place_params[:foursquare_id]) do |place|
			
			place.city = @foursquare_place_params[:city]
			place.zipcode = @foursquare_place_params[:zipcode]
			place.name = @foursquare_place_params[:name]
			place.address = @foursquare_place_params[:address] 
			place.latitude = @foursquare_place_params[:latitude]
			place.longitude = @foursquare_place_params[:longitude]
			place.category = @foursquare_place_params[:category]
			place.state = @foursquare_place_params[:state]
		
		end
		
		@city_guide_id = @foursquare_place_params[:city_guide_places_attributes]["0"][:city_guide_id]
		
		respond_to do |format|

      		if @place.persisted?
      			@city_guide_place = @place.city_guide_places.create(@foursquare_place_params[:city_guide_places_attributes]["0"])
      			#@city_guide_place = @place.city_guide_places.where(city_guide_id: @city_guide_id).first
      			format.html { redirect_to @place, notice: 'Place was successfully created.' }
      			format.json { render action: 'create_new_place', status: :created, location: city_guide_place(@city_guide_place) }
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
	
	def place_params
		params.require(:place).permit(:foursquare_id, :city, :zipcode, :name, :address, :category, :state, city_guide_places_attributes: [:rank, :city_guide_id])
	end

	def foursquare_place_params
		@foursquare_place_params = params.require(:place).permit(:foursquare_id, :city, :zipcode, :name, :address, :latitude, :longitude, :category, :state, city_guide_places_attributes: [:rank, :city_guide_id])
	end
end
