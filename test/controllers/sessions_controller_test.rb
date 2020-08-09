require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get login_url
    assert_response :success
  end

  test "login should workd" do
    get login_path
    assert_response :success
    post login_path, params: {
      session: {
        email: 'email_1',
        password: 'foobar'
      }
    }
    user = users('user_1')
    assert_response :redirect
    assert_redirected_to user
    assert_not_nil session[:user_id]
    assert_equal session[:user_id], user.id
  end

  test "logout should work" do
    post login_path, params: {
      session: {
        email: 'email_1',
        password: 'foobar'
      }
    }
    assert_not_nil session[:user_id]
    post logout_path
    assert_redirected_to root_path
    assert_nil session[:user_id]
  end

  test "resetting session should make not logged in" do
    get root_path
    assert_response :success
    @request.reset_session
    assert_not logged_in?
  end
end
