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

    def password_set(user)
      @user = user
      @url = edit_password_url(@user.reset_password_token)
      mail(to: @user.email, subject: 'Defina sua nova senha')
    end
  end