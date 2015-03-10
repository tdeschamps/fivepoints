class PlacesController < ApplicationController
	respond_to :html, :js
	before_action :foursquare_place_params, only: [:create_place_from_black_book]
	before_action :place_params, only: [:create]
	before_action :set_place, only: [:show]
	
	rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

	def index

	end
	
	def show
		@geolocations = MapMarkersGenerator.new(@place).create_markers()
		@place_coordinates = [@place.latitude, @place.longitude]

		@similar_places = Place.where("category like :category AND id != :id ", {category:@place.category, id: @place.id}).near([@place.latitude, @place.longitude]).limit(5).order("RANDOM()")
		@active_black_books = BlackBook.joins(:black_book_places).where("black_book_places.place_id = ? AND black_book_places.position IS NOT NULL", @place.id)

		@attributes = %w(address city category)

	end

	def new
		@place = Place.new()
		authorize @place
	end

	def create
		@place = Place.create(place_params)
		authorize @place
	end
	
	def create_place_from_black_book

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

		respond_to do |format|

      		if @place.persisted?
      			if @place.black_book_places.find_by_black_book_id(@foursquare_place_params[:black_book_places_attributes]["0"][:black_book_id])
      			#@black_book_place = @place.black_book_places.where(black_book_id: @black_book_id).first
	      			format.html { render action: 'new' }
	      			format.json { render json: 'no_new_place', status: :found }
	      			format.js   { render action: 'no_new_place', status: :found }
	      		else
	      			@black_book_place = @place.black_book_places.create(@foursquare_place_params[:black_book_places_attributes]["0"])
	      			format.html { redirect_to @place, notice: 'Place was successfully created.' }
	      			format.json { render json: 'create_new_place', status: :created, location: black_book_place(@black_book_place) }
	      			format.js   { render action: 'create_new_place', status: :created, locals: {place: @place, black_book_place: @black_book_place} }
      			end
      		else
      			format.html { render action: 'new' }
      			format.json { render json: @place.errors, status: :unprocessable_entity }
      			format.js   { render json: @place.errors, status: :unprocessable_entity }
      		end
      	end
	end

	

	private

	def set_place
		@place = Place.includes(:uploaded_files, black_books: :user).find(params[:id])
	end

	def place_params
		params.require(:place).permit(:foursquare_id, :city, :zipcode, :name, :address, :category, :state, black_book_places_attributes: [:rank, :black_book_id])
	end

	def foursquare_place_params
		@foursquare_place_params = params.require(:place)
										.permit(:foursquare_id, :city, :zipcode, :name, :address, :latitude, :longitude, :category, :state, 
												black_book_places_attributes: [:position, :black_book_id, :place, :story, 
												uploaded_files_attributes: [:file]]
												)
	end

	def user_not_authorized
    	flash[:alert] = "You are not authorized to perform this action."
    	redirect_to(request.referrer || new_user_registration_path)
  	end
end
