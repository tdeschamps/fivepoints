class AddIndexToCityGuides < ActiveRecord::Migration
  def change
  	add_index :city_guides, :user_id
  end
end
