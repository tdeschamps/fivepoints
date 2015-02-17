class ChangeRankNameInCityGuidePlace < ActiveRecord::Migration
  def change
  	rename_column(:city_guide_places, :rank, :row_order)
  end
end
