class RegistrationToken < ApplicationRecord
    # Validações
    validates :email, presence: true, uniqueness: true
  
    # Callback para gerar o token
    before_create :generate_token
  
    private
  
    def generate_token
      self.token = SecureRandom.alphanumeric(20)
    end
  end