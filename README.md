
# Automação de Conclusão de Aulas - OneBitCode

<div align="justify">
Este projeto é um script em Ruby que automatiza o processo de marcar aulas como concluídas em cursos da plataforma OneBitCode. O script usa o navegador Firefox via Watir para navegar na página do curso, encontrar todas as aulas e marcar automaticamente cada uma como concluída.</div>

## Requisitos
### Ferramentas Necessárias

<p>

🔹 Sistema Linux

🔹 Navegador Firefox

🔹 Ruby: Certifique-se de que o Ruby está instalado na sua máquina. Você pode verificar isso rodando o seguinte comando no terminal:
```bash
ruby -v
```
Caso não esteja instalado, você pode seguir as instruções do site oficial: https://www.ruby-lang.org/en/documentation/installation/

🔹 Bundler: Usamos o Bundler para gerenciar as dependências do projeto. Para instalar o Bundler:
```bash
gem install bundler
```

🔹 GeckoDriver: O script usa o navegador Firefox via Watir, então você precisará do GeckoDriver. Baixe a versão mais recente do GeckoDriver em: https://github.com/mozilla/geckodriver/releases e instale conforme instruções.
##### Após o download, descompacte o arquivo e mova o binário para um local acessível pelo sistema, como /usr/local/bin:
```bash
sudo mv geckodriver /usr/local/bin/
```
🔹 Extensão Cookie-Editor (opcional): Para evitar fazer login toda vez que o script rodar, você pode reutilizar cookies de uma sessão já autenticada. Instale a extensão Cookie-Editor no Firefox: https://addons.mozilla.org/en-US/firefox/addon/cookie-editor/

### Dependências Ruby
🔹Para instalar todas as dependências do Ruby (gem watir e outras), rode o comando:
  ```bash
bundle install
```
🔹 O arquivo Gemfile contém as seguintes dependências:
```bash
source 'https://rubygems.org'

gem 'watir'
gem 'selenium-webdriver'
```
🔹 Instale as dependências do projeto utilizando o Bundler:

  ```bash
bundle install
```

## Configuração
### Execução Passo a Passo

 🔹 No terminal, navegue até o diretório do projeto:
  ```bash
cd /caminho/para/seu/projeto
```
 🔹 Execute o script:
  ```bash
ruby marcar_aulas.rb
```

🔹Quando solicitado, insira a URL principal do curso onde todos os módulos e aulas estão listados:
 
 ```bash
https://comunidade.onebitcode.com/c/curso-base-do-js/sections
```  
🔹O script percorrerá automaticamente todas as aulas encontradas na página, marcando cada uma delas como concluída.

### Video Demonstrativo

https://github.com/user-attachments/assets/8314c0a1-8cf4-4f4a-a342-867ce0599e7e


---

### Exemplo de Execução

 ```bash
$ ruby marcar_aulas.rb

Login bem-sucedido! Sessão autenticada.
Digite a URL do curso principal (onde estão listados todos os módulos e aulas):
https://comunidade.onebitcode.com/c/curso-base-do-js/sections
Processando aula 1: https://comunidade.onebitcode.com/c/curso-base-do-js/sections/360666/lessons/1340607
Aula  marcada como concluída.
Aula  marcada como concluída.
```  
<br>

---

### Estrutura do Projeto

 🔹 Execute o script:
  ```bash
├── Gemfile             # Lista de dependências do Ruby
├── Gemfile.lock        # Arquivo gerado pelo Bundler para controle de dependências
├── marcar_aulas.rb     # Script principal de automação
├── cookies.json        # Arquivo JSON contendo os cookies da sessão autenticada
└── README.md           # Este arquivo README

```
<br>

----

### Explicação Técnica do Script

O script segue os seguintes passos:


🔹 Carregar Cookies: Ele carrega os cookies da sessão previamente autenticada, para evitar a necessidade de login manual.

🔹 Cookies são lidos do arquivo cookies.json e aplicados no navegador antes de acessar a plataforma.

🔹 Acessar a Página Principal do Curso: O usuário insere a URL principal do curso onde todos os módulos e aulas estão listados. O script acessa essa URL e identifica todos os links para as aulas.

🔹 Marcar Aulas: O script percorre cada link de aula encontrado e marca automaticamente como concluída ao clicar no botão "Concluir aula".

🔹 Relatório Final: O script imprime um resumo de todas as aulas que foram marcadas como concluídas ao final do processo.

🔹 Fechar o Navegador: Após processar todas as aulas, o navegador é fechado automaticamente.

---

### Problemas Comuns

#### Cookies Inválidos
- Solução: Se o login falhar ou você for redirecionado para a página de login, exporte novamente os cookies da sessão autenticada.

#### GeckoDriver Desatualizado
- Solução: Atualize o GeckoDriver para a versão mais recente compatível com o seu Firefox.

#### Botões Não Encontrados
-  Se o script não encontrar os botões de "Concluir aula", pode ser necessário ajustar o XPath que localiza os botões na página.

---

### Contribuição

Contribuições são bem-vindas! Se você quiser contribuir para o projeto, siga estas etapas:

🔹 Faça um fork do projeto.

🔹 Crie uma nova branch com a sua feature: git checkout -b minha-feature

🔹 Faça commit das suas alterações: git commit -m 'Adicionar nova feature'

🔹 Faça push para a branch: git push origin minha-feature

🔹 Envie um pull request.

---
### Licença

Este projeto é licenciado sob a MIT License.

---
### 📧 Contato
Para mais informações ou para relatar problemas, entre em contato pelo angeloafdesouza@gmail.com











