class ChangeRankNameInCityGuidePlace < ActiveRecord::Migration
  def change
  	rename_column(:city_guide_places, :rank, :position)
  end
end
