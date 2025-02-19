# Altera a coluna `turma` para referência `turma_id` em `questionarios`
#
# Esta migração visa corrigir a relação entre a tabela `questionarios` e a tabela
# `turmas`, alterando a coluna `turma` (que era do tipo `string`) para uma referência
# estrangeira `turma_id` (do tipo `integer`). Isso garante uma associação adequada
# entre as tabelas e melhora a integridade referencial no banco de dados.
#
class ChangeTurmaToReferenceInQuestionarios < ActiveRecord::Migration[8.0]
  # Add the correct foreign key reference
  def change
    
    add_column :questionarios, :turma_id, :integer
    add_foreign_key :questionarios, :turmas, column: :turma_id, primary_key: :TurmaID
    add_index :questionarios, :turma_id

    remove_column :questionarios, :turma, :string
  end
end
