class Authorization < ActiveRecord::Base
	belongs_to :user
	#validates_presence_of :uid, :provider
  	#validates_uniqueness_of :uid, scope: :provider
end