class CityGuidesController < ApplicationController
	before_action :set_user, only: [:new, :create, :update]
	before_action :set_city_guide, only: [:edit, :update]
	def new
		@city_guide = CityGuide.new()
		@uploaded_file = @city_guide.uploaded_files.build()
	end
	
	def create
		@cityguide = @user.city_guides.create(city_guide_params)
		redirect_to edit_user_city_guide_path(@user, @cityguide)
	end
	
	def edit
	end
	
	def index
	end

	private

	def set_user
		@user = User.find(params[:user_id])
	end

	def city_guide_params
		params.require(:city_guide).permit(:user_id, :city, :name, :story, uploaded_files_attributes: [:file])
	end

	def set_city_guide
		@cityguide = CityGuide.find(params[:id])
	end
end
