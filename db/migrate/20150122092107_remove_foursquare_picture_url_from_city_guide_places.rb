class RemoveFoursquarePictureUrlFromBlackBookPlaces < ActiveRecord::Migration
  def change
  	remove_column :black_book_places, :foursquare_picture_url, :string
  	add_column :places, :foursquare_picture_url, :string
  end
end
