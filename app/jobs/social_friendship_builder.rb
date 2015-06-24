class SocialFriendshipBuilder < ActiveJob::Base
  queue_as :default

  def perform(user_id, friends, provider)
    user = User.find(user_id)

    friends.each do |friend_id|
    	if new_friend = User.joins(:authorizations).where(authorizations: {provider: provider}).where(authorizations: {uid: friend_id}).first 
    		user.social_friendships.find_or_create_by(friend_id: new_friend.id)
    	end
    end


  end
end