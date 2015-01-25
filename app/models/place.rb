class Place < ActiveRecord::Base
	has_many :city_guide_places
	has_many :city_guides, through: :city_guide_places
	after_create :set_foursquare_picture

	accepts_nested_attributes_for :city_guide_places, allow_destroy: true

	geocoded_by :address
  	after_validation :geocode, if: :address_changed?

  	private
  	
  	def set_foursquare_picture
		foursquare_additional_infos = FoursquarePicture.new(self.id).GetAdditionalInfos()
		self.update(foursquare_additional_infos)
	end
end
