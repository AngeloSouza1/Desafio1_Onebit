require 'watir'
require 'json'

browser = Watir::Browser.new :firefox

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

carregar_cookies(browser, 'cookies.json')

browser.goto('https://comunidade.onebitcode.com/feed')
if browser.url.include?('login')
  puts "Erro: Você ainda não está logado. Verifique os cookies."
else
  puts "Login bem-sucedido! Sessão autenticada."
end

puts "Digite a URL do curso principal (onde estão listados todos os módulos e aulas):"
curso_principal_url = gets.chomp

browser.goto(curso_principal_url)

def marcar_todas_as_aulas(browser)
  links_modulos = browser.links(xpath: "//a[contains(@href, 'lessons')]")

  if links_modulos.empty?
    puts "Nenhuma aula ou módulo encontrado. Verifique a URL ou se já estão concluídas."
    return
  end

  links_modulos.each_with_index do |link, index|
    puts "Processando aula #{index + 1}: #{link.href}"
    
    browser.goto(link.href)
    
    botoes_aulas = browser.elements(xpath: "//button[contains(., 'Concluir aula')]")
    
    if botoes_aulas.empty?
      puts "Nenhuma aula para concluir encontrada em #{link.href}."
    else
      botoes_aulas.each_with_index do |botao, index_aula|
        botao.click
        puts "Aula marcada como concluída em #{link.href}."
        sleep 5
      end
    end
  end
end

marcar_todas_as_aulas(browser)

browser.close

puts "Aulas concluídas!!"
sleep 3
