FactoryBot.define do
  factory :turma do
    codigo { 'MT01' }
    semestre { '2024.2' }
    association :materia
  end
end
