# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
Rails.application.config.assets.precompile += %w( black_books/autocomplete.js )
Rails.application.config.assets.precompile += %w( black_books/black_book_places.js )
Rails.application.config.assets.precompile += %w( black_books/sortable_list.js )
Rails.application.config.assets.precompile += %w( black_books/foursquare.js )
Rails.application.config.assets.precompile += %w( black_books/foursquare_autocomplete.js )
Rails.application.config.assets.precompile += %w( classie.js )
Rails.application.config.assets.precompile += %w( scrollReveal.js )
Rails.application.config.assets.precompile += %w( black_books/map.js )
Rails.application.config.assets.precompile += %w( black_books/newUpload.js )
Rails.application.config.assets.precompile += %w( users/user_edit.js )
Rails.application.config.assets.precompile += %w( black_books/paginationBlackBooks.js )
Rails.application.config.assets.precompile += %w( users/disconnected.js )
Rails.application.config.assets.precompile += %w( black_books/modal.js )