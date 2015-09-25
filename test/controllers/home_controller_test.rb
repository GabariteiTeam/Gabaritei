require 'test_helper'

class HomeControllerTest < ActionController::TestCase
  test "get home" do
		get :index
		assert_response :success
  end
end
