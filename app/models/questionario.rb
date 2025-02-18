class Questionario < ApplicationRecord
  belongs_to :template
  belongs_to :turma
  has_many :respostas
  has_many :respondidos
  
  validates :nome, presence: true
  validates :turma_id, presence: true
  validates :template_id, presence: true
end