class SiginController < ApplicationController
    def new
    end
  
    def create
      user = User.find_by(email: params[:email])
      
      if user
        user.reset_password_token = SecureRandom.hex(10) # Gera um token aleatório
        user.save
  
        # Enviar e-mail com o link
        UserMailer.password_reset(user).deliver_now
        redirect_to root_path, notice: 'Um e-mail foi enviado com instruções para redefinir sua senha.'
      else
        flash[:alert] = 'E-mail não encontrado.'
        render :new
      end
    end
  end