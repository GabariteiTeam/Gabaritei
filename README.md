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
    $ rake selenium testintegration
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
