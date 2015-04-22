class AddIndexToBlackBooks < ActiveRecord::Migration
  def change
  	add_index :black_books, :user_id
  end
end
