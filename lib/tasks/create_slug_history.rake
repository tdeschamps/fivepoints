namespace :create_slug_history do 
	
	desc 'reset black books slug and create history'
	task reset_black_books_slug: :environment do
		BlackBook.public_activity_off
		BlackBook.find_each do |black_book|
			black_book.slug = nil
			black_book.save!
		end
		BlackBook.public_activity_on
	end

	desc 'reset users slug and create history'
	task reset_users_slug: :environment do
		User.find_each do |user|
			user.slug = nil
			user.save!
		end
	end

	desc 'reset places slug and create history'
	task reset_places_slug: :environment do
		Place.find_each do |place|
			place.slug = nil
			place.save!
		end
	end
end