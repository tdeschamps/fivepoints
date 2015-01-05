class UploadedFile < ActiveRecord::Base
	belongs_to :imageable, polymorphic: true

	has_attached_file :profile_picture,
    styles: { large: "500x500>", medium: "300x300>", thumb: "100x100>" }

  	validates_attachment_content_type :profile_picture,
    content_type: /\Aimage\/.*\z/

end
