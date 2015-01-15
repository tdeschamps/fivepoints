class CityGuidePlace < ActiveRecord::Base
	include RankedModel

	belongs_to :city_guide
	ranks :rank,
		with_same: :city_guide_id 
	
	belongs_to :place
	

end
