class CreatePlaces < ActiveRecord::Migration
  def change
    create_table :places do |t|
    	t.string :name
    	t.string :city
    	t.integer :zipcode
    	t.string :address
    	t.float :longitude
    	t.float :latitude
    	t.integer :ranking

      t.timestamps
    end
  end
end
