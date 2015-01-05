class AddAttachmentFileToUploadedFiles < ActiveRecord::Migration
  def self.up
    change_table :uploaded_files do |t|
      t.attachment :file
    end
  end

  def self.down
    remove_attachment :uploaded_files, :file
  end
end