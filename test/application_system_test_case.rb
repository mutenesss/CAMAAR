require "test_helper"

# Classe base para testes de sistema com Selenium e Chrome headless
#
class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :headless_chrome, screen_size: [ 1400, 1400 ]
end
