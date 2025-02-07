class Turmas < ApplicationRecord
  belongs_to :materias
  has_many :matriculas
  has_many :questionarios
end