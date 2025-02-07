class AvaliacoesController < ApplicationController
  def index
    @avaliacoes = Avaliacao.all
  end

  def show
    @avaliacao = Avaliacao.find(params[:id])
    @perguntas = [
      "Como você avalia o conteúdo?",
      "O professor foi claro nas explicações?",
      "Comentários adicionais"
    ]
  end
end
