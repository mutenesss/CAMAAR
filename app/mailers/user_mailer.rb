class UserMailer < ApplicationMailer
    def password_reset(user, token)
      @user = user
      @token = token
      mail(to: @user.Email, subject: 'Redefinição de Senha') # Usa a coluna Email
    end
  end