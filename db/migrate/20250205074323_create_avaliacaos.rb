class CreateAvaliacaos < ActiveRecord::Migration[8.0]
  def change
    create_table :avaliacaos do |t|
      t.string :nome_materia
      t.string :semestre
      t.string :professor

      t.timestamps
    end
  end
end
