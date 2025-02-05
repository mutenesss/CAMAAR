class GerenciamentoController < ApplicationController
  def index
  end

  def new_form
    @questionarios = Questionarios.new
    @turmas = Turma.all
    @templates = Templates.all
  end

  def create_form
    @questionarios = Questionarios.new(questionarios_params)
    if @questionarios.save
      redirect_to gerenciamento_path, notice: "Questionário criado com sucesso!"
    else
      @turmas = Turma.all
      @templates = Templates.all
      render :new_form
    end
  end

  def importar_dados
  end

  private

  def questionarios_params
    params.require(:questionarios).permit(:nome, :turma_id, :templates_id)
  end
end