class BlackBookPolicy
	attr_reader :user, :black_book


	def initialize(user, black_book)
		@user = user
		@black_book = black_book
	end

	def new?
		user
	end

	def create?
		user
	end

	def edit?
		black_book.user == user
	end
end