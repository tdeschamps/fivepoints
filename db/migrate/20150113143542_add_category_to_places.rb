class AddCategoryToPlaces < ActiveRecord::Migration
  def change
    add_column :places, :category, :string
  end
end
