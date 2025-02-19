# Criação da tabela 'password_reset_tokens'.
#
# Esta migração cria a tabela `password_reset_tokens` no banco de dados,
# que armazena tokens de redefinição de senha para os usuários.
# A tabela inclui o ID do usuário (UserID), o token gerado para o processo
# de redefinição de senha e a data de expiração do token.
#
class CreatePasswordResetTokens < ActiveRecord::Migration[8.0]
# Criação da tabela `password_reset_tokens`
# Estrutura da tabela:
# - `UserID` (integer) - Referência ao usuário ao qual o token pertence.
# - `token` (string) - O token gerado para a redefinição de senha.
# - `expires_at` (datetime) - Data e hora em que o token expira.
# - `timestamps` - Campos automáticos `created_at` e `updated_at` para rastrear a criação e atualização do registro.
#
def change
  create_table :password_reset_tokens do |t|
    t.integer :UserID
    t.string :token
    t.datetime :expires_at

    t.timestamps
  end
end
  end
end
