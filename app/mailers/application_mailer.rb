# Classe base para todos os mailers da aplicação.
#
# Configura o remetente padrão dos e-mails e aplica um layout específico.
#
# Atributos:
# - `default from: "from@example.com"` - Define o endereço de e-mail padrão do remetente.
# - `layout "mailer"` - Usa o layout `mailer` para os e-mails.
#
# Todos os mailers da aplicação devem herdar desta classe.
#
class ApplicationMailer < ActionMailer::Base
  default from: "from@example.com"
  layout "mailer"
end
