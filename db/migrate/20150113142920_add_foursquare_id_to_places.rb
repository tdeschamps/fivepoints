class AddFoursquareIdToPlaces < ActiveRecord::Migration
  def change
    add_column :places, :foursquare_id, :integer
    add_column :places, :story, :text
  end
end
