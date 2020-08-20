require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user1 = users(:user_1)
  end
  
  test "should get new" do
    get login_url
    assert_response :success
  end

  test "login should work" do
    log_in_as(@user1)
    assert_response :redirect
    assert_redirected_to @user1
    assert_not_nil session[:user_id]
    assert_equal session[:user_id], @user1.id
  end


  test "logout should work" do
    log_in_as(@user1)
    assert_not_nil session[:user_id]
    post logout_path
    assert_redirected_to root_path
    assert_nil session[:user_id]
  end
  
  test "logout when not logged in should work" do
    post logout_path
    assert_response :redirect
  end

  test "resetting session should make not logged in" do
    get root_path
    assert_response :success
    @request.reset_session
    assert_not logged_in?
  end
end
