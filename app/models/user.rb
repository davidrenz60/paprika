class User < ActiveRecord::Base
  has_secure_password validations: false
  has_many :comments
  has_many :user_recipes
  has_many :favorite_recipes, through: :user_recipes, source: :recipe

  validates :username, presence: true
  validates :password, presence: true
  validates :email, presence: true

  def admin?
    role == "admin"
  end

  def favorited?(recipe)
    favorite_recipes.include?(recipe)
  end
end
