class CityGuide < ActiveRecord::Base
	belongs_to :user
	has_many :city_guide_places
	has_many :places, through: :city_guide_places
	has_many :uploaded_files, as: :imageable
	accepts_nested_attributes_for :uploaded_files, :allow_destroy => true
end
