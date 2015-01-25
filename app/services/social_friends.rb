class SocialFriends

	def initialize(args = {})
		@fb_token = args[:fb_token]
		@twitter_token = args[:twitter_token]
		@twitter_secret = args[:twitter_secret]
		@twitter_user_id = args[:twitter_user_id]

	end

	def GetFacebookFriends
		@graph = Koala::Facebook::API.new(@fb_token)
		friends = @graph.get_connections("me", "friends")
	end

	def GetTwitterFriends

		client = Twitter::REST::Client.new do |config|
		  config.consumer_key        = ENV['TWITTER_KEY']
		  config.consumer_secret     = ENV['TWITTER_SECRET']
		  config.access_token        = @twitter_token	
		  config.access_token_secret = @twitter_secret
		end

		friends = client.friend_ids
	end

end