module PaprikaSync
  extend ActiveSupport::Concern

  class_methods do
    def sync
      client = PaprikaApiClient.new(ENV["paprika_email"], ENV["paprika_password"])
      recipes_data = client.recipes_data
      uids = recipes_data.map { |r| r["uid"] }

      delete_old_recipes(uids)
      add_new_recipes(uids)
      update_recipes(recipes_data)
    end

    def delete_old_recipes(uids)
      all.reject { |recipe| uids.include?(recipe.uid) }.each(&:delete)
    end

    def add_new_recipes(uids)
      saved_uids = all.map(&:uid)

      uids.each do |uid|
        if !saved_uids.include?(uid)
          recipe_data = fetch(uid)
          recipe = new(
            name: recipe_data["name"],
            rating: recipe_data["rating"],
            ingredients: recipe_data["ingredients"],
            directions: recipe_data["directions"],
            photo_url: parse_image_url(recipe_data["photo_url"]),
            created: recipe_data["created"],
            uid: recipe_data["uid"],
            token: recipe_data["token"]
          )

          recipe.save
        end
      end
    end

    def update_recipes(recipes_data)
      recipes_data.each do |data|
        recipe = Recipe.find_by(uid: data["uid"])
        if recipe.token != data["token"]
          recipe_data = fetch(recipe.uid)

          r = recipe.update(
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

    def fetch(uid)
      client = PaprikaApiClient.new(ENV["paprika_email"], ENV["paprika_password"])
      client.recipe(uid)
    end

    def self.parse_image_url(url)
      return nil if url.blank?
      match = url.match(/http.+.jpg/)

      match ? match[0] : url
    end
  end
end