class Place < ActiveRecord::Base
	has_many :city_guide_places
	has_many :city_guides, through: :city_guide_places
	after_create :set_foursquare_picture, :update_score

	accepts_nested_attributes_for :city_guide_places, allow_destroy: true

	geocoded_by :address
  	after_validation :geocode, if: :address_changed?

  	def update_score(previous_rank, new_rank)
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
		foursquare_additional_infos = FoursquarePicture.new(self.id).GetAdditionalInfos()
		self.update(foursquare_additional_infos)
	end
end
