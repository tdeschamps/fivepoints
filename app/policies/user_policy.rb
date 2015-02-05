class UserPolicy
	attr_reader :user, :profile_user

	def initialize(user,profile_user)
    	@user = user
    	@profile_user = profile_user
  	end

  	def edit?
    	user == profile_user 
  	end

  	def update?
    	user == profile_user 
  	end

end