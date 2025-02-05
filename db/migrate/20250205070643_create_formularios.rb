class CreateFormularios < ActiveRecord::Migration[8.0]
  def change
    create_table :formularios do |t|
      t.integer :avaliacao_id
      t.text :resposta

      t.timestamps
    end
  end
end
