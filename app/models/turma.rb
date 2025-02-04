class Turma < ApplicationRecord
  belongs_to :materia
  has_many :matriculas
  has_many :questionarios
end