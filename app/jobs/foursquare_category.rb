class FoursquareCategory < ActiveJob::Base
  # Set the Queue as Default
  queue_as :default

  def perform(place_id, category)
    place = Place.find(place_id)
    category = Category.create_with(short_name: category["shortName"], plural_name: category["pluralName"]).find_or_create_by(name: category["name"]) 
    place.categories << category

  end

end