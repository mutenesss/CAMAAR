class RegisterController < ApplicationController
  def new
    @user = User.new
    @registration_token = RegistrationToken.new
  end

  def create
    eMail = params[:registration_token][:email] 
    user = User.find_by(Email: eMail)  
    if user
      redirect_to register_path, notice: 'Email já cadastrado.'
    else
      token = SecureRandom.alphanumeric(20)
      @registration_token = RegistrationToken.new(email:eMail, token: token)
  
      if @registration_token.save
        UserMailer.registration_email(@registration_token.email, @registration_token.token).deliver_now
        redirect_to root_path, notice: 'Email de confirmação enviado. Verifique sua caixa de entrada.'
      else
        redirect_to root_path, notice: 'Erro ao salvar token de registro.'
      end
    end
  end

  def edit
    @token = RegistrationToken.find_by(token: params[:token])

    if @token.nil?
      redirect_to root_path, alert: "Token inválido ou expirado."
    else
      @user = User.new(Email: @token.email) # Criando um usuário temporário para o form
    end
  end

  def update
    token = RegistrationToken.find_by(token: params[:token])

    if token.nil?
      redirect_to register_path, alert: "Token inválido ou expirado."
      return
    end
    nome = params[:registration_token][:nome]
    matricula = params[:registration_token][:matricula]
    role = params[:registration_token][:role]
    senha = params[:registration_token][:password]

    user = User.new(Nome:nome,Matricula:matricula,Role:role,Senha:senha)
    user.Email = token.email # Usa o e-mail associado ao token
    if user.save
      token.destroy # Remove o token após o uso
      redirect_to login_path, notice: "Cadastro realizado com sucesso! Faça login."
    else
      flash.now[:alert] = "Erro ao criar a conta. Verifique os dados."
      render :edit, status: :unprocessable_entity
    end
  end


  private

  def user_params
    params.require(:user).permit(:name, :matricula, :password, :password_confirmation, :role)
  end
end