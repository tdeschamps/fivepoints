class BlackBookPlace < ActiveRecord::Base

	belongs_to :black_book
	belongs_to :place
	has_many :uploaded_files, as: :imageable

	scope :active_places , -> { where(position: [1..5]).order('position ASC') }
	scope :archived_places , -> { where(position: nil) }

	acts_as_list scope: :black_book
	
	

	accepts_nested_attributes_for :uploaded_files, :allow_destroy => true
	
end
