class BlackBooksController < ApplicationController
	respond_to :html, :js
	before_action :set_user, only: [:new, :create, :update]
	before_action :set_black_book, only: [:edit, :update, :show]

	rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
	
	def show
		@black_book_places = @black_book.black_book_places.includes(:place).active_places
		@places = @black_book.places.joins(:black_book_places).where.not(black_book_places: {position: nil})
		
		@city_coordinates = (Geocoder.search @black_book.formatted_address)[0].data["geometry"]["location"].map { |k, v| v}
		@geolocations = MapMarkersGenerator.new(@places).create_markers

		@attributes = %w(address city category)
	end

	def new
		@black_book = BlackBook.new()
		@uploaded_file = @black_book.uploaded_files.build()
		authorize @black_book
	end
	
	def create
		@black_book = @user.black_books.new(black_book_params)
		authorize @black_book
		@black_book.save
		redirect_to edit_user_black_book_path(@user, @black_book)
	end
	
	def edit
		
		authorize @black_book
		
		@black_book_places = @black_book.black_book_places.active_places
		@archived_black_book_places = @black_book.black_book_places.archived_places
		city_boundaries_latitudes, city_boundaries_longitudes = [], []
		@city_coordinates = (Geocoder.search @black_book.formatted_address)[0].data["geometry"]["location"].map { |k, v| v}
		if @black_book_places.count > 1

			@black_book_places.each do |a|
					a = a.place 
					city_boundaries_latitudes << a.latitude if a.latitude
					city_boundaries_longitudes << a.longitude if a.longitude
			end
			
			@city_boundaries_coordinates= [[city_boundaries_latitudes.min,city_boundaries_longitudes.min], [city_boundaries_latitudes.max, city_boundaries_longitudes.max]].to_json
		end
		
		@place = Place.new()
		@new_black_book_places = @place.black_book_places.build()
		@new_black_book_places_file = @new_black_book_places.uploaded_files.build()
		@geolocations = MapMarkersGenerator.new(@black_book.places.where(black_book_places: {position: [1..5]})).create_markers()
	end
	
	def index
		@black_books = @user.black_books.all
		@friends_black_books = BlackBook.friends(@user).includes(:black_book_places).limit(10)
	end

	private

	def set_user
		@user = User.find(params[:user_id])
	end

	def black_book_params
		params.require(:black_book).permit(:user_id, :city, :formatted_address, :country, :state, :name, :story, uploaded_files_attributes: [:file])
	end

	def set_black_book
		@black_book = BlackBook.includes(:places).find(params[:id])
	end
	
	def user_not_authorized
    	flash[:alert] = "You are not authorized to perform this action."
    	redirect_to(request.referrer || new_user_registration_path)
  	end

end
