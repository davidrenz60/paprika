class Recipe < ActiveRecord::Base
  extend FriendlyId

  friendly_id :name, use: :slugged
  before_save :default_values

  validates :name, presence: true
  validates :ingredients, presence: true
  validates :uid, presence: true
  validates :token, presence: true

  has_many :comments
  has_many :recipe_categories, primary_key: :uid, foreign_key: :recipe_uid
  has_many :categories, through: :recipe_categories
  has_many :ratings

  has_many :user_recipes
  has_many :favorited_by, through: :user_recipes, source: :user

  def should_generate_new_friendly_id?
    name_changed? || super
  end

  def update_average_rating
    return if ratings.blank?
    rounded_average = (ratings.average(:rating) * 2).round / 2.0
    update(average_rating: rounded_average)
  end

  def average_rating_class
    average_rating.split('.').join('') if average_rating
  end

  def self.uids
    all.map(&:uid)
  end

  def self.delete_not_in(uids)
    all.reject { |recipe| uids.include?(recipe.uid) }.each(&:delete)
  end

  private

  def default_values
    self.photo_url = 'placeholder.jpg' if self.photo_url.blank?
  end
end
