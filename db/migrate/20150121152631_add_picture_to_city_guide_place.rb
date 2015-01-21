class AddPictureToCityGuidePlace < ActiveRecord::Migration
  def change
    add_column :city_guide_places, :foursquare_picture_url, :string
  end
end
