# Controller responsável pela gestão de questionários.
#
# Permite visualizar, criar e editar questionários para turmas e templates.
class GerenciamentoController < ApplicationController
  # Exibe a página inicial do gerenciamento.
  #
  # Argumentos:
  #   Nenhum.
  #
  # Retorna:
  #   Exibe a página inicial do gerenciamento.
  def index
  end

  # Exibe o formulário para criar um novo questionário.
  #
  # Argumentos:
  #   Nenhum.
  #
  # Retorna:
  #   Exibe o formulário para criar um novo questionário, com listas de turmas e templates.
  def new_form
    @questionario = Questionario.new
    @turmas = Turma.all
    @templates = Template.all
  end

  # Processa a criação de um novo questionário.
  #
  # Argumentos:
  #   Nenhum.
  #
  # Retorna:
  #   Redireciona para a página inicial do gerenciamento com uma mensagem de sucesso ou exibe o formulário novamente com erro.
  def create_form
    @questionario = Questionario.new(questionario_params)
    
    if @questionario.save
      flash[:notice] = "Questionário criado com sucesso!"
      redirect_to gerenciamento_index_url
    else
      flash[:alert] = "Erro ao criar questionário #{@questionario.nome}"
      @turmas = Turma.all
      @templates = Template.all
      render :new_form
    end
  end

  private

  # Permite os parâmetros necessários para a criação de um questionário.
  #
  # Argumentos:
  #   Nenhum.
  #
  # Retorna:
  #   Parâmetros permitidos para a criação do questionário.
  def questionario_params
    params.require(:questionario)
    params[:questionario].permit(:nome, :turma_id, :template_id)
  end
end
