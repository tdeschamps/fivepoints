class HomeController < ApplicationController
	after_action :get_social_friends, only: [:index]
	
	def index
		@black_book_pictures = %w(berlin los_angeles paris shanghai lisbon)
		@cities_pictures = %w(paris berlin san-francisco tokyo sydney cape-town)
	end

	def feed
		@user = current_user
		@black_books = BlackBook.friends(@user)
	end

	def terms
	end

	def about_us
	end

	def help
	end
	
	private
	
	def get_social_friends
		
		if user_signed_in?
			social_params = {}
			
			current_user.authorizations.find_each do |auth|
				get_params social_params, auth.provider
			end
			socialfriends = SocialFriends.new(social_params)
			
			if social_params[:facebook_token]
				fb_friends = socialfriends.get_facebook_friends 
				SocialFriendshipBuilder.perform_later current_user.id, fb_friends, 'Facebook'
			end	

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