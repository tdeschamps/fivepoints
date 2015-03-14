class UsersController < ApplicationController
	before_action :set_user, only: [:show, :edit, :update] 
	before_action :user_params, only: [:create, :update]

	rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

	def show
		@black_books = @user.black_books.paginate(page: params[:page], per_page: 5).order('updated_at DESC')
		
		respond_to do |format|
  			format.html
  			format.js
  		end
	end

	def edit
		authorize @user
	end

	def update
		authorize @user
		@user.update(user_params)

		respond_to do |format|
			format.html
			format.js
		end
	end
	
	private
	
	def user_params
		params.require(:user).permit(:username, :email)

	end

	def set_user
		@user = User.includes(:followers, :following, black_books: :places).find(params[:id])
	end

	def user_not_authorized
    	flash[:alert] = "You are not authorized to perform this action."
    	redirect_to(request.referrer || new_user_registration_path)
  	end
end
