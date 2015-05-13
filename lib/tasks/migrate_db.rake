namespace :migrate_db do

  desc "move user infos"
  task move_user_to_authorizations: :environment do
  	User.where(provider: 'facebook') do |user|
  		user.authorizations.first_or_create ({
  			uid: user.uid,
  			name: user.name,
  			first_name: user.first_name,
  			last_name: user.last_name,
  			picture: user.picture,
  			token: user.token,
  			token_expiry: user.token_expiry,
  			provider: user.provider	
  			})
  	end
  end

  desc "remove user infos from user table"
  task remove_informations_associated_to_social_media: :environment do
  
  	if users = User.find_by_provider('facebook').count > 1
      users.each do |user|
        user.update_attributes({
          uid: nil,
          name: nil,
          first_name: nil,
          last_name: nil,
          picture: nil,
          token: nil,
          token_expiry: nil,
          provider: nil
        })
        user.save
      end  
    else  
      users.update_attributes({
  		  uid: nil,
  		  name: nil,
  		  first_name: nil,
  		  last_name: nil,
  		  picture: nil,
  		  token: nil,
  		  token_expiry: nil,
  		  provider: nil
      })
      user.save
    end  
  end
end
