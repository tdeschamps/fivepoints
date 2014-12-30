class CityGuide < ActiveRecord::Base
	belongs_to :user
	has_many :city_guide_places
	has_many :places, through: :city_guide_places
end
