module UsersHelper
	
	def choose_user_picture(user)

		if user.uploaded_files.last
			user.uploaded_files.last.file
		elsif user.image
			user.image
		else
			'default_user_picture.png'
		end					
	end	
end
