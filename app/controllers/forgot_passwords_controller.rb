# Controller responsável pela redefinição de senha.
#
# Permite que os usuários solicitem e realizem a redefinição de senha.
class ForgotPasswordsController < ApplicationController
  # Exibe o formulário para solicitar a redefinição de senha.
  #
  # Argumentos:
  #   Nenhum.
  #
  # Retorna:
  #   Exibe o formulário.
  def new
  end

  # Processa a solicitação de redefinição de senha.
  #
  # Argumentos:
  #   Nenhum.
  #
  # Retorna:
  #   Redireciona para a página inicial com uma mensagem de sucesso ou erro.
  #
  # Efeitos Colaterais:
  #   Envia um e-mail com as instruções de redefinição de senha.
  def create
    user = User.find_by(Email: params[:Email])
    if user
      token = user.password_reset_tokens.create
      UserMailer.forgot_password(user, token.token).deliver_now
      redirect_to root_path, notice: 'Instruções de redefinição de senha enviadas para o seu e-mail.'
    else
      flash.now[:alert] = 'E-mail não encontrado.'
      render :new
    end
  end

  # Exibe o formulário para redefinir a senha com base no token.
  #
  # Argumentos:
  #   Nenhum.
  #
  # Retorna:
  #   Exibe o formulário para redefinir a senha.
  def edit
    return unless find_token
  end

  # Processa a atualização da senha.
  #
  # Argumentos:
  #   Nenhum.
  #
  # Retorna:
  #   Redireciona para a página inicial com uma mensagem de sucesso ou erro.
  #
  # Efeitos Colaterais:
  #   Atualiza a senha do usuário no banco de dados.
  def update
    return unless valid_token?

    if password_fields_blank?
      handle_blank_password
    elsif passwords_match?
      update_password(params[:password])
    else
      handle_password_mismatch
    end
  end

  private

  # Verifica se o token é válido.
  #
  # Argumentos:
  #   Nenhum.
  #
  # Retorna:
  #   Booleano indicando se o token é válido.
  def valid_token?
    find_token
  end

  # Verifica se os campos de senha estão em branco.
  #
  # Argumentos:
  #   Nenhum.
  #
  # Retorna:
  #   Booleano indicando se algum campo de senha está em branco.
  def password_fields_blank?
    params[:password].blank? || params[:password_confirmation].blank?
  end

  # Verifica se as senhas coincidem.
  #
  # Argumentos:
  #   Nenhum.
  #
  # Retorna:
  #   Booleano indicando se as senhas coincidem.
  def passwords_match?
    params[:password] == params[:password_confirmation]
  end

  private

  # Encontra o token de redefinição de senha e define o usuário associado.
  #
  # Argumentos:
  #   Nenhum.
  #
  # Retorna:
  #   Booleano indicando se o token é válido e define o usuário.
  #
  # Efeitos Colaterais:
  #   Redireciona para a página inicial se o token for inválido.
  def find_token
    @token = PasswordResetToken.find_by(token: params[:token])
    unless @token&.valid_token?
      redirect_to root_path, alert: 'Link inválido ou expirado.'
      return false
    end
    @user = @token.user
    true
  end

  # Lida com o caso em que a senha ou a confirmação de senha estão em branco.
  #
  # Argumentos:
  #   Nenhum.
  #
  # Retorna:
  #   Exibe o formulário novamente com um alerta.
  def handle_blank_password
    flash.now[:alert] = 'Senha não pode ficar em branco.'
    render :edit
  end

  # Atualiza a senha do usuário e destrói o token usado.
  #
  # Argumentos:
  #   password (String): Nova senha.
  #
  # Retorna:
  #   Redireciona para a página inicial com uma mensagem de sucesso ou erro.
  #
  # Efeitos Colaterais:
  #   Atualiza a senha do usuário no banco de dados e destrói o token de redefinição.
  def update_password(password)
    if @user.update(password: password)
      @token.destroy
      redirect_to root_path, notice: 'Senha redefinida com sucesso.'
    else
      flash.now[:alert] = 'Erro ao atualizar a senha.'
      render :edit
    end
  end

  # Lida com o caso em que as senhas não coincidem.
  #
  # Argumentos:
  #   Nenhum.
  #
  # Retorna:
  #   Exibe o formulário novamente com um alerta.
  def handle_password_mismatch
    flash.now[:alert] = 'As senhas não coincidem.'
    render :edit
  end
end
