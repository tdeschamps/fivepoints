class AddPriceToPlace < ActiveRecord::Migration
  def change
    add_column :places, :price, :integer
    add_column :places, :price_description, :string
  end
end
