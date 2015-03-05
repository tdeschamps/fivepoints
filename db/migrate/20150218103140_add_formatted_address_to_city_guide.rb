class AddFormattedAddressToCityGuide < ActiveRecord::Migration
  def change
  	add_column :city_guides, :formatted_address, :string
  end

end
