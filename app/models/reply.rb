class Reply < Status
  attribute :status_id, type: Integer
  
  def save
    tweet = self.user.client.update(self.text, in_reply_to_status_id: self.status_id)
    self.tweet_id = tweet.id
    true
  rescue Twitter::Error::Forbidden => e
    self.errors.add :base, e.message
    nil
  end
end
