require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user = User.new(name: 'a', email: 'B')
  end

  test "no name should be invalid" do
    @user.name = ''
    assert_not @user.valid?
  end

  test "no email should be invalid" do
    @user.email = ''
    assert_not @user.valid?
  end
end
