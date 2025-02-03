class PasswordResetsController < ApplicationController
    def new
    end
  
    def create
      user = User.find_by(Email: params[:email]) # Busca pelo email
      if user
        token = user.password_reset_tokens.create
        UserMailer.password_reset(user, token).deliver_now
        redirect_to root_path, notice: 'Email de redefinição de senha enviado.'
      else
        flash.now[:alert] = 'Email não encontrado.'
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
        if params[:password] == params[:password_confirmation]
          @user.update(Senha: params[:password]) # Atualiza a coluna Senha
          @token.destroy
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