class ChangeBlackBookTableToBlackBookTable < ActiveRecord::Migration
  def self.up
      rename_table :black_books, :black_books
      rename_table :black_book_places, :black_book_places
    end 

    def self.down
      rename_table :black_books, :black_books
      rename_table  :black_book_places, :black_book_places
    end
end
