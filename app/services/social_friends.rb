class SocialFriends

	def initialize(args = {})
		@fb_token = args[:fb_token]
	end

	def GetFacebookFriends
		@graph = Koala::Facebook::API.new(@fb_token)
		friends = @graph.get_connections("me", "friends")
	end

end