class UsersController < ApplicationController
	before_action :set_user 
	before_action :user_params, only: [:create, :update]

	def show
	end

	private
	
	def user_params	
	end

	def set_user
		@user = User.find(params[:id])
	end
end
