class BlackBook < ActiveRecord::Base
	validates :name, :city, presence: true 
	belongs_to :user
	has_many :black_book_places
	has_many :places, through: :black_book_places
	has_many :uploaded_files, as: :imageable
	accepts_nested_attributes_for :uploaded_files, :allow_destroy => true
	geocoded_by :formatted_address
	after_create :geocode
	scope :friends, ->(user) {
		joins(user: :followers).where("followships.follower_id = ?", user.id)
	}
	geocoded_by :formatted_address
  	after_create :geocode

	acts_as_votable
	self.per_page = 6

	def self.search_around(search_query)
    	near(search_query)
  	end
end
