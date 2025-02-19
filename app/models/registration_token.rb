# Modelo responsável pelos tokens de registro de usuários.
class RegistrationToken < ApplicationRecord
  # Validações
  validates :email, presence: true, uniqueness: true
  validates :token, presence: true, uniqueness: true

  # Gera um token único antes da criação do registro
  before_create :generate_token

  private

  # Método que gera um token aleatório de 20 caracteres
  def generate_token
    self.token = SecureRandom.alphanumeric(20)
  end
end
