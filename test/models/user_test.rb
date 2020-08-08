require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user = users(:one)
  end

  # the below series indicates that fixtures are 
  # test "fixture with no password/passwordconf should not be valid" do
  #   assert_not @user.valid?
  # end
  # test "fixture with no passwordconf should not be valid" do
  #   @user.password = 'f'
  #   assert_not @user.valid?
  # end
  # test "fixture with password+diff conf should not be valid" do
  #   @user.password = 'f'
  #   @user.password_confirmation = 'g'
  #   assert_not @user.valid?
  # end
  # test "fixture with password+ conf SHOULD be valid" do
  #   @user.password = 'f'
  #   @user.password_confirmation = 'f'
  #   assert @user.valid?
  # end
  # test "name and email should be valid" do
  #   user = User.new(
  #     :name => 'a',
  #     :email => 'b@c.com',
  #     :password => 'foobar'
  #   )
  #   assert user.valid?
  # end
  

  test "no name should be invalid" do
    user = User.new(
      :name => '  ',
      :email => 'b@c.com',
      :password => 'foobar'
    )
    assert_not user.valid?
  end

  test "no email should be invalid" do
    user = User.new(
      :name => 'a',
      :email => ' ',
      :password => 'foobar'      
    )
    assert_not user.valid?
  end

  test "no password should be invalid" do
    user = User.new(
      :name => 'a',
      :email => 'b@c.com',
      :password => '   '
    )
    assert_not user.valid?
  end
  test "short password should be invalid" do
    user = User.new(
      :name => 'a',
      :email => 'b@c.com',
      :password => 'abcde'
    )
    assert_not user.valid?
  end
end
