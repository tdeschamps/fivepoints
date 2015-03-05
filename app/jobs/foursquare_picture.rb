class FoursquarePicture < ActiveJob::Base
  # Set the Queue as Default
  queue_as :default

  def perform(place_id, picture_url)
    place = Place.find(place_id)

    image = place.uploaded_files.new
    image.file_from_url picture_url
    image.save

  end

end