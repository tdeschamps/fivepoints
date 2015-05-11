class Followship < ActiveRecord::Base
	
	belongs_to :follower, class_name: "User"
	belongs_to :followed, class_name: "User"
	include PublicActivity::Model
	tracked	owner: Proc.new { |controller, model| model.follower },
			recipient: Proc.new { |controller, model| model.followed }
end