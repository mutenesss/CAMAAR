class Materia < ApplicationRecord
  self.table_name = "materias"
  belongs_to :departamento
  has_many :turmas
end