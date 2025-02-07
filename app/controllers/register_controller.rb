class RegisterController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.find_by(Email: params[:email])
    if user.nil?
      @user = User.new(Email: params[:email])
      if @user.save
        UserMailer.registration_email(@user.Email, @user.confirmation_token).deliver_now
        redirect_to root_path, notice: 'Email de confirmação enviado. Verifique sua caixa de entrada.'
      else
        flash.now[:alert] = 'Erro ao salvar usuário.'
        render :new
      end
    else
      flash.now[:alert] = 'Email já cadastrado.'
      render :new
    end
  end

  def edit
    @user = User.find_by(confirmation_token: params[:token])
    if @user
      render :edit
    else
      redirect_to root_path, alert: 'Link inválido ou expirado.'
    end
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
end