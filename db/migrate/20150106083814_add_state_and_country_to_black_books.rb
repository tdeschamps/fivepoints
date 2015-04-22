class AddStateAndCountryToBlackBooks < ActiveRecord::Migration
  def change
    add_column :black_books, :state, :string
    add_column :black_books, :country, :string
  end
end
