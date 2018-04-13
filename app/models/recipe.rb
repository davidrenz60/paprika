class Recipe < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged

  validates :name, presence: true
  validates :ingredients, presence: true
  validates :uid, presence: true

  def self.parse(recipes_data)
    recipes = recipes_data.map do |data|
      new(
        name: data["name"],
        rating: data["rating"],
        ingredients: data["ingredients"],
        directions: data["directions"],
        photo_url: data["photo_url"],
        created: data["created"],
        uid: data["uid"]
      )
    end

    recipes.all?(&:valid?) ? recipes : nil
  end
end
