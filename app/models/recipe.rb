class Recipe < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged

  validates :name, presence: true
  validates :ingredients, presence: true
  validates :uid, presence: true
end
