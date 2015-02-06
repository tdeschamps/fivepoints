class AddIndexToCityGuidePlaces < ActiveRecord::Migration
  def change
  	add_index :city_guide_places, :city_guide_id
  	add_index :city_guide_places, :place_id
  end
end
