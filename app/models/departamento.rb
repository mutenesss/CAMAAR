# Modelo `Departamento` representa um departamento acadêmico.
#
# Um departamento pode ter várias matérias e, indiretamente, várias turmas associadas a ele.
#
# Associações:
# - `has_many :materias` → Um departamento possui várias matérias.
# - `has_many :turmas, through: :materias` → Um departamento tem várias turmas por meio das matérias.
class Departamento < ApplicationRecord
  has_many :materias
  has_many :turmas, through: :materias
end
