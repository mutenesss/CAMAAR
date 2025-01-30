class Questionarios < ApplicationRecord
  belongs_to :templates
  has_many :respostas
end