# Modelo `Questionario` representa um questionário aplicado a uma turma com base em um template.
#
# Atributos:
# - `nome`: Nome do questionário (obrigatório).
# - `turma_id`: Referência para a turma associada (obrigatório).
# - `template_id`: Referência para o template associado (obrigatório).
#
# Associações:
# - Pertence a um `Template`.
# - Pertence a uma `Turma`.
# - Possui várias `Respostas`.
# - Possui várias `Respondidos`.
#
# Validações:
# - `nome`: Deve estar presente.
# - `turma_id`: Deve estar presente.
# - `template_id`: Deve estar presente.
#
class Questionario < ApplicationRecord
  belongs_to :template
  belongs_to :turma
  has_many :respostas
  has_many :respondidos
  
  validates :nome, presence: true
  validates :turma_id, presence: true
  validates :template_id, presence: true
end
