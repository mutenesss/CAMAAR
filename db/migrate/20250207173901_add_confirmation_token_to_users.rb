# Adiciona o campo 'confirmation_token' à tabela 'users'.
#
# Esta migração adiciona um novo campo chamado `confirmation_token` à tabela
# `users` no banco de dados, utilizado para armazenar o token de confirmação
# de ações como verificação de e-mail ou redefinição de senha.
#
# O campo é do tipo `string` e será utilizado para gerar e armazenar um token
# único para cada usuário que necessite de confirmação em processos como
# registro ou alteração de informações.
#
class AddConfirmationTokenToUsers < ActiveRecord::Migration[8.0]
# Adiciona o campo 'confirmation_token' à tabela 'users'.
#
  def change
    add_column :users, :confirmation_token, :string
  end
end
