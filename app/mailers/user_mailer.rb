class UserMailer < ApplicationMailer
    def password_reset(user, token)
      @user = user
      @token = token
      mail(to: @user.Email, subject: 'Redefinição de Senha') # Usa a coluna Email
    end

    def forgot_password(user, token)
      @user = user
      @url = edit_forgot_passwords_url(token: token)
      mail(to: @user.Email, subject: "Redefinição de Senha")
    end
    
    def registration_email(email, token)
      @email = email
      @token = token
      mail(to: @email, subject: 'Confirme seu registro')
    end
    
  end