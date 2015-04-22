class AddFormattedAddressToBlackBook < ActiveRecord::Migration
  def change
  	add_column :black_books, :formatted_address, :string
  end

end
