# Responsável pelo envio de e-mails relacionados à redefinição de senha e registro.
class UserMailer < ApplicationMailer
  include Rails.application.routes.url_helpers

  # Envia um e-mail de redefinição de senha com um link para o formulário de atualização.
  #
  # Argumentos:
  #   - user (User): Usuário que solicita a redefinição de senha.
  #   - token (String): Token gerado para a redefinição de senha.
  #
  # Retorna:
  #   - Envia um e-mail com o link para redefinir a senha.
  def password_reset(user, token)
    @user = user
    @token = token
    @url = edit_password_reset_url(token: @token)  # Gera o link para o e-mail
    mail to: @user.Email, subject: 'Redefinição de Senha'  # Envia o e-mail
  end

  # Envia um e-mail de solicitação de redefinição de senha.
  #
  # Argumentos:
  #   - user (User): Usuário que solicitou a redefinição de senha.
  #   - token (String): Token de redefinição de senha.
  #
  # Retorna:
  #   - Envia um e-mail com o link para redefinir a senha.
  def forgot_password(user, token)
    @user = user
    @token = token
    @url = edit_password_reset_url(token: @token)
    mail(to: @user.Email, subject: "Redefinição de Senha")
  end
  
  # Envia um e-mail de confirmação de registro com um token de validação.
  #
  # Argumentos:
  #   - email (String): E-mail do usuário para envio da confirmação.
  #   - token (String): Token de registro para o novo usuário.
  #
  # Retorna:
  #   - Envia um e-mail para confirmar o registro do usuário.
  def registration_email(email, token)
    @email = email
    @token = token
    mail(to: @email, subject: 'Confirme seu registro')
  end
end
