class AddUserToMailchimp

	def initialize(user)
		@user = user
	end

	def subscribe_to_fivemarks_test_list
		gibbon = Gibbon::Request.new(api_key: ENV['MAILCHIMP_API_KEY'])
		gibbon.lists('8e1f2cbc7d').members.create(body: {email_address: "#{@user.email}", status: "subscribed", merge_fields: {FNAME: "#{@user.first_name}", LNAME: "#{@user.last_name}"}})
	end

	def subscribe_to_fivemarks_list
		gibbon = Gibbon::Request.new(api_key: ENV['MAILCHIMP_API_KEY'])
		gibbon.lists('2a8fd4ac2b').members.create(body: {email_address: "#{@user.email}", status: "subscribed", merge_fields: {FNAME: "#{@user.first_name}", LNAME: "#{@user.last_name}"}})
	end
end
