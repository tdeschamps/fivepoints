class CityGuidesController < ApplicationController
	before_action :set_user, only: [:new, :create, :update]
	def new
		@city_guide = CityGuide.new()
	end
	
	def index
	end

	private

	def set_user
		@user = User.find(params[:user_id])
	end

end
