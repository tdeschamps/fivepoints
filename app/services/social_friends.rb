class SocialFriends

	def initialize(args = {})
		@fb_token = args[:fb_token]
		@twitter_token = args[:twitter_token]
		@twitter_secret = args[:twitter_secret]
		@twitter_user_id = args[:twitter_user_id]
		@linkedin_token = args[:linkedin_token]
		@linkedin_secret = args[:linkedin_secret]

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

	def GetLinkedinConnections
		client = LinkedIn::Client.new(ENV['LINKEDIN_KEY'], ENV['LINKEDIN_SECRET'])
		client.authorize_from_access(@linkedin_token, @linkedin_secret)
		p client
		client.connections

	end

end