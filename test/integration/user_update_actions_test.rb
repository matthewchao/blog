require 'test_helper'

class UserUpdateActionsTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user1 = users(:user_1)
    @user2 = users(:user_2)
  end

  test "log in and then get edit page" do
    log_in_as(@user1)
    get edit_user_path(@user1)
    assert_response :success
  end

  test "attempt to get edit page without login" do
    get edit_user_path(@user1)
    assert_response :redirect
    assert_redirected_to login_path
  end

  test "log in and destroy self" do

    assert_difference('User.count',-1) do
      log_in_as(@user1)
      delete user_path(@user1)
    end

  end

  test "attempt to destroy without logging in" do
    assert_no_difference('User.count') do
      delete user_path(@user1)
    end
    delete user_path(@user1)
    assert_redirected_to login_path
  end

  test "log in as wrong user and attempt to get edit page" do
    log_in_as(@user2)
    # puts "getting edit path of user #{@user1.id}"
    get edit_user_path(@user1)
    assert_response :redirect
    assert_redirected_to root_path
  end

  test "log in as wrong user and attempt to get edit page, roles reversed" do
    log_in_as(@user1)
    # puts "getting edit path of user #{@user2.id}"
    get edit_user_path(@user2)
    assert_response :redirect
    assert_redirected_to root_path
  end

  test "log in as wrong user and attempt to destroy other user" do
    log_in_as(@user1)
    # puts "getting edit path of user #{@user2.id}"
    delete user_path(@user2)
    assert_response :redirect
    assert_redirected_to root_path
  end
end
