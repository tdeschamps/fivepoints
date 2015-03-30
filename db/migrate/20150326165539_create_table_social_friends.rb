class CreateTableSocialFriends < ActiveRecord::Migration
  def change
    create_table :social_friendships do |t|
      t.integer :user_id
      t.integer :friend_id
    end
  end
end
