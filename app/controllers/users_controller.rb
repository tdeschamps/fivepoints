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
		user_params[:file] ? @user.uploaded_files.create(file: user_params[:file]) : @user.update(user_params)
		@user.save

		respond_to do |format|
			format.html {redirect_to edit_user_path(@user)}
			format.js {render nothing: true}
		end
	end
	
	private
	
	def user_params
		params.require(:user).permit(:username, :email, :file)

	end

	def set_user
		@user = User.includes(:followers, :following, black_books: :places).find(params[:id])
	end

	def user_not_authorized
    	flash[:alert] = "You are not authorized to perform this action."
    	redirect_to(request.referrer || new_user_registration_path)
  	end
end
