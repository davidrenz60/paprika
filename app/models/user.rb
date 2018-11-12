class User < ActiveRecord::Base
  has_secure_password validations: false
  has_many :comments

  validates :username, presence: true
  validates :password, presence: true
  validates :email, presence: true

  def admin?
    role == "admin"
  end
end