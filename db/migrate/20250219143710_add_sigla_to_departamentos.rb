class AddSiglaToDepartamentos < ActiveRecord::Migration[8.0]
  def change
    remove_column :departamentos, :sigla, :string
    add_column :departamentos, :sigla, :string, null: false
  end
end
