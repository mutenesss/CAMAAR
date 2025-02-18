class UpdateTableColumns < ActiveRecord::Migration[8.0]
  def change
    rename_column :materias, :Nome, :nome
    rename_column :materias, :Codigo, :codigo

    rename_column :questaooptions, :Nome, :nome
    rename_column :questaooptions, :Texto, :texto

    rename_column :questaos, :Nome, :nome
    rename_column :questaos, :Texto, :texto
    rename_column :questaos, :Tipo, :tipo

    rename_column :questionarios, :Nome, :nome
    rename_column :questionarios, :Turma, :turma

    rename_column :respostas, :Valor, :valor

    rename_column :departamentos, :Nome, :nome

    rename_column :templates, :Nome, :nome
    rename_column :templates, :PublicoAlvo, :publico_alvo
    rename_column :templates, :Semestre, :semestre

    rename_column :turmas, :Codigo, :codigo
    rename_column :turmas, :Semestre, :semestre
  end
end
