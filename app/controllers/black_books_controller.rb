class BlackBooksController < ApplicationController
	respond_to :html, :js
	before_action :set_user, only: [:new, :create, :update]
	before_action :set_black_book, only: [:edit, :update, :show, :downvote, :upvote]

	rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
	
	def show
		@black_book_places = @black_book.black_book_places.includes(:place).active_places.order('position desc')
		@places = @black_book.places.select("places.*, black_book_places.position as place_position").joins(:black_book_places).where.not(black_book_places: {position: nil}).order('place_position asc')
		
		@city_coordinates = [@black_book.longitude, @black_book.latitude]
		@geolocations = MapMarkersGenerator.new(@places).create_markers

		@voters = @black_book.votes_for.up.by_type(User).voters
	end

	def new
		@black_book = BlackBook.new()
		uploaded_file = @black_book.uploaded_files.build()
		authorize @black_book
	end
	
	def create
		@black_book = @user.black_books.new(black_book_params)
		authorize @black_book	
		@black_book.save
		begin
			image = @black_book.uploaded_files.new
			image.file_from_url "https://api.tiles.mapbox.com/v4/#{ENV['MAPBOX_MAP_ID']}/#{@black_book.longitude},#{@black_book.latitude},9/1200x800.png?access_token=#{ENV['MAPBOX_ACCESS_TOKEN']}"
			image.save
		end
		if @black_book.save
			redirect_to edit_user_black_book_path(@user, @black_book)
		else
			render action: :new
		end	
	end
	
	def edit
		
		authorize @black_book
		
		@black_book_places = @black_book.black_book_places.active_places
		@archived_black_book_places = @black_book.black_book_places.archived_places
		city_boundaries_latitudes, city_boundaries_longitudes = [], []
		@city_coordinates = [@black_book.latitude, @black_book.longitude]
		
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
		if params[:search]
			@friends_black_books = BlackBook.includes(:uploaded_files).near(params[:search], 5).order('updated_at desc').paginate(:page => params[:page])
			@places = Place.includes(:black_book_places).near(params[:search], 5).order('ranking desc').paginate(:page => params[:page])
		else	
			@friends_black_books = BlackBook.friends(current_user).includes(:black_book_places, :uploaded_files).order('updated_at desc').paginate(:page => params[:page])
			@places = Place.includes(:black_book_places).friends(current_user).order('ranking desc').paginate(:page => params[:page])
		end

		@attributes = %w(address city category)
		
		respond_to do |format|
  			format.html
  			format.js
  		end
	end

	def upvote
		current_user.likes @black_book

		respond_to do |format|
  			format.html
  			format.js
  		end
	end

	def downvote
		@black_book.unliked_by current_user

		respond_to do |format|
  			format.html
  			format.js
  		end
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
