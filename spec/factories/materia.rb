FactoryBot.define do
  factory :materia do
    nome { "Materia de Teste"}
    codigo { "MT01" }
    association :departamento
  end
end