class CityGuidePlace < ActiveRecord::Base

	belongs_to :city_guide
	belongs_to :place
	has_many :uploaded_files, as: :imageable

	scope :active_places , -> { where(position: [1..5]).order('position ASC') }
	scope :archived_places , -> { where.not(position: [1..5]) }

	acts_as_list scope: :city_guide
	
	

	accepts_nested_attributes_for :uploaded_files, :allow_destroy => true
	
end
