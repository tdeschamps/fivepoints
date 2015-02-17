class CityGuidePlace < ActiveRecord::Base
	include RankedModel
	after_create :set_row_order
	belongs_to :city_guide
	belongs_to :place
	
	ranks :row_order,
		with_same: :city_guide_id 
	
	has_many :uploaded_files, as: :imageable
	accepts_nested_attributes_for :uploaded_files, :allow_destroy => true
	
	private

	def set_row_order
		self.row_order = self.city_guide.city_guide_places.count + 1
		self.save
	end
end
