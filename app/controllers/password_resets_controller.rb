# Controller responsável pela redefinição de senhas dos usuários.
#
# Permite solicitar a redefinição de senha, exibir o formulário de redefinição e atualizar a senha.
class PasswordResetsController < ApplicationController
  # Exibe o formulário para solicitar a redefinição de senha.
  #
  # Argumentos:
  #   Nenhum.
  #
  # Retorna:
  #   Exibe o formulário de solicitação de redefinição de senha.
  def new
  end

  # Processa a solicitação de redefinição de senha.
  #
  # Argumentos:
  #   Nenhum.
  #
  # Retorna:
  #   Envia um e-mail com o token de redefinição ou exibe um erro se o e-mail não for encontrado.
  def create
    user = User.find_by(Email: params[:email]) # Busca pelo e-mail
    if user
      token = user.password_reset_tokens.create
      UserMailer.password_reset(user, token.token).deliver_now  # Envia o e-mail de redefinição de senha
      redirect_to root_path, notice: 'Email de redefinição de senha enviado.'
    else
      flash.now[:alert] = 'Email não encontrado.'
      render :new
    end
  end

  # Exibe o formulário para redefinir a senha com base no token.
  #
  # Argumentos:
  #   Nenhum.
  #
  # Retorna:
  #   Exibe o formulário para redefinir a senha ou redireciona para a página inicial em caso de token inválido.
  def edit
    @token = PasswordResetToken.find_by(token: params[:token])
    if @token&.valid_token?
      @user = @token.user
    else
      redirect_to root_path, alert: 'Link inválido ou expirado.'
    end
  end

  # Processa a atualização da senha.
  #
  # Argumentos:
  #   Nenhum.
  #
  # Retorna:
  #   Atualiza a senha do usuário ou exibe mensagens de erro caso a senha esteja em branco ou não coincida com a confirmação.
  def update
    @token = PasswordResetToken.find_by(token: params[:token])
    
    if @token&.valid_token?
      @user = @token.user
      if params[:password].blank? || params[:password_confirmation].blank?
        flash.now[:alert] = 'Senha não pode ficar em branco.'
        render :edit
      elsif params[:password] == params[:password_confirmation]
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
