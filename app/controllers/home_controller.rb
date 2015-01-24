class HomeController < ApplicationController
	after_action :get_social_friends, only: [:index]
	def index
		
	end

	private
	
	def get_social_friends
		
		if user_signed_in?
			socialfriends = SocialFriends.new({fb_token: current_user.token})
			fb_friends = socialfriends.GetFacebookFriends
		end

	end
end