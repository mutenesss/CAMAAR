# Controller responsável pela autenticação do usuário (login).
#
# Permite que o usuário faça login com e-mail ou matrícula.
class SiginController < ApplicationController
  # Exibe o formulário de login.
  #
  # Argumentos:
  #   Nenhum.
  #
  # Retorna:
  #   Exibe o formulário de login.
  def new
  end

  # Processa a solicitação de login, verificando as credenciais do usuário.
  #
  # Argumentos:
  #   Nenhum.
  #
  # Retorna:
  #   Redireciona para a página inicial se o login for bem-sucedido ou exibe um alerta se houver erro.
  def create
    user = User.find_by("Email = ? OR Matricula = ?", params[:identifier], params[:identifier])
    
    if user
      if user.Senha == params[:password]
        redirect_to root_path, notice: "Logado com sucesso"
      else
        flash[:alert] = 'Senha incorreta.'
        render :new and return
      end
    else
      flash[:alert] = 'E-mail ou matrícula não encontrados.'
      render :new
    end
  end
end
