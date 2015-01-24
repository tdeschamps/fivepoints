class CreateAuthentifications < ActiveRecord::Migration
  def change
    create_table :authentifications do |t|

      t.timestamps null: false
    end
  end
end
