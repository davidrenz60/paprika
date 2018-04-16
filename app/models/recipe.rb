class Recipe < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged
  before_save :default_values

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
        photo_url: parse_image_url(data["photo_url"]),
        created: data["created"],
        uid: data["uid"]
      )
    end

    if recipes.all?(&:valid?)
      # slug generates with before_validation callback, reset to nil
      recipes.each { |recipe| recipe.slug = nil }
      recipes
    else
      nil
    end
  end

  def self.parse_image_url(url)
    return nil if url.blank?
    url.match(/http.+.jpg/)[0]
  end

  private

  def default_values
    self.photo_url = 'placeholder.jpg' if self.photo_url.blank?
  end
end
