class Recipe < ActiveRecord::Base
  validates :name, presence: true
  validates :rating, presence: true
  validates :ingredients, presence: true
  validates :directions, presence: true
  validates :photo_url, presence: true
  validates :created, presence: true
  validates :uid, presence: true
  validates_uniqueness_of :uid
end
