class User < ApplicationRecord
    self.primary_key = "UserID" # Define a chave primária personalizada

    # Validações
    validates :Matricula, presence: true, uniqueness: true
    validates :Email, presence: true, uniqueness: true
    validates :Nome, presence: true
    validates :Role, presence: true
    validates :Senha, presence: true

    # Associação com PasswordResetToken
    has_many :password_reset_tokens, foreign_key: "UserID", dependent: :destroy
end
