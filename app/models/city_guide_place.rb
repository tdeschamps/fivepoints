class CityGuidePlace < ActiveRecord::Base
	include RankedModel

	belongs_to :city_guide
	belongs_to :place
	
	ranks :rank,
		with_same: :city_guide_id 
	
	has_many :uploaded_files, as: :imageable
	accepts_nested_attributes_for :uploaded_files, :allow_destroy => true
	
end
