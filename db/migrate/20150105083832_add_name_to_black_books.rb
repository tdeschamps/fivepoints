class AddNameToBlackBooks < ActiveRecord::Migration
  def change
    add_column :black_books, :name, :string
  end
end
