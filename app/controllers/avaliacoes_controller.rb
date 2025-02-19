# Controlador responsável pela exibição e gerenciamento das avaliações.
class AvaliacoesController < ApplicationController
  # Exibe todas as avaliações.
  def index
    @avaliacoes = Avaliacao.all  # Busca todas as avaliações no banco de dados
  end

  # Exibe uma avaliação específica com suas perguntas.
  def show
    @avaliacao = Avaliacao.find(params[:id])  # Busca a avaliação pelo ID
    @perguntas = [
      "Como você avalia o conteúdo?",  # Pergunta sobre o conteúdo
      "O professor foi claro nas explicações?",  # Pergunta sobre a clareza do professor
      "Comentários adicionais"  # Pergunta sobre comentários extras
    ]
  end
end
