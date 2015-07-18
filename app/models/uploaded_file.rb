class UploadedFile < ActiveRecord::Base
	belongs_to :imageable, polymorphic: true

	has_attached_file :file,
    styles: { xlarge: "1000x", large: "500x500>", medium: "300x300>", thumb: "100x100>" }

  	validates_attachment_content_type :file,
    content_type: /\Aimage\/.*\z/

    validates :file_file_name, uniqueness: {scope: [:imageable_id, :imageable_type]}
    
    def file_from_url(url)
  		self.file = URI.parse(url)
	end
end
