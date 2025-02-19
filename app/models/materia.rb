# Modelo `Materia` representa uma disciplina dentro de um departamento.
#
# Atributos:
# - `departamento_id`: Referência para o departamento ao qual a matéria pertence.
#
# Associações:
# - Pertence a um `Departamento`.
# - Possui várias `Turmas`.
#
class Materia < ApplicationRecord
  self.table_name = "materias"
  
  belongs_to :departamento
  has_many :turmas
end
