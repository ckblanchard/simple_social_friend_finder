class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
        :omniauthable, :omniauth_providers => [:twitter, :facebook, :google_oauth2]

has_many :friends


  def self.find_for_twitter_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first_or_initialize
    user.name = auth.info.name
    user.provider = auth.provider
    user.uid = auth.uid
    user.email = auth.uid+"@twitter.com"
    user.password = Devise.friendly_token[0,20]
    user.oauth_token = auth.credentials.token
    user.oauth_secret = auth.credentials.secret
    user.save!
    user.add_twitter_friends
    user
  end

  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first_or_initialize
    user.name = auth.info.name
    user.provider = auth.provider
    user.uid = auth.uid
    user.email = auth.info.email
    user.password = Devise.friendly_token[0,20]
    user.oauth_token = auth.credentials.token
    # user.oauth_secret = auth.credentials.secret
    user.save!
    user.add_facebook_friends
    user
  end

  def self.find_for_google_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first_or_initialize
    user.name = auth.info.name
    user.provider = auth.provider
    user.uid = auth.uid
    user.email = auth.info.email
    user.password = Devise.friendly_token[0,20]
    user.oauth_token = auth.credentials.token
    # user.oauth_secret = auth.credentials.refresh_token
    user.save!
    user
  end

  def twitter
    @twitter ||= Twitter::REST::Client.new(
      consumer_key: ENV["TWITTER_KEY"],
      consumer_secret: ENV["TWITTER_SECRET"],
      access_token: self.oauth_token,
      access_token_secret: self.oauth_secret
      )
  end

  def add_twitter_friends
    results = twitter.friends.to_a
    results.each do |friend|
      self.friends.where(
        name: friend.screen_name,
        uid: friend.id.to_s
        ).first_or_create
    end
  end

  def facebook
    @facebook ||= Koala::Facebook::API.new(self.oauth_token)
  end

  def add_facebook_friends
    facebook.get_connection("me", "friends").each do |friend|
      self.friends.where(
        name: friend["name"],
        uid: friend["id"]
        ).first_or_create
    end
  end

end
