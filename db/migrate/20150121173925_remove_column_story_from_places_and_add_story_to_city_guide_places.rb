class RemoveColumnStoryFromPlacesAndAddStoryToCityGuidePlaces < ActiveRecord::Migration
  def change
  	add_column :city_guide_places, :story, :text
  	remove_column :places, :story
  end
end
