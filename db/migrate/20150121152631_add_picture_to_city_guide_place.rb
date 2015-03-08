class AddPictureToBlackBookPlace < ActiveRecord::Migration
  def change
    add_column :black_book_places, :foursquare_picture_url, :string
  end
end
