class AddIndexToBlackBookPlaces < ActiveRecord::Migration
  def change
  	add_index :black_book_places, :black_book_id
  	add_index :black_book_places, :place_id
  end
end
