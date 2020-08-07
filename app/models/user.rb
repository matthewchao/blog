class User < ApplicationRecord
  has_secure_password
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true

  before_save :downcase_the_email



private
  def downcase_the_email
    self.email.downcase!
  end
end
