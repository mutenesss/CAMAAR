# Criação da tabela 'formularios'.
#
# Esta migração cria a tabela `formularios` no banco de dados,
# que é utilizada para armazenar as respostas dos formulários
# relacionados a uma avaliação. Cada formulário estará vinculado
# a uma avaliação específica através do campo `avaliacao_id`.
#
# Campos:
# - avaliacao_id: Identificador da avaliação associada ao formulário.
# - resposta: Texto que contém a resposta fornecida no formulário.
#
class CreateFormularios < ActiveRecord::Migration[8.0]
  # Criação da tabela `formularios`
  def change
    create_table :formularios do |t|
      t.integer :avaliacao_id
      t.text :resposta

      t.timestamps
    end
  end
end
