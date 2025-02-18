class GerenciamentoController < ApplicationController
  def index
  end

  def new_form
    @questionario = Questionario.new
    @turmas = Turma.all
    @templates = Template.all
  end

  def create_form
    #Rails.logger.debug "Received parameters: #{params.inspect}"
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

  def questionario_params
    params.require(:questionario)
    params[:questionario].permit(:nome, :turma_id, :template_id)
  end
end