Projeto Gabaritei
=====================


1. Apresentação

Plataforma educacional online voltada para escolas e cursinhos. Flexível e adaptável, tem como objetivo suprir
de ser utilizado em diversos ambientes, com diversas combinações de hardware e software.

2. Tecnologia utilizada

    - Ruby on Rails
    - Bootstrap
    - Capybara
    - Selenium Web Driver
    
3. Sobre os testes

    O rails já fornece um sistema integrado de testes, bastando executar:
    
    ```
    $ rake test
    ```
    
    Os testes de integração, no entanto, foram feitos com tecnologias diferentes da padrão, devendo serem executados através do comando:
    
    ```
    $ rake selenium:testintegration
    ```
    Para utilizar o Chrome, ainda é necessário instalar o Chrome Driver: https://code.google.com/p/selenium/wiki/ChromeDriver. Além disso, o modo headless funciona, por enquanto, em modo Linux.
    Para rodar, não esqueça de usar de configurar o banco de dados, através de:
    
    ```
    $ rake db:drop    # so execute esse comando em ambiente de desenvolvimento, caso contrário todo o conteúdo do banco de dados 		      # será perdido
    $ rake db:create  # em caso de não usar o SQlite - Não necessário se o banco de dados já existir
    $ rake db:migrate # necessario em todos os bancos de dados
    ```
    Com as configurações padrões, iremos reodar o Selenium no modo Headless. Além disso, iremos ter como navegador padrão o Chrome. Para alterar as configurações padrões do testes, basta editar o arquivo test/test_helper.rb
    
    ```ruby
    #
	#Seta as configuracoes para o Capybara funcionar corretamente
	#
	def setupCapybara

		# Basic capybara setup
		Capybara.default_driver = :selenium
		# Firefox is Default
		# Changes to Chrome if uncommented
		Capybara.register_driver :selenium do |app|
  			Capybara::Selenium::Driver.new(app, :browser => :chrome)
		end
		Capybara.app_host = "http://localhost:3000"
		
		#Can be comment if we want to run headless
		headless = Headless.new
		headless.start
	end
    ```
