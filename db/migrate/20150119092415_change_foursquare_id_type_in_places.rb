class ChangeFoursquareIdTypeInPlaces < ActiveRecord::Migration
  def change
  	
  		change_column :places, :foursquare_id, :string
  
  end

end
