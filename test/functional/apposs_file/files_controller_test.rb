require 'test_helper'

module AppossFile
  class FilesControllerTest < ActionController::TestCase
    test "should get index" do
      get :index
      assert_response :success
    end
  
  end
end
