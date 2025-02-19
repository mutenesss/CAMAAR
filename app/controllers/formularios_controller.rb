# Controller responsável pela criação de formulários.
#
# Permite criar e enviar formulários relacionados a avaliações.
class FormulariosController < ApplicationController
  # Exibe o formulário para criar um novo formulário relacionado a uma avaliação.
  #
  # Argumentos:
  #   Nenhum.
  #
  # Retorna:
  #   Exibe o formulário para o usuário preencher.
  def new
    @avaliacao = Avaliacao.find(params[:id])
    @formulario = Formulario.new
  end

  # Processa o envio de um formulário preenchido.
  #
  # Argumentos:
  #   Nenhum.
  #
  # Retorna:
  #   Redireciona para a lista de avaliações com uma mensagem de sucesso ou exibe o formulário novamente.
  def create
    @formulario = Formulario.new(formulario_params)
    if @formulario.save
      redirect_to avaliacoes_path, notice: "Formulário enviado com sucesso!"
    else
      render :new
    end
  end

  private

  # Permite os parâmetros necessários para a criação de um formulário.
  #
  # Argumentos:
  #   Nenhum.
  #
  # Retorna:
  #   Parâmetros permitidos para a criação do formulário.
  def formulario_params
    params.require(:formulario).permit(:avaliacao_id, :resposta)
  end
end
