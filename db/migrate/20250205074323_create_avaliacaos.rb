# Criação da tabela 'avaliacaos'.
#
# Esta migração cria a tabela `avaliacaos` no banco de dados, que é utilizada
# para armazenar informações sobre as avaliações de diferentes disciplinas,
# incluindo o nome da matéria, o semestre e o nome do professor responsável.
#
# Campos:
# - nome_materia: O nome da matéria relacionada à avaliação.
# - semestre: O semestre em que a avaliação ocorre.
# - professor: O nome do professor responsável pela avaliação.
#
class CreateAvaliacaos < ActiveRecord::Migration[8.0]
  #Criação da tabela 'avaliacaos'
  #
  def change
    create_table :avaliacaos do |t|
      t.string :nome_materia
      t.string :semestre
      t.string :professor

      t.timestamps
    end
  end
end
