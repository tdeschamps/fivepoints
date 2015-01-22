class RemoveFoursquarePictureUrlFromCityGuidePlaces < ActiveRecord::Migration
  def change
  	remove_column :city_guide_places, :foursquare_picture_url, :string
  	add_column :places, :foursquare_picture_url, :string
  end
end
