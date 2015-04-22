class CreateBlackBookPlaces < ActiveRecord::Migration
  def change
    create_table :black_book_places do |t|
    	t.references :black_book
    	t.references :place
    	t.integer :rank
      t.timestamps
    end
  end
end
