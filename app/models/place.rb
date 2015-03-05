class Place < ActiveRecord::Base
	has_many :city_guide_places
	has_many :city_guides, through: :city_guide_places
  has_many :uploaded_files, as: :imageable
	after_create :set_foursquare_picture, :update_score
  after_update :save_foursquare_picture,  if: :foursquare_picture_url_changed?
  
	accepts_nested_attributes_for :city_guide_places, allow_destroy: true

	#geocoded_by :address
  	#after_validation :geocode, if: :address_changed?

  def update_score(previous_rank = 0 , new_rank = 0)
  	scores = {
  		"1"=> 10,
  		"2"=> 6,
  		"3"=> 4,
  		"4"=> 2,
  		"5"=> 1,
  		"0"=> 0 
  	}

  	previous_rank = "0" if previous_rank > 5 || previous_rank.nil?
  	new_rank = "0" if new_rank > 5 || new_rank.nil?
  	ranking = self.ranking || scores[previous_rank.to_s]

  	self.ranking = ranking + scores[new_rank.to_s] - scores[previous_rank.to_s]
		self.save   	
  end
  
  private
  	
	def set_foursquare_picture
		foursquare_additional_infos, picture_group = FoursquareInfos.new(self).get_additional_infos()
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
