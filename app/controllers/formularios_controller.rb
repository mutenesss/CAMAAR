class FormulariosController < ApplicationController
  def new
    @avaliacao = Avaliacao.find(params[:id])
    @formulario = Formulario.new
  end

  def create
    @formulario = Formulario.new(formulario_params)
    if @formulario.save
      redirect_to avaliacoes_path, notice: "Formulário enviado com sucesso!"
    else
      render :new
    end
  end

  private

  def formulario_params
    params.require(:formulario).permit(:avaliacao_id, :resposta)
  end
end
