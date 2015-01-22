class AddFoursquareRatingToPlaces < ActiveRecord::Migration
  def change
    add_column :places, :foursquare_rating, :float
  end
end
