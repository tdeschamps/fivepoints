class RemoveColumnStoryFromPlacesAndAddStoryToBlackBookPlaces < ActiveRecord::Migration
  def change
  	add_column :black_book_places, :story, :text
  	remove_column :places, :story
  end
end
