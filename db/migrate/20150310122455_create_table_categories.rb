class CreateTableCategories < ActiveRecord::Migration
  def change
    create_table :table_categories do |t|
    	t.string :name
    	t.string :plural_name
    	t.string :short_name
    end
  end
end
