class FollowshipsController < ApplicationController

	def create
    	user = User.find(params[:followed_id])
    	current_user.follow(user)
    	respond_to do |format|
    	  format.html { redirect_to user }
    	  format.js	  { render action: 'create', status: :created, locals: {user: user} }
    	end
  	end

	def destroy
	    user = Followship.find(params[:id]).followed
	    current_user.unfollow(user)

	    respond_to do |format|
	      format.html { redirect_to user }
	      format.js   { render action: 'destroy', status: :created, locals: {user: user} }
	    end
	end
end
