class ForgotPasswordsController < ApplicationController
    def new
    end
  
    def create
      user = User.find_by(Email: params[:Email]) # Busca o usuário pelo e-mail
      if user
        token = user.password_reset_tokens.create
        UserMailer.forgot_password(user, token.token).deliver_now # Envia e-mail
        redirect_to root_path, notice: 'Instruções de redefinição de senha enviadas para o seu e-mail.'
      else
        flash.now[:alert] = 'E-mail não encontrado.'
        render :new
      end
    end
  
    def edit
      @token = PasswordResetToken.find_by(token: params[:token])
      if @token&.valid_token?
        @user = @token.user
      else
        redirect_to root_path, alert: 'Link inválido ou expirado.'
      end
    end
  
    def update
      @token = PasswordResetToken.find_by(token: params[:token])
  
      if @token&.valid_token?
        @user = @token.user
        if params[:password].blank? || params[:password_confirmation].blank?
          flash.now[:alert] = 'Senha não pode ficar em branco.'
          render :edit
        elsif params[:password] == params[:password_confirmation]
          @user.update(password: params[:password]) # Atualiza a senha corretamente
          @token.destroy # Remove o token usado
          redirect_to root_path, notice: 'Senha redefinida com sucesso.'
        else
          flash.now[:alert] = 'As senhas não coincidem.'
          render :edit
        end
      else
        redirect_to root_path, alert: 'Link inválido ou expirado.'
      end
    end
  end
  