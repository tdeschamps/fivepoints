class CityGuidePolicy
	attr_reader :user, :city_guide


	def initialize(user, city_guide)
		@user = user
		@city_guide = city_guide
	end

	def new?
		user.sign_in?
	end

	def create?
		user.sign_in?
	end

	def edit?
		city_guide.user == user
	end
end