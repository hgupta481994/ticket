require 'test_helper'

class RequirementControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get requirement_new_url
    assert_response :success
  end

  test "should get edit" do
    get requirement_edit_url
    assert_response :success
  end

  test "should get show" do
    get requirement_show_url
    assert_response :success
  end

end
