class RemoveStoryFromBlackBookPlaces < ActiveRecord::Migration
  def up
  	remove_column :black_book_places, :story
  end

  def down 
  	add_column :black_book_places, :story, :text
  end
end
