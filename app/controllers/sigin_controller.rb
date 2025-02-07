class SiginController < ApplicationController
  def new
  end

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
