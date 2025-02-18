class Template < ApplicationRecord
  has_many :questionarios
  has_many :questaos
  has_many :questaos_opt
end