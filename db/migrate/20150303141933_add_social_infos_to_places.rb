class AddSocialInfosToPlaces < ActiveRecord::Migration
  def change
  	add_column :places, :twitter, :string
  	add_column :places, :facebook, :string
  	add_column :places, :facebook_username, :string
  	add_column :places, :facebook_name, :string
  	add_column :places, :phone, :string
  	add_column :places, :formatted_phone, :string
  end
end
