class Place < ActiveRecord::Base
  extend FriendlyId
	has_many :black_book_places
	has_many :black_books, through: :black_book_places
  has_many :uploaded_files, as: :imageable
  has_and_belongs_to_many :categories, -> {uniq}
	after_create :set_foursquare_picture
  after_update :save_foursquare_picture,  if: :foursquare_picture_url_changed?
  
	accepts_nested_attributes_for :black_book_places, allow_destroy: true
  friendly_id :name, use: :slugged
	geocoded_by :address
  after_create :geocode, if: Proc.new {|c| c.latitude.nil? && c.longitude.nil?}

  scope :friends, ->(user) {
    joins(black_books: {user: :followers}).where("followships.follower_id = ?", user.id)
  }

  self.per_page = 6
  
  def update_score(previous_rank = 0 , new_rank = 0)
  	return if (previous_rank == new_rank && new_rank == nil)
    scores = {
  		"1"=> 10,
  		"2"=> 6,
  		"3"=> 4,
  		"4"=> 2,
  		"5"=> 1,
  		"0"=> 0 
  	}
  	previous_rank = "0" if previous_rank.to_i > 5 || previous_rank.nil?
  	new_rank = "0" if new_rank.to_i > 5 || new_rank.nil?

  	ranking = self.ranking || scores[previous_rank.to_s]
    p scores[new_rank.to_s] - scores[previous_rank.to_s]
  	self.ranking = ranking + scores[new_rank.to_s] - scores[previous_rank.to_s]
		self.save   	
  end
  
  def self.search_around(search_query)
    near(search_query)
  end

  def slug_candidates
    [
      :name,
      [:name, :city],
      [:name, :category, :city]
    ]
  end
  private
  	
	def set_foursquare_picture
		foursquare_additional_infos = FoursquareInfos.new(self).get_additional_infos()
		self.update(foursquare_additional_infos)
	end

  def save_foursquare_picture
    #FoursquarePicture.perform_later self.id
    
    # begin
    #   self.uploaded_files.new.file_from_url self.foursquare_picture_url 
    # rescue Exception => e
    #   p e.message
    #   self
    # end
  
  end

end
