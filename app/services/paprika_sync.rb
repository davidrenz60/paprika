class PaprikaSync
  attr_reader :error_message, :recipes_data, :uids

  def initialize
    @recipes_data = client.recipes_data
    @uids = @recipes_data.map { |data| data["uid"] }
  rescue PaprikaApi::Error => e
    @status = :error
    @error_message = e.message
  end

  def call
    update_categories
    delete_old_recipes
    save_new_recipes
    update_recipes
    @status = :success
    self
  rescue ActiveRecord::RecordInvalid => e
    @status = :error
    @error_message = e.message
    self
  end

  def successful?
    @status == :success
  end

  def error?
    @status == :error
  end

  def update_categories
    client.categories.each do |category|
      Category.create!(
        name: category["name"],
        uid: category["uid"]
        )
    end
  end

  def parse_image_url(url)
    return nil if url.blank?
    match = url.match(/http.+.jpg/)

    match ? match[0] : url
  end

  def save_new_recipes
    current_uids = Recipe.uids

    Recipe.transaction do
      uids.each do |uid|
        next if current_uids.include?(uid)
        recipe_data = client.recipe(uid)
        Recipe.create!(
          name: recipe_data["name"],
          rating: recipe_data["rating"],
          ingredients: recipe_data["ingredients"],
          directions: recipe_data["directions"],
          photo_url: parse_image_url(recipe_data["photo_url"]),
          created: recipe_data["created"],
          uid: recipe_data["uid"],
          token: recipe_data["token"]
        )
      end
    end
  end

  def client
    @client ||= PaprikaApi::Client.new(ENV["paprika_email"], ENV["paprika_password"])
  end

  def delete_old_recipes
    Recipe.delete_not_in(@uids)
  end

  def update_recipes
    Recipe.transaction do
      recipes_data.each do |data|
        recipe = Recipe.find_by(uid: data["uid"])
        next if recipe.token == data["token"]
        recipe_data = client.recipe(recipe.uid)

        recipe.update!(
          name: recipe_data["name"],
          rating: recipe_data["rating"],
          ingredients: recipe_data["ingredients"],
          directions: recipe_data["directions"],
          photo_url: parse_image_url(recipe_data["photo_url"]),
          created: recipe_data["created"],
          uid: recipe_data["uid"],
          token: recipe_data["token"]
        )
      end
    end
  end
end
