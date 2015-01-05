class CreateUploadedFiles < ActiveRecord::Migration
  def change
    create_table :uploaded_files do |t|
      t.references :imageable, polymorphic: true, index: true
      t.timestamps
    end
  end
end
