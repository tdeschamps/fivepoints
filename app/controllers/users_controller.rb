class UsersController < ApplicationController
	before_action :set_user, only: [:show, :edit, :update] 
	before_action :user_params, only: [:create, :update]

	rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

	def show
		@black_books = @user.black_books.paginate(page: params[:page], per_page: 4).order('updated_at DESC')
		@followers = @user.followers.paginate(page: params[:page], per_page: 5)
		@following = @user.following.paginate(page: params[:page], per_page: 5)

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
		user_params[:file] ? @user.uploaded_files.create(file: user_params[:file]) : @user.update(user_params)
		@user.save

		respond_to do |format|
			format.html {redirect_to edit_user_path(@user)}
			format.js {render nothing: true}
		end
	end
	
	def get_more_followers
		@followers = @user.followers.paginate(page: params[:page], per_page: 5)

		respond_to do |format|
  			format.html
  			format.js
  		end
	end

	def get_more_followings
		@following = @user.following.paginate(page: params[:page], per_page: 5)

		respond_to do |format|
  			format.html
  			format.js
  		end
	end

	private
	
	def user_params
		params.require(:user).permit(:username, :email, :file, :biography)

	end

	def set_user
		begin
			@user = User.includes(:authorizations, black_books: :places).friendly.find(params[:id])	
		rescue	
			@user = User.includes(:authorizations, black_books: :places).find(params[:id])
		end	
	end

	def user_not_authorized
    	flash[:alert] = "You are not authorized to perform this action."
    	redirect_to(request.referrer || new_user_registration_path)
  	end
end
