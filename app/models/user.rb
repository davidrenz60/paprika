class User < ActiveRecord::Base
  has_secure_password validations: false
  has_many :comments
  has_many :user_recipes
  has_many :favorite_recipes, through: :user_recipes, source: :recipe

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true

  def admin?
    role == "admin"
  end

  def favorited?(recipe)
    favorite_recipes.include?(recipe)
  end

  def generate_token!
    update_column(:token, SecureRandom.urlsafe_base64)
    update_column(:token_expiration, Time.now + 5.minutes)
  end

  def expired_token?
    Time.now > token_expiration
  end

  def clear_token
    update_column(:token, nil)
    update_column(:token_expiration, nil)
  end
end
