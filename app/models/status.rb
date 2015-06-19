class Status
  include ActiveAttr::Model
  
  attribute :tweet_id, type: Integer
  attribute :user, type: Object
  attribute :text
  
  def save
    tweet = self.user.client.update!(self.text)
    self.tweet_id = tweet.id
    true
  rescue Twitter::Error::Forbidden => e
    self.errors.add :base, e.message
    nil
  end
end
