class Place < ActiveRecord::Base
	has_many :city_guide_places
	has_many :city_guides, through: :city_guide_places
	accepts_nested_attributes_for :city_guide_places, allow_destroy: true

	geocoded_by :address
  	after_validation :geocode, if: :address_changed?
end
