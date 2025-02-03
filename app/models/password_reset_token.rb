class PasswordResetToken < ApplicationRecord
    belongs_to :user, foreign_key: "UserID" # Associação com User
  
    before_create :generate_token, :set_expiration
  
    def valid_token?
      expires_at > Time.current
    end
  
    private
  
    def generate_token
      self.token = SecureRandom.urlsafe_base64
    end
  
    def set_expiration
      self.expires_at = 1.hour.from_now
    end
  end