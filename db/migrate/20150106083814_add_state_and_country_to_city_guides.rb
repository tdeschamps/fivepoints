class AddStateAndCountryToCityGuides < ActiveRecord::Migration
  def change
    add_column :city_guides, :state, :string
    add_column :city_guides, :country, :string
  end
end
