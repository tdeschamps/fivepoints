class BlackBook < ActiveRecord::Base
	validates :name, :city, presence: true 
	belongs_to :user
	has_many :black_book_places
	has_many :places, through: :black_book_places
	has_many :uploaded_files, as: :imageable
	accepts_nested_attributes_for :uploaded_files, :allow_destroy => true
	geocoded_by :formatted_address
	after_validation :geocode
	scope :friends, ->(user) {
		joins(user: :followers).where("followships.follower_id = ?", user.id)
	}

	acts_as_votable
	self.per_page = 6

	include PublicActivity::Model
	tracked owner: Proc.new { |controller, model| controller.current_user ? controller.current_user : nil }
	
	def self.search_around(search_query)
    	near(search_query)
  	end
end
