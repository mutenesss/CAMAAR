# Factory para criar usuários no banco de dados durante os testes.
#
# A factory define os atributos padrão que serão usados na criação de um
# objeto `User` para os testes, usando o FactoryBot.
FactoryBot.define do
  factory :user do
    # Define o e-mail do usuário
    Email { 'tester@tester.com' }
    
    # Define a senha do usuário
    Senha { '123456' }
    
    # Define a matrícula do usuário (valor válido)
    Matricula { '123456' }  
    
    # Define o nome do usuário (valor válido)
    Nome { 'teste' }
    
    # Define o papel do usuário (valor adequado, como 'admin')
    Role { 'admin' }
  end
end
