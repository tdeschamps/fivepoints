class CreateCityGuidePlaces < ActiveRecord::Migration
  def change
    create_table :city_guide_places do |t|
    	t.references :city_guides
    	t.references :cities
    	t.integer :rank
      t.timestamps
    end
  end
end
