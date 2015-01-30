class HomeController < ApplicationController
	after_action :get_social_friends, only: [:index]
	def index
	end

	def feed
		@user = current_user
		@city_guides = CityGuide.joins(user: :followers).where("followships.follower_id = ?", @user.id)
	end
	private
	
	def get_social_friends
		
		if user_signed_in?
			social_params = {}
			social_params[:fb_token] = current_user.token if current_user.token
			
			current_user.authorizations.all.each do |auth|
				get_params social_params, auth.provider
			end
		
		
			socialfriends = SocialFriends.new(social_params)
			fb_friends = socialfriends.get_facebook_friends if current_user.token
			twitter_friends = socialfriends.get_twitter_friends if current_user.authorizations.where(provider: 'Twitter').first
			linkedin_connections = socialfriends.get_linkedin_connections if current_user.authorizations.where(provider: 'LinkedIn').first
		end

	end

	def get_params(social_params, auth)
		social_params["#{auth.downcase}_token".to_sym] = current_user.authorizations.where(provider: auth).first.token
		social_params["#{auth.downcase}_secret".to_sym] = current_user.authorizations.where(provider: auth).first.secret
		social_params["#{auth.downcase}_user_id".to_sym] = current_user.authorizations.where(provider: auth).first.uid.to_i
	end

end