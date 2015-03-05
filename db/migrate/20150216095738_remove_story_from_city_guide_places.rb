class RemoveStoryFromCityGuidePlaces < ActiveRecord::Migration
  def up
  	remove_column :city_guide_places, :story
  end

  def down 
  	add_column :city_guide_places, :story, :text
  end
end
