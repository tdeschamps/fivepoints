class AddToMailchimp < ActiveJob::Base
  # Set the Queue as Default
  queue_as :default

  def perform(user_id)
    user = User.find(user_id)

    orang_houtan = AddUserToMailchimp.new user
    orang_houtan.subscribe_to_fivemarks_list
    p "i'm done"
  end

end