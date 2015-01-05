class AddNameToCityGuides < ActiveRecord::Migration
  def change
    add_column :city_guides, :name, :string
  end
end
