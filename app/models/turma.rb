# Modelo `Turma` representa uma turma vinculada a uma matéria.
#
# Associações:
# - Pertence a uma `Materia`.
# - Possui várias `Matriculas`.
# - Possui vários `Questionarios`.
#
class Turma < ApplicationRecord
  belongs_to :materia
  has_many :matriculas
  has_many :questionarios
end
