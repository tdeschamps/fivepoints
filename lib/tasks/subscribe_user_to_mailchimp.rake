namespace :subscribe_users_to_fivemarks do
	desc 'subscribe user to fivemarks list'
	
	task subscribe: :environment do
		User.find_each do |user|
			orang_houtan = AddUserToMailchimp.new user
    	orang_houtan.subscribe_to_fivemarks_list
    end
  end
  
end
