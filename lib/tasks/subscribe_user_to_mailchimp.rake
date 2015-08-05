namespace :create_slug_history do
	desc 'subscribe user to fivemarks list'
	task 'subscribe' do
		User.find_each do |user|
			orang_houtan = AddUserToMailchimp.new user
    	orang_houtan.subscribe_to_fivemarks_list
    end
  end
end
