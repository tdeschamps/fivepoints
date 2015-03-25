class AddLatLongToBlackBooks < ActiveRecord::Migration
  def change
  	add_column :black_books, :latitude, :float
  	add_column :black_books, :longitude, :float
  end
end
