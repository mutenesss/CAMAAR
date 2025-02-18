class ChangeTurmaToReferenceInQuestionarios < ActiveRecord::Migration[8.0]
  def change
    # Add the correct foreign key reference
    add_column :questionarios, :turma_id, :integer
    add_foreign_key :questionarios, :turmas, column: :turma_id, primary_key: :TurmaID
    add_index :questionarios, :turma_id

    remove_column :questionarios, :turma, :string
  end
end
