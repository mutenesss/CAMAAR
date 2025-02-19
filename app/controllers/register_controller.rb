# Controller responsável pelo processo de registro de novos usuários.
#
# Permite que o usuário se registre com a confirmação de e-mail via token.
class RegisterController < ApplicationController
  # Exibe o formulário de registro de usuário.
  #
  # Argumentos:
  #   Nenhum.
  #
  # Retorna:
  #   Exibe o formulário de registro de um novo usuário.
  def new
    @user = User.new
    @registration_token = RegistrationToken.new
  end

  # Processa a solicitação de registro, enviando um e-mail com o token de confirmação.
  #
  # Argumentos:
  #   Nenhum.
  #
  # Retorna:
  #   Envia o e-mail de confirmação ou exibe uma mensagem se o e-mail já estiver registrado.
  def create
    eMail = params[:registration_token][:email]
    user = User.find_by(Email: eMail)
    if user
      redirect_to register_path, notice: 'Email já cadastrado.'
    else
      token = SecureRandom.alphanumeric(20)
      @registration_token = RegistrationToken.new(email: eMail, token: token)
  
      if @registration_token.save
        UserMailer.registration_email(@registration_token.email, @registration_token.token).deliver_now
        redirect_to root_path, notice: 'Email de confirmação enviado. Verifique sua caixa de entrada.'
      end
    end
  end

  # Exibe o formulário de atualização de registro, validando o token.
  #
  # Argumentos:
  #   Nenhum.
  #
  # Retorna:
  #   Exibe o formulário para o usuário preencher as informações ou redireciona se o token for inválido.
  def edit
    @token = RegistrationToken.find_by(token: params[:token])

    if @token.nil?
      redirect_to root_path, alert: "Token inválido ou expirado."
    else
      @user = User.new(Email: @token.email) # Criando um usuário temporário para o form
    end
  end

  # Processa a atualização do registro do usuário, criando a conta após o preenchimento do formulário.
  #
  # Argumentos:
  #   Nenhum.
  #
  # Retorna:
  #   Cria o usuário no sistema e redireciona para a página de login após o sucesso, ou exibe erro.
  def update
    token = RegistrationToken.find_by(token: params[:token])

    if token.nil?
      redirect_to register_path, notice: "Token inválido ou expirado."
      return
    end

    nome = params[:registration_token][:nome]
    matricula = params[:registration_token][:matricula]
    role = params[:registration_token][:role]
    senha = params[:registration_token][:password]

    user = User.new(Nome: nome, Matricula: matricula, Role: role, Senha: senha)
    user.Email = token.email # Usa o e-mail associado ao token

    if user.save
      token.destroy # Remove o token após o uso
      redirect_to login_path, notice: "Cadastro realizado com sucesso! Faça login."
    end
  end
end
