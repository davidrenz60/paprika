class User < ActiveRecord::Base
  has_secure_password validations: false

  validates :username, presence: true
  validates :password, presence: true

  def admin?
    role === "admin"
  end
end