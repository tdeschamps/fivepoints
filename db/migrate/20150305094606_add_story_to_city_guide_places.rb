class AddStoryToBlackBookPlaces < ActiveRecord::Migration
  def change
  	add_column :black_book_places, :story, :text 
  end
end
