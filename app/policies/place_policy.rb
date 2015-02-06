class PlacePolicy
	attr_reader :user, :place

	def initialize(user, place)
		@user = user
		@place = place
	end

	def new?
		user
	end
end