class CreateCityGuides < ActiveRecord::Migration
  def change
    create_table :city_guides do |t|
    	t.string :city
    	t.references :user
    	t.text :story
      t.timestamps
    end
  end
end
