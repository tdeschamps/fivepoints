class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  extend FriendlyId
  validates :email, uniqueness: true
  validates :biography, length: {maximum: 160}
  has_many :active_followships, class_name:  "Followship",
                                foreign_key: "follower_id",
                                dependent:   :destroy                              
  has_many :passive_followships, class_name:  "Followship",
                                 foreign_key: "followed_id",
                                 dependent:   :destroy

  has_many :following, through: :active_followships, source: :followed
  has_many :followers, through: :passive_followships, source: :follower
  
  has_many :social_friendships
  has_many :friends, :through => :social_friendships
  has_many :inverse_social_friendships, :class_name => "SocialFriendship", :foreign_key => "friend_id"
  has_many :inverse_friends, :through => :inverse_social_friendships, :source => :user
  
  has_many :black_books
  has_many :uploaded_files, as: :imageable
  
  has_many :authorizations, dependent: :destroy
  has_many :uploaded_files, as: :imageable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  devise :omniauthable, :omniauth_providers => [ :facebook, :twitter, :linkedin ]
  friendly_id :username, use: :slugged
  
  after_create :you_should_follow_fivemarks
  after_create :you_should_have_a_username, unless: :username?
  after_create :send_welcome_email

  acts_as_voter
  
  def self.find_for_facebook_oauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]  # Fake password for validation
      user.first_name = auth.info.name.split[0]
      user.last_name = auth.info.name.split.drop(1).join(' ')
      user.username = auth.info.name.gsub(" ", "_").downcase
      user.name = auth.info.name
      user.picture = process_uri(auth.info.image + '?width=500&height=500')
      user.token = auth.credentials.token
      user.token_expiry = Time.at(auth.credentials.expires_at)
    end
  end

  def self.process_uri(uri)
    avatar_url = URI.parse uri
    avatar_url.scheme = 'https'
    avatar_url.to_s
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

  def self.find_for_oauth(provider, access_token, resource=nil)
    user, email, name, uid, auth_attr = nil, nil, nil, {}

    case provider
      when "Facebook"
        uid = access_token['uid']
        email = access_token['info']['email']
        auth_attr = { uid: uid, 
                      token: access_token['credentials']['token'],
                      secret: nil, 
                      first_name: access_token['info']['name'].split[0],
                      last_name: access_token['info']['name'].split.drop(1).join(' '), 
                      name: access_token['info']['name'],
                      link: access_token['extra']['raw_info']['link'],
                      token_expiry: Time.at(access_token['credentials']['expires_at']),
                      picture: process_uri(access_token.info.image + '?width=500&height=500') }  
      
      when "Twitter"
        uid = access_token['extra']['raw_info']['id']
        name = access_token['extra']['raw_info']['name']
        auth_attr = { uid: uid, 
                      token: access_token['credentials']['token'],
                      secret: access_token['credentials']['secret'], 
                      first_name: access_token['info']['first_name'],
                      last_name: access_token['info']['last_name'], 
                      name: name,
                      picture: access_token['info']['image'],
                      link: "http://twitter.com/#{name}" }
    
      when 'LinkedIn'
        uid = access_token['uid']
        name = access_token['info']['name']
        auth_attr = { uid:  uid, 
                      token: access_token['credentials']['token'],
                      secret: access_token['credentials']['secret'], 
                      first_name: access_token['info']['first_name'],
                      last_name: access_token['info']['last_name'],
                      link: access_token['info']['public_profile_url'] 
                    }
    
    else
      raise 'Provider #{provider} not handled'
    end
    
    if resource.nil?
      if email
        user = find_for_oauth_by_email(email, access_token, resource)
      elsif uid && name
        user = find_for_oauth_by_uid(uid, resource)
        if user.nil?
          user = find_for_oauth_by_name(name, resource)
        end
      end
    else
      user = resource
    end

    auth = user.authorizations.find_by_provider(provider)
    if auth.nil?
      auth = user.authorizations.build(provider: provider)
      user.authorizations << auth
    end
    auth.update_attributes auth_attr
    user.update_attributes ({
      first_name: auth_attr[:first_name],
      last_name: auth_attr[:last_name],
      picture: auth_attr[:picture]
      })
    return user
  end

  def self.find_for_oauth_by_uid(uid, resource=nil)
    user = nil
    if auth = Authorization.find_by_uid(uid.to_s)
      user = auth.user
    end
    return user
  end

  def self.find_for_oauth_by_email(email, access_token, resource=nil)
    if user = User.find_by_email(email)
      user.update_attributes({picture: process_uri(access_token.info.image + '?width=500&height=500')} )
    else
      user = User.new(
        email: email, 
        password: Devise.friendly_token[0,20],
        first_name: access_token['info']['name'].split[0],
        last_name: access_token['info']['name'].split.drop(1).join(' '), 
        name: access_token['info']['name'],
        username: access_token['info']['name'].gsub(" ", "_").downcase,
        picture: process_uri(access_token['info']['image'] + '?width=500&height=500')
        )
      user.save
    end
    return user
  end

  def self.find_for_oauth_by_name(name, resource=nil)
    if user = User.find_by_name(name)
    else
      first_name = name
      last_name = name
      user = User.new(:first_name => first_name, :last_name => last_name, :password => Devise.friendly_token[0,20], :email => "#{UUIDTools::UUID.random_create}@host")
      user.save(:validate => false)
    end
    return user
  end

  # Follows a user.
  def follow(other_user)
    active_followships.create(followed_id: other_user.id)
  end

  # Unfollows a user.
  def unfollow(other_user)
    Followship.public_activity_off do
      active_followships.find_by(followed_id: other_user.id).destroy
    end
    Followship.public_activity_on  
  end

  # Returns true if the current user is following the other user.
  def following?(other_user)
    following.include?(other_user)
  end

  def you_should_follow_fivemarks
    self.active_followships.create(followed_id: 1)
  end

  def you_should_have_a_username
    if fb_profile = self.authorizations.find_by_provider('Facebook')
      self.update!({username: fb_profile.name.gsub(" ", "_").downcase,
                    picture: fb_profile.picture
                  })
    else
      self.update!({username: "#{Faker::Internet.user_name(nil,%w(_))}_#{rand(1..10)*self.id}"})
    end
  end

  private

  def send_welcome_email
    UserMailer.welcome(self).deliver_later
  end
         
end
