class BlackBookPlace < ActiveRecord::Base

	belongs_to :black_book
	belongs_to :place
	has_many :uploaded_files, as: :imageable

	scope :active_places , -> { where(position: [1..5]).order('position ASC') }
	scope :archived_places , -> { where(position: nil) }

	acts_as_list scope: :black_book
	after_create :set_score
	before_update :update_score, if: :position_changed? 
	

	accepts_nested_attributes_for :uploaded_files, :allow_destroy => true
	include PublicActivity::Common
	
	def update_score
		self.place.update_score(position_was, position)
	end

	def set_score
		self.place.update_score(nil, position)
	end
end
