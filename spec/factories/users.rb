FactoryBot.define do
  factory :user do
    Email { 'tester@tester.com' }
    Senha { '123456' }
    Matricula { '123456' }  # Adicione um valor válido
    Nome { 'teste' } # Adicione um nome válido
    Role { 'admin' } # Defina um valor adequado para o papel do usuário
  end
end
