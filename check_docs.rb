# script para verificar métodos não documentados com RDoc

def check_documentation(file_path)
    lines = File.readlines(file_path)
    lines.each_with_index do |line, index|
      # Verifica se é uma definição de método
      if line.strip.start_with?('def ')
        # Verifica se o método tem um comentário RDoc acima
        if index == 0 || !lines[index - 1].strip.start_with?('#')
          puts "#{file_path}:#{index + 1} - Método não documentado: #{line.strip}"
        end
      end
    end
  end
  
  # Caminho para o diretório de arquivos Ruby, pode ser um diretório específico ou 'Dir["**/*.rb"]' para todos os arquivos Ruby no diretório e subdiretórios
  directory = Dir.pwd  # Usando o diretório atual
  
  # Procura por arquivos .rb e chama a função de verificação
  Dir["#{directory}/**/*.rb"].each do |file|
    check_documentation(file)
  end
  