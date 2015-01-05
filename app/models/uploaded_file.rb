class UploadedFile < ActiveRecord::Base
	belongs_to :imageable, polymorphic: true

	has_attached_file :file,
    styles: { large: "500x500>", medium: "300x300>", thumb: "100x100>" }

  	validates_attachment_content_type :file,
    content_type: /\Aimage\/.*\z/

end
