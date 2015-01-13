class PlacesController < ApplicationController
	
	def index
	end

	def create_from_city_guide
	end

	def new
		@place = Place.new()
	end

	private
	
	def foursquare_place_params
	end
end
