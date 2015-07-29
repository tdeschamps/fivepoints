class BlackBook < ActiveRecord::Base
	extend FriendlyId
	validates :name, :city, presence: true 
	belongs_to :user
	has_many :black_book_places
	has_many :places, through: :black_book_places
	has_many :uploaded_files, as: :imageable
	has_many :activities, as: :trackable, class_name: 'PublicActivity::Activity', dependent: :destroy
	accepts_nested_attributes_for :uploaded_files, :allow_destroy => true
	friendly_id :slug_candidates, :use => :history
	geocoded_by :formatted_address
	after_validation :geocode, if: :formatted_address_changed?
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

  	def should_generate_new_friendly_id?
  		slug.blank? || name_changed?  
  	end
  	
  	def slug_candidates
    [
      :name,
      [:name, :city],
      [:name, :user_id, :city],
    ]
  end
end
