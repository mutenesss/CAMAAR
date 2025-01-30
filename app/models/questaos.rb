class Questaos < ApplicationRecord
  belongs_to :templates
  has_many :questao_options
  has_many :respostas
end