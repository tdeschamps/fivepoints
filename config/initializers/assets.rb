# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
Rails.application.config.assets.precompile += %w( city_guides/autocomplete.js )
Rails.application.config.assets.precompile += %w( city_guides/city_guide_places.js )
Rails.application.config.assets.precompile += %w( city_guides/sortable_list.js )
Rails.application.config.assets.precompile += %w( city_guides/foursquare.js )
Rails.application.config.assets.precompile += %w( city_guides/foursquare_autocomplete.js )
Rails.application.config.assets.precompile += %w( home.js )
Rails.application.config.assets.precompile += %w( scrollReveal.js )
Rails.application.config.assets.precompile += %w( city_guides/map.js )