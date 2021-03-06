require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users('user_1')
  end

  test "should get index" do
    get users_url
    assert_response :success
  end

  test "should get new" do
    get new_user_url
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post users_url, params: { user: { email: 'not-in-fixtures', name: @user.name, 
      password: "foobar", password_confirmation: "foobar"} }
    end
    assert User.last.email==User.last.email.downcase
    assert_redirected_to login_path
  end

  test "should not create user if passwords don't match" do
    assert_no_difference('User.count') do
      post users_url, params: { user: { email: 'not-in-fixtures', name: @user.name, 
      password: "foobar", password_confirmation: "foobar1"} }
    end

    # assert_redirected_to new_user_url
  end

  test "should not creater user with same email as other user" do
    assert_no_difference('User.count') do
      post users_url, params: { user: { email: @user.email, name: @user.name, 
      password: "foobar", password_confirmation: "foobar"} }
    end
  end

  test "should show user" do
    get user_url(@user)
    assert_response :success
  end

  test "should get edit" do  
    get edit_user_url(@user)
    assert_redirected_to login_path
  end

  # test "should update user" do
  #   patch user_url(@user), params: { user: { email: @user.email, name: @user.name } }
  #   assert_redirected_to user_url(@user)
  # end

  test "should destroy user" do
    log_in_and_remember_as(@user)
    assert_difference('User.count', -1) do
      delete user_url(@user)
    end

    assert_redirected_to root_url
    assert_nil session[:user_id]
    assert cookies[:user_id].blank?
    assert cookies[:remember_token].blank?
  end
end
