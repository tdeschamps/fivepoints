class Place < ActiveRecord::Base
	has_many :city_guide_places
	has_many :city_guides, through: :city_guide_places
	after_create :set_foursquare_picture

	accepts_nested_attributes_for :city_guide_places, allow_destroy: true

	geocoded_by :address
  	after_validation :geocode, if: :address_changed?

  	private
  	
  	def set_foursquare_picture
		foursquare_picture_url = FoursquarePicture.new({foursquare_id: ENV['4SQ_CLIENT_ID'].to_s,
							foursquare_secret: ENV['4SQ_CLIENT_SECRET'].to_s,
							place_id: self.id}).GetPicture()
		self.update(foursquare_picture_url: foursquare_picture_url)
	end
end
