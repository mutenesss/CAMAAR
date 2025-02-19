# Atualiza os nomes das colunas nas tabelas do banco de dados
#
# Esta migração tem como objetivo atualizar os nomes das colunas em várias
# tabelas do banco de dados, adotando uma convenção de nomenclatura em
# minúsculas e com uso de underscore para separar palavras.
#
# Tabelas e colunas afetadas:
# - **materias**: 
#   - `Nome` -> `nome`
#   - `Codigo` -> `codigo`
# - **questaooptions**: 
#   - `Nome` -> `nome`
#   - `Texto` -> `texto`
# - **questaos**: 
#   - `Nome` -> `nome`
#   - `Texto` -> `texto`
#   - `Tipo` -> `tipo`
# - **questionarios**:
#   - `Nome` -> `nome`
#   - `Turma` -> `turma`
# - **respostas**:
#   - `Valor` -> `valor`
# - **departamentos**:
#   - `Nome` -> `nome`
# - **templates**:
#   - `Nome` -> `nome`
#   - `PublicoAlvo` -> `publico_alvo`
#   - `Semestre` -> `semestre`
# - **turmas**:
#   - `Codigo` -> `codigo`
#   - `Semestre` -> `semestre`
#
class UpdateTableColumns < ActiveRecord::Migration[8.0]
  #Update das colunas da tabela
  #
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
