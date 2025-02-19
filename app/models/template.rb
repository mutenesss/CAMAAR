# Modelo `Template` representa um modelo de questionário com questões associadas.
#
# Associações:
# - Possui vários `Questionarios`.
# - Possui várias `Questaos`.
# - Possui várias `QuestaosOpt`.
#
class Template < ApplicationRecord
  has_many :questionarios
  has_many :questaos
  has_many :questaos_opt
end
