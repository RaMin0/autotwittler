class User < ActiveRecord::Base
  # Plugins
  devise :omniauthable, omniauth_providers: [:twitter]
  
  # Callbacks
  after_update :remote_update_profile, if: :changed?
  
  # Class Methods
  def self.from_omniauth(auth)
    find_or_initialize_by(twitter_uid: auth.uid).tap do |user|
      user.name                        = auth.info.name
      user.username                    = auth.info.nickname
      user.description                 = auth.info.description
      user.url                         = auth.extra.raw_info.url
      user.twitter_access_token        = auth.credentials.token
      user.twitter_access_token_secret = auth.credentials.secret
      
      user.save!
    end
  end
  
  # Methods
  def client_config
    @client_config ||= lambda do |config|
      config.consumer_key        = Figaro.env.twitter_consumer_key
      config.consumer_secret     = Figaro.env.twitter_consumer_secret
      config.access_token        = self.twitter_access_token
      config.access_token_secret = self.twitter_access_token_secret
    end
  end
  
  def client
    @client ||= Twitter::REST::Client.new(&client_config)
  end
  
  def streaming_client
    @streaming_client ||= Twitter::Streaming::Client.new(&client_config)
  end
  
  def me?(screen_name)
    self.username.downcase == screen_name.downcase
  end
  
  def remote_update_profile
    self.client.update_profile \
      name:        self.name,
      description: self.description,
      url:         self.url
  end
  
  def remote_timeline(max_id = nil)
    options = { count: 10 }
    options[:max_id] = max_id if max_id.present?
    
    self.client.home_timeline(options)
  end
  
  def remote_user_timeline(user_id, max_id = nil)
    options = { count: 10 }
    options[:max_id] = max_id if max_id.present?
    
    self.client.user_timeline(user_id, options)
  end
  
  def remote_recents(count = 5)
    sample_users = []
    streaming_client.sample do |s|
      case s
      when Twitter::Tweet
        sample_users << s.user
      end
    
      break if sample_users.size == count
    end
    sample_users
  end
  
  def remote_user(username = self.username)
    self.client.user(username)
  end
  
  def remote_status(status_id)
    self.client.status(status_id)
  end
  
  def remote_follow(username)
    self.client.follow(username).first
  end
  
  def remote_unfollow(username)
    self.client.unfollow(username).first
  end
  
  def remote_search(query, count = 5)
    self.client.user_search(query, count: count)
  end
  
  def remote_blocked?(user)
    self.client.block?(user)
  end
  
  def remote_block(user)
    self.client.block(user).first
  end
  
  def remote_unblock(user)
    self.client.unblock(user).first
  end
end
