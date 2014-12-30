class CityGuidePlace < ActiveRecord::Base
	belongs_to :city_guide
	belongs_to :place
end
