class User < ApplicationRecord
  has_secure_password
  has_secure_password :remember_token, validations: false
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }, on: :create
  # validates :password, presence: true, on: :update
  before_save :downcase_the_email

  attr_accessor :hi

private
  def downcase_the_email
    self.email.downcase!
  end
end
