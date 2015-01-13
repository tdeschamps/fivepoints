class CityGuidesController < ApplicationController
	respond_to :html, :js
	before_action :set_user, only: [:new, :create, :update]
	before_action :set_city_guide, only: [:edit, :update, :create_place_from_city_guide]
	def new
		@city_guide = CityGuide.new()
		@uploaded_file = @city_guide.uploaded_files.build()
	end
	
	def create
		@cityguide = @user.city_guides.create(city_guide_params)
		redirect_to edit_user_city_guide_path(@user, @cityguide)
	end

	def create_place_from_city_guide
		@place = Place.new(place_params)
		@cityguide.city_guide_places.create(place_id: @place.id)
		
		respond_to do |format|
      		if @place.save
      			format.html { redirect_to @cityguide, notice: 'Person was successfully created.' }
      			format.json { render action: 'edit', status: :created, location: @person }
      			# added:
      			format.js   { render action: 'edit', status: :created, location: @person }
      		else
      			format.html { render action: 'new' }
      			format.json { render json: @place.errors, status: :unprocessable_entity }
      			# added:
      			format.js   { render json: @place.errors, status: :unprocessable_entity }
      		end
      	end
	end
	
	def edit
		@places = @cityguide.places.all
		@place = Place.new()

		respond_with do |format|
      		format.js
      		format.html
      	end
      	
	end
	
	def index
	end

	private

	def set_user
		@user = User.find(params[:user_id])
	end

	def city_guide_params
		params.require(:city_guide).permit(:user_id, :city, :country, :state, :story, uploaded_files_attributes: [:file])
	end

	def set_city_guide
		@cityguide = CityGuide.find(params[:id])
	end

	def place_params
		params.require(:place).permit(:foursquare_id, :city, :zipcode, :name, :address, :category, :state, :story)
	end
end
