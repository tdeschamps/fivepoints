class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :active_followships, class_name:  "Followship",
                                  foreign_key: "follower_id",
                                  dependent:   :destroy                              
  has_many :passive_followships, class_name:  "Followship",
                                   foreign_key: "followed_id",
                                   dependent:   :destroy

  has_many :following, through: :active_followships, source: :followed
  has_many :followers, through: :passive_followships, source: :follower
  
  has_many :city_guides
  has_many :uploaded_files, as: :imageable
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, :omniauth_providers => [ :facebook, :twitter, :linkedin ]

  def self.find_for_facebook_oauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]  # Fake password for validation
      user.first_name = auth.info.name.split[0]
      user.last_name = auth.info.name.split.drop(0).join(' ')
      user.username = auth.info.name
      user.picture = auth.info.image + '?width=500&height=500'
      user.token = auth.credentials.token
      user.token_expiry = Time.at(auth.credentials.expires_at)
    end
  end
  
  #allow to connect twitter/linkedin
  def has_connection_with(provider)
    auth = self.authorizations.where(provider: provider).first
    if auth.present?
      auth.token.present?
    else
      false
    end
  end

  # Follows a user.
  def follow(other_user)
    active_followships.create(followed_id: other_user.id)
  end

  # Unfollows a user.
  def unfollow(other_user)
    active_followships.find_by(followed_id: other_user.id).destroy
  end

  # Returns true if the current user is following the other user.
  def following?(other_user)
    following.include?(other_user)
  end      
end
