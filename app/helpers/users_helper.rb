module UsersHelper
	
	def choose_user_picture(user)

		if user.uploaded_files.last
			user.uploaded_files.last.file
		elsif user.picture
			user.picture
		else
			asset_url('default_user_picture.png')
		end					
	end	
end
