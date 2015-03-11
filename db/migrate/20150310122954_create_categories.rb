class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
    	t.string :name
    	t.string :plural_name
    	t.string :short_name

    	t.timestamps null: false
    end

    create_table :categories_places, id: false do |t|
    	t.references :place 
    	t.references :category
    end

    add_index :categories_places, [:category_id, :place_id]
  end
end
