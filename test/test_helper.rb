ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'database_cleaner'
require 'headless'

	class ActiveSupport::TestCase
	# Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
	fixtures :all
	headless = Headless.new

	# Add more helper methods to be used by all tests here... 

	#
	#Seta as configuracoes para o Capybara funcionar corretamente
	#
	def setupCapybara
		Capybara.default_driver = :selenium
		Capybara.app_host = "http://localhost:3000"

		

		#Can be comment if we want to run headless
		#headless.start
	end




	#
	# Finaliza o servidor de testes
	# Mata a instância do servidor rails
	# Necessario somente quando estivermos rodando
	# Servidor de testes junto com o computador de desenvolvimento
	#
	def teardown
		
	end
  
end
