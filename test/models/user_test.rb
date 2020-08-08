require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
  end

  test "name and email should be valid" do
    user = User.new(
      :name => 'a',
      :email => 'b@c.com',
      :password => 'foobar'
    )
    assert user.valid?
  end

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
end
