ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'database_cleaner'
require 'headless'

	class ActiveSupport::TestCase
	# Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
	fixtures :all
	

	# Add more helper methods to be used by all tests here... 

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




	#
	# Finaliza o servidor de testes
	# Mata a instância do servidor rails
	# Necessario somente quando estivermos rodando
	# Servidor de testes junto com o computador de desenvolvimento
	#
	def teardown
		
	end
  
end
