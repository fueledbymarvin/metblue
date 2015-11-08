class User
  include Mongoid::Document
  field :provider, type: String
  field :uid, type: String
  field :name, type: String
  field :oauth_token, type: String
  field :oauth_expires_at, type: Time

  embeds_one :search
  has_and_belongs_to_many :favorites, inverse_of: nil, class_name: "Package"
  
  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      if user.search.nil?
        user.search = Search.new
        user.search.rank
      end
      user.save!
    end
  end

  def facebook
    @facebook ||= Koala::Facebook::API.new(oauth_token)
  end

  def facebook_updates
    @facebook_updates ||= Koala::Facebook::RealtimeUpdates.new(app_id: ENV["FACEBOOK_KEY"], secret: ENV["FACEBOOK_SECRET"])
  end
end
