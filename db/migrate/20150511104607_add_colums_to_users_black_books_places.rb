class AddColumsToUsersBlackBooksPlaces < ActiveRecord::Migration
  def change
  	add_column :users, :slug, :string
	add_index :users, :slug
	add_column :black_books, :slug, :string
	add_index :black_books, :slug
	add_column :places, :slug, :string
	add_index :places, :slug
  end
end
