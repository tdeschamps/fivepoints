class AddStoryToCityGuidePlaces < ActiveRecord::Migration
  def change
  	add_column :city_guide_places, :story, :text 
  end
end
