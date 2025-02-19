# Controlador principal da aplicação.
#
# Este controlador serve como a base para todos os outros controladores na aplicação.
# Ele define configurações globais que se aplicam a toda a aplicação e pode ser utilizado
# para definir comportamentos comuns entre os controladores.
#
class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
end
