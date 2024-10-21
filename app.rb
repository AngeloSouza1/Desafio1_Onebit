require 'sinatra'
require 'watir'
require 'json'

set :public_folder, 'public'
set :views, 'views'

get '/' do
  erb :index
end

post '/concluir_aulas' do
  @curso_principal_url = params[:curso_url]
  @progresso = []
  
  browser = Watir::Browser.new :firefox
  carregar_cookies(browser, 'cookies.json')
  
  browser.goto('https://comunidade.onebitcode.com/feed')
  if browser.url.include?('login')
    @progresso << { mensagem: "Erro: Você ainda não está logado. Verifique os cookies.", cor: 'vermelho' }
    erb :progresso
    browser.close
    return
  else
    @progresso << { mensagem: "Login bem-sucedido! Sessão autenticada.", cor: 'verde' }
  end
  
  browser.goto(@curso_principal_url)
  @aulas_concluidas = marcar_todas_as_aulas(browser, @progresso)
  browser.close

  erb :progresso
end

def carregar_cookies(browser, cookies_file)
  cookies = JSON.parse(File.read(cookies_file))
  browser.goto("https://comunidade.onebitcode.com")
  
  cookies.each do |cookie|
    browser.cookies.add(
      cookie['name'],
      cookie['value'],
      domain: cookie['domain'],
      path: cookie['path'] || '/',
      expires: cookie['expirationDate'] ? Time.at(cookie['expirationDate']) : nil,
      secure: cookie['secure'] || false
    )
  end
end

def marcar_todas_as_aulas(browser, progresso)
  links_aulas = browser.links(xpath: "//a[contains(@href, '/lessons/')]").map(&:href).uniq

  if links_aulas.empty?
    progresso << { mensagem: "Nenhuma aula ou módulo encontrado. Verifique a URL ou se já estão concluídas.", cor: 'cyan' }
    return []
  end

  aulas_concluidas = []
  
  links_aulas.each_with_index do |link, index|
    progresso << { mensagem: "Processando aula #{index + 1}: #{link}", cor: 'cyan' }
    browser.goto(link)

    botao_aula = browser.button(text: 'Concluir aula')

    if botao_aula.exists? && botao_aula.visible?
      botao_aula.click
      progresso << { 
        mensagem: "Aula #{index + 1} marcada como concluída: <a href='#{link}' target='_blank' style='color: white; background-color: blue; text-decoration: underline; padding: 5px; border-radius: 3px;'>Acessar aula</a>", 
        cor: 'verde' 
      }
      aulas_concluidas << link unless aulas_concluidas.include?(link)
    else
      progresso << { mensagem: "Aula #{index + 1} já estava concluída ou em andamento", cor: 'amarelo' }
    end

    sleep 5
  end

  aulas_concluidas.size
end
