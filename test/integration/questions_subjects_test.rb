require 'test_helper'

class QuestionsSubjectsTest < ActionDispatch::IntegrationTest
  include Capybara::DSL
  
  setup do
  	@question = questions(:one)
  	@subject = subjects(:one)
  	setupCapybara
  	setupSeleniumEnv
  end
  
  #
  # Teste de criacao e relacionamento
  # entre os models subjects e questions
  # Testa tambem os controllers e filtros
  # de disciplinas
  #

  test "CreateSubject" do
    visit('/subjects')
    visist
  end

  
  test "GetAllQuestionsFromSubject" do
   
   visit('/subjects')
   assert page.has_content?('Listing subjects')
   click_link "New Subject"
   assert page.has_content?('New subject')
   fill_in 'subject_name', :with => 'Geografia'
   click_button 'Criar'
   assert page.has_content?('Subject was successfully created.')
   
   
   
   visit('/questions')
   
   assert page.has_content?('Banco de Questoes')
   click_link "New Question"
   assert page.has_content?('Nova quest')
   fill_in 'question_question', :with => 'Lorem Ipsum of Geography'
   fill_in 'question_subject_id', :with => '1'
   click_button 'Criar'
   assert page.has_content?('Question was successfully created.')
   click_link "Back"
   assert page.has_content?('Lorem Ipsum of Geography')
   select('Geografia', :from => 'subject_id')
   click_button 'Filtrar'
   assert page.has_content?('Lorem Ipsum of Geography')
  end
end
