require 'test_helper'

#
#Atencao a mudanca de campos no banco de dados
#Alguns campos podem quebrar os testes de create e update
#

class QuestionsControllerTest < ActionController::TestCase
  setup do
    @question = questions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    #assert_not_nil assigns(:questions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end


  test "should create question" do
    assert_difference('Question.count') do
      post :create, question: { area: @question.area, question: @question.question, year: @question.year, subject_id: @question.subject_id}
    end
  
    assert_redirected_to question_path(assigns(:question))
  end
  
  test "should show question" do
    get :show, id: @question
    assert_response :success
  end
  
  test "should get edit" do
    get :edit, id: @question
    assert_response :success
  end
  
  test "should update question" do
    patch :update, id: @question, question: { area: @question.area, question: @question.question, year: @question.year }
    assert_redirected_to question_path(assigns(:question))
  end
  
  test "should destroy question" do
    assert_difference('Question.count', -1) do
      delete :destroy, id: @question
    end
  
    assert_redirected_to questions_path
  end
end
