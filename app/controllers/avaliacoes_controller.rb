class AvaliacoesController < ApplicationController
  def index
    @avaliacoes = [
      { nome_materia: "PAA", semestre: "2024/1", professor: "Prof. João" },
      { nome_materia: "OAC", semestre: "2024/1", professor: "Prof. Maria" },
      { nome_materia: "Cálculo 1", semestre: "2024/2", professor: "Prof. Carlos" },
      { nome_materia: "Física 1", semestre: "2024/2", professor: "Prof. Pedro" },
      { nome_materia: "ISC", semestre: "2024/2", professor: "Prof. Joana" },
      { nome_materia: "Engenharia de Software", semestre: "2024/2", professor: "Prof. Nara" }
    ]
  end

  def show
    @avaliacao = { id: params[:id], nome_materia: "Matemática", semestre: "2024/1", professor: "Prof. João" }
    @perguntas = [
      "Como você avalia o conteúdo?",
      "O professor foi claro nas explicações?",
      "Comentários adicionais"
    ]
  end
end
