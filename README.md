# 🏗️ Ruby on Rails Application

![Coverage](https://img.shields.io/badge/coverage-100%25-brightgreen) ![Build](https://img.shields.io/github/actions/workflow/status/seu-usuario/seu-projeto/ci.yml?branch=main) ![License](https://img.shields.io/github/license/seu-usuario/seu-projeto) ![Ruby](https://img.shields.io/badge/Ruby-3.0-red) ![Rails](https://img.shields.io/badge/Rails-7.0-red)

Bem-vindo ao repositório da nossa aplicação Ruby on Rails! 🚀
Este projeto segue as melhores práticas de engenharia de software, utilizando **TDD (Test-Driven Development)** com **RSpec** e **Cucumber**, além de boas práticas de versionamento e desenvolvimento colaborativo. 

## 📌 Tecnologias Utilizadas

- 🛤️ **Ruby on Rails** - Framework web robusto e produtivo
- 🧪 **RSpec** - Testes unitários e de integração
- 🥒 **Cucumber** - Testes de aceitação (BDD)
- 🗄️ **SQLite** - Banco de dados relacional
- 🏗️ **Docker** - Containerização da aplicação
- ☁️ **AWS** - Deploy e infraestrutura escalável

## 🚀 Como Rodar o Projeto

### 📋 Pré-requisitos

Certifique-se de ter instalado:
- Ruby (>= 3.0.0)
- Rails (>= 7.0)
- SQLite
- Docker e Docker Compose (opcional)

### 🏃 Passos para execução

1. Clone o repositório:
   ```bash
   git clone https://github.com/seu-usuario/seu-projeto.git
   cd seu-projeto
   ```

2. Instale as dependências:
   ```bash
   bundle install
   ```

3. Configure o banco de dados:
   ```bash
   rails db:create db:migrate db:seed
   ```

4. Execute os testes:
   ```bash
   rspec
   ```

5. Inicie a aplicação:
   ```bash
   rails server
   ```

Acesse no navegador: [http://localhost:3000](http://localhost:3000) 🚀

## 🛠️ Boas Práticas de Desenvolvimento

### 🔖 Versionamento Semântico (Semantic Versioning)

Este projeto segue **[SemVer](https://semver.org/)**:
- **MAJOR**: Mudanças incompatíveis na API
- **MINOR**: Adição de funcionalidades compatíveis
- **PATCH**: Correções de bugs retrocompatíveis

### 🎯 Commits Convencionais (Conventional Commits)

Utilizamos o padrão **[Conventional Commits](https://www.conventionalcommits.org/)** para manter um histórico claro e organizado:

- `feat:` Nova funcionalidade
- `fix:` Correção de bug
- `refactor:` Refatoração sem alteração de funcionalidade
- `test:` Adição ou modificação de testes
- `docs:` Alterações na documentação
- `chore:` Tarefas de manutenção

## 📜 Licença

Este projeto está licenciado sob a **MIT License**. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.

---

💡 **Dúvidas ou sugestões?** Sinta-se à vontade para abrir uma issue ou contribuir! 😊


