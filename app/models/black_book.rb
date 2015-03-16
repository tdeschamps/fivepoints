class BlackBook < ActiveRecord::Base
	validates :name, :city, presence: true 
	belongs_to :user
	has_many :black_book_places
	has_many :places, through: :black_book_places
	has_many :uploaded_files, as: :imageable
	accepts_nested_attributes_for :uploaded_files, :allow_destroy => true

	scope :friends, ->(user) {
		joins(user: :followers).where("followships.follower_id = ?", user.id)
	}

	self.per_page = 10
end
