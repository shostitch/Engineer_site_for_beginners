require "test_helper"

class User::MembersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get user_members_index_url
    assert_response :success
  end

  test "should get show" do
    get user_members_show_url
    assert_response :success
  end

  test "should get edit" do
    get user_members_edit_url
    assert_response :success
  end

  test "should get check" do
    get user_members_check_url
    assert_response :success
  end
end
