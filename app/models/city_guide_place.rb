class CityGuidePlace < ActiveRecord::Base
	include RankedModel

	belongs_to :city_guide
	ranks :rank,
		with_same: :city_guide_id 
	
	belongs_to :place
	
	after_create :set_foursquare_picture

	private

	def set_foursquare_picture
		foursquare_picture_url = FoursquarePicture.new({foursquare_id: ENV['4SQ_CLIENT_ID'].to_s,
							foursquare_secret: ENV['4SQ_CLIENT_SECRET'].to_s,
							place_id: self.place_id}).GetPicture()
		self.update(foursquare_picture_url: foursquare_picture_url)
	end
end
