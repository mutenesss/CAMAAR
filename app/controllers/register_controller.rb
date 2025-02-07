class RegisterController < ApplicationController
  def new
    @registration_token = RegistrationToken.new
  end

  def create
    user = User.find_by(Email: params[:registration_token][:email])
    if user.nil?
      @registration_token = RegistrationToken.new(email: params[:registration_token][:email])

      if @registration_token.save
        UserMailer.registration_email(@registration_token.email, @registration_token.token).deliver_now
        redirect_to root_path, notice: 'Email de confirmação enviado. Verifique sua caixa de entrada.'
      else
        flash.now[:alert] = 'Erro ao salvar token de registro.'
        render :new
      end
    else
      flash.now[:alert] = 'Email já cadastrado.'
      @registration_token = RegistrationToken.new(email: params[:registration_token][:email]) # Define @registration_token para o formulário
      render :new
    end
  end

  def edit
    @token = params[:token]
  end

  def update
    @user = User.find_by(confirmation_token: params[:token])
    if @user
      if @user.update(user_params)
        @user.update(confirmation_token: nil) # Limpa o token após a confirmação
        redirect_to login_path, notice: 'Cadastro concluído com sucesso!'
      else
        flash.now[:alert] = 'Erro ao salvar. Verifique os dados.'
        render :edit
      end
    else
      redirect_to root_path, alert: 'Link inválido ou expirado.'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :matricula, :password, :password_confirmation, :role)
  end
