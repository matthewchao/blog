require 'test_helper'

class UserUpdateActionsTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  setup do
    @user = users(:user_1)
  end

  test "log in and then get edit page" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_response :success
  end

  test "attempt to get edit page without login" do
    get edit_user_path(@user)
    assert_response :redirect
    assert_redirected_to login_path
  end

  test "log in and destroy self" do

    assert_difference('User.count',-1) do
      log_in_as(@user)
      delete user_path(@user)
    end

  end

  test "attempt to destroy without logging in" do
    assert_no_difference('User.count') do
      delete user_path(@user)
    end
    delete user_path(@user)
    assert_redirected_to login_path
  end

  test "log in as wrong user and attempt to get edit page" do
    assert false
  end

  test "log in as wrong user and attempt to destroy other user" do
    assert false
  end
end
