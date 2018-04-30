require 'rails_helper'

describe Recipe do
  describe '.parse_image_url' do
    let(:url) { "http://www.amazon.com/photo.jpg?param=something" }
    let(:parsed_url) { "http://www.amazon.com/photo.jpg" }

    it "removes everything after .jpg in the url" do
      expect(Recipe.parse_image_url(url)).to eq(parsed_url)
    end

    it "returns nil when a nil value is given" do
      expect(Recipe.parse_image_url(nil)).to eq(nil)
    end

    it "returns nil for an empty string" do
      expect(Recipe.parse_image_url("")).to eq(nil)
    end

    it "returns a valid local .jpg file" do
      expect(Recipe.parse_image_url("placeholder.jpg")).to eq("placeholder.jpg")
    end
  end

  describe '.sync' do
    it "adds a new recipe to the database" do
      recipes_data = [
        { "uid" => "123",
          "token" => "abc" },
        { "uid" => "456",
          "token" => "def" },
        { "uid" => "789",
          "token" => "ghi" }
      ]

      recipe1 = Fabricate(:recipe, "uid" => "123", "token" => "abc")
      recipe2 = Fabricate(:recipe, "uid" => "456", "token" => "def")
      recipe3 = Fabricate.attributes_for(:recipe, "uid" => "789", "token" => "ghi")

      expect_any_instance_of(PaprikaApiClient).to receive(:recipe).with("789").and_return(recipe3)
      expect_any_instance_of(PaprikaApiClient).to receive(:recipes_data).and_return(recipes_data)
      Recipe.sync
      expect(Recipe.count).to eq(3)
    end

    it "deletes a recipe from the database"  do
      recipe1 = Fabricate(:recipe, "uid" => "123", "token" => "abc")
      recipe2 = Fabricate(:recipe, "uid" => "456", "token" => "def")
      recipe3 = Fabricate(:recipe, "uid" => "789", "token" => "ghi")

      recipes_data = [
        { "uid" => "123",
          "token" => "abc" },
        { "uid" => "456",
          "token" => "def" }
      ]

      expect_any_instance_of(PaprikaApiClient).to receive(:recipes_data).and_return(recipes_data)\

      Recipe.sync
      expect(Recipe.count).to eq(2)
    end

    it "updates a recipe" do
      recipe1 = Fabricate(:recipe, "uid" => "123", "token" => "abc")
      recipe2 = Fabricate(:recipe, "uid" => "456", "token" => "def")
      recipe3 = Fabricate(:recipe, "uid" => "789", "token" => "ghi")

      updated_recipe = Fabricate.attributes_for(:recipe, "uid" => "789", "token" => "jkl")

      recipes_data = [
        { "uid" => "123",
          "token" => "abc" },
        { "uid" => "456",
          "token" => "def" },
        { "uid" => "789",
          "token" => "jkl" }
        ]

      expect_any_instance_of(PaprikaApiClient).to receive(:recipe).with("789").and_return(updated_recipe)
      expect_any_instance_of(PaprikaApiClient).to receive(:recipes_data).and_return(recipes_data)
      Recipe.sync
      expect(Recipe.find_by("uid" => recipe3.uid).name).to eq(updated_recipe[:name])
    end
  end
end
