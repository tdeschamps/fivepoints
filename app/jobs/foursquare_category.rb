class FoursquareCategory < ActiveJob::Base
  # Set the Queue as Default
  queue_as :default

  def perform(place_id, category)
    place = Place.find(place_id)
    category = Category.create_with(short_name: category["shortName"], plural_name: category["pluralName"]).find_or_create_by(name: category["name"])
    logger.info "Things are happening."
    logger.debug "Here's some info: #{hash.inspect}"
    
    place.categories << category

  end

end