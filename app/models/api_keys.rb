class APIKeys < ActiveRecord::Base
  before_save :set_expiration
  before_save :generate_access_token
  belongs_to :user

  def expired?
    DateTime.now >= expires_at
  end

  private
  def generate_access_token
    begin
      self.access_token = SecureRandom.hex
    end while self.class.exists?(access_token: access_token)
  end

  def set_expiration
    self.expires_at = DateTime.now + 1.day
  end
end
