require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user1 = users(:user_1)
  end
  
  test "should get new" do
    get login_url
    assert_response :success
  end

  test "login without remember should work, and not remember" do
    log_in_as(@user1)
    assert_response :redirect
    assert_redirected_to @user1
    assert_not_nil session[:user_id]
    assert_nil cookies[:user_id]
    assert_nil cookies[:remember_token]
    assert_equal session[:user_id], @user1.id
  end

  test "login_with_remember should work" do
    assert_nil cookies[:user_id]
    assert_nil cookies[:remember_token]
    log_in_and_remember_as(@user1)
    assert_response :redirect
    assert_redirected_to @user1
    assert_not_nil cookies[:user_id]
    assert_not_nil cookies[:remember_token]
  end

  test "remembered user cookies should persist" do
    log_in_and_remember_as(@user1)
    # https://stackoverflow.com/a/33786100/5418498 for why we use @request
    @request.reset_session
    assert_not_nil cookies[:user_id]
    assert_not_nil cookies[:remember_token]
    assert_nil session[:user_id]
    # now for a more serious test that it is logged in
    # assert logged_in?
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
    assert_not logged_in_session?
  end
end
