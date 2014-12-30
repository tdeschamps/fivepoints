class Place < ActiveRecord::Base
	has_many :city_guide_places
	has_many :city_guides, through: :city_guide_places
end
