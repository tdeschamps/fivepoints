class HomeController < ApplicationController
	after_action :get_social_friends, only: [:index]
	def index
		
	end

	private
	
	def get_social_friends
		social_params = {}
		social_params[:fb_token] = current_user.token if current_user.token
		
		if current_user.authorizations.where(provider: 'Twitter').first
			social_params[:twitter_token] = current_user.authorizations.where(provider: 'Twitter').first.token
			social_params[:twitter_secret] = current_user.authorizations.where(provider: 'Twitter').first.secret
			social_params[:twitter_user_id] = current_user.authorizations.where(provider: 'Twitter').first.uid.to_i
		end	

		if user_signed_in?
			socialfriends = SocialFriends.new(social_params)
			fb_friends = socialfriends.GetFacebookFriends if current_user.token
			twitter_friends = socialfriends.GetTwitterFriends if current_user.authorizations.where(provider: 'Twitter').first
			p fb_friends
			p twitter_friends
		end

	end
end