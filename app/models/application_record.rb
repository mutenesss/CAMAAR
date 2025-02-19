# Classe base abstrata para todos os modelos.
#
# Herda de `ActiveRecord::Base`, permitindo que todos os modelos no aplicativo
# tenham acesso a funcionalidades do Active Record, como CRUD.
class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class
end
