class CityGuidesController < ApplicationController
	respond_to :html, :js
	before_action :set_user, only: [:new, :create, :update]
	before_action :set_city_guide, only: [:edit, :update, :show]

	rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
	
	def show
		@city_guide_places = @city_guide.city_guide_places.all
		@places = @city_guide.places.all
		@geolocations = places_coordinates @places
	end

	def new
		@city_guide = CityGuide.new()
		@uploaded_file = @city_guide.uploaded_files.build()
		authorize @city_guide
	end
	
	def create
		@city_guide = @user.city_guides.new(city_guide_params)
		authorize @city_guide
		@city_guide.save
		redirect_to edit_user_city_guide_path(@user, @city_guide)
	end
	
	def edit
		authorize @city_guide
		@city_guide_places = @city_guide.city_guide_places.all
		@city_latitudes, @city_longitudes = [], []
		
		@city_guide.places.all.each do |a| 
				@city_latitudes << a.latitude
				@city_longitudes << a.longitude
			end

		@city_coordinates= [[@city_latitudes.min,@city_longitudes.min], [@city_latitudes.max, @city_longitudes.max]].to_json
		@place = Place.new()
		@new_city_guide_places = @place.city_guide_places.build()
		@new_city_guide_places_file = @new_city_guide_places.uploaded_files.build()
		@geolocations = places_coordinates @city_guide.places
	end
	
	def index
		@city_guides = @user.city_guides.all
		@friends_city_guides = CityGuide.friends(@user).includes(:city_guide_places).limit(10)
	end

	private

	def set_user
		@user = User.find(params[:user_id])
	end

	def city_guide_params
		params.require(:city_guide).permit(:user_id, :city, :country, :state, :name, :story, uploaded_files_attributes: [:file])
	end

	def set_city_guide
		@city_guide = CityGuide.find(params[:id])
	end
	
	def user_not_authorized
    	flash[:alert] = "You are not authorized to perform this action."
    	redirect_to(request.referrer || new_user_registration_path)
  	end

  	def places_coordinates(collections) 
  		
  		@geolocations = Array.new

  		collections.each do |place|
  		  @geolocations << {
  		    type: 'Feature',
  		    geometry: {
  		      type: 'Point',
  		      coordinates: [place.longitude, place.latitude]
  		    },
  		    properties: {
  		      name: place.name,
  		      address: place.address,
  		      :'marker-color' => '#FF4A50',
  		      :'marker-symbol' => 'circle',
  		      :'marker-size' => 'medium'
  		    }
  		  }
  		end
  		return @geolocations.to_json
  	end 

end
