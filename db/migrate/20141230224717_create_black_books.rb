class CreateBlackBooks < ActiveRecord::Migration
  def change
    create_table :black_books do |t|
    	t.string :city
    	t.references :user
    	t.text :story
        t.timestamps
    end
  end
end
