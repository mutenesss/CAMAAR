# Modelo `User` representa um usuário do sistema.
#
# Atributos:
# - `UserID` (chave primária personalizada)
# - `Matricula` (obrigatório e único)
# - `Email` (obrigatório e único)
# - `Nome` (obrigatório)
# - `Role` (obrigatório)
# - `Senha` (obrigatório)
# - `confirmation_token` (único, pode ser nulo)
#
# Associações:
# - Possui vários `PasswordResetTokens`.
#
# Validações:
# - `Matricula`, `Email`, `Nome`, `Role` e `Senha` são obrigatórios.
# - `Matricula` e `Email` devem ser únicos.
# - `confirmation_token` deve ser único, se presente.
#
# Métodos:
# - `generate_confirmation_token` - Gera e salva um token de confirmação.
# - `clear_confirmation_token` - Remove o token de confirmação.
#
class User < ApplicationRecord
  self.primary_key = "UserID" # Define a chave primária personalizada

  # Validações
  validates :Matricula, presence: true, uniqueness: true
  validates :Email, presence: true, uniqueness: true
  validates :Nome, presence: true
  validates :Role, presence: true
  validates :Senha, presence: true
  validates :confirmation_token, uniqueness: true, allow_nil: true

  # Associação com PasswordResetToken
  has_many :password_reset_tokens, foreign_key: "UserID", dependent: :destroy

  # Gera um token de confirmação e salva no banco de dados
  def generate_confirmation_token
    self.confirmation_token = SecureRandom.urlsafe_base64.to_s
    save
  end

  # Limpa o token após a confirmação
  def clear_confirmation_token
    self.confirmation_token = nil
    save
  end
end
