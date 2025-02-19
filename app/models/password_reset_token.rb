# Representa o token de redefinição de senha associado a um usuário.
class PasswordResetToken < ApplicationRecord
  # Associa o token de redefinição de senha a um usuário específico.
  belongs_to :user, foreign_key: "UserID"  # Associação com a tabela de usuários
  
  # Gera o token e define a expiração antes de salvar o registro.
  before_create :generate_token, :set_expiration

  # Verifica se o token ainda é válido com base na data de expiração.
  #
  # Retorna:
  #   - true se o token não expirou.
  #   - false se o token expirou.
  def valid_token?
    expires_at > Time.current
  end
  
  private
  
  # Gera um token único e seguro para redefinição de senha.
  def generate_token
    self.token = SecureRandom.urlsafe_base64
  end

  # Define a expiração do token para uma hora a partir de sua criação.
  def set_expiration
    self.expires_at = 1.hour.from_now
  end
end
