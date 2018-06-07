require 'paprika_api'

class Recipe < ActiveRecord::Base
  extend FriendlyId
  include PaprikaSync

  friendly_id :name, use: :slugged
  before_save :default_values

  validates :name, presence: true
  validates :ingredients, presence: true
  validates :uid, presence: true
  validates :token, presence: true

  has_many :recipe_categories, primary_key: :uid, foreign_key: :recipe_uid
  has_many :categories, through: :recipe_categories

  private

  def default_values
    self.photo_url = 'placeholder.jpg' if self.photo_url.blank?
  end
end
