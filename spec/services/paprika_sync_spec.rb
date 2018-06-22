require 'rails_helper'

describe PaprikaSync do
  describe "#initialize" do
    context "successful api call" do
      let(:recipes_data) do
        [{ "uid" => "123",
           "token" => "jkl" },
         { "uid" => "456",
           "token" => "mno" },
         { "uid" => "789",
           "token" => "ghi" }]
      end

      let(:uids) { ["123", "456", "789"] }

      before do
        expect_any_instance_of(PaprikaApi::Client).to receive(:recipes_data).and_return(recipes_data)
      end

      it "sets recipes_data" do
        expect(PaprikaSync.new.recipes_data).to eq(recipes_data)
      end

      it "sets uids" do
        expect(PaprikaSync.new.uids).to eq(uids)
      end
    end

    context "unsuccessful api call" do
      before do
        expect_any_instance_of(PaprikaApi::Client).to receive(:recipes_data).and_raise(PaprikaApi::Error)
      end

      let(:sync) { PaprikaSync.new }

      it "sets the error status" do
        expect(sync.successful?).to eq(false)
      end
    end
  end

  describe '#call' do
    context "with valid data" do
      let(:recipes_data) do
        [{ "uid" => "123",
           "token" => "jkl" }]
      end

      let(:uids) { ["123"] }

      let!(:recipe) { Fabricate(:recipe, "uid" => "123", "token" => "abc") }
      let(:sync) { PaprikaSync.new.call }

      it "sets a success status" do
        expect_any_instance_of(PaprikaApi::Client).to receive(:recipes_data).and_return(recipes_data)
        expect_any_instance_of(PaprikaApi::Client).to receive(:recipe).with("123").and_return(recipe)
        expect(sync.successful?).to eq true
      end
    end

    context "with invalid data" do
      let(:recipes_data) do
        [{ "uid" => "123",
           "token" => "jkl" }]
      end

      let(:recipe) { Fabricate.attributes_for(:recipe, "uid" => "123", "token" => "mno", "name" => nil) }

      let(:sync) { PaprikaSync.new.call }

      before do
        expect_any_instance_of(PaprikaApi::Client).to receive(:recipes_data).and_return(recipes_data)
        expect_any_instance_of(PaprikaApi::Client).to receive(:recipe).with("123").and_return(recipe)
      end

      it "sets an error status" do
        expect(sync.error?).to eq true
      end
      it "sets an error message" do
        expect(sync.error_message).not_to be_nil
      end
    end
  end

  describe "#update_recipes" do
    context "with valid updated recipe data" do
      let!(:recipe1) { Fabricate(:recipe, "uid" => "123", "token" => "abc") }
      let!(:recipe2) { Fabricate(:recipe, "uid" => "456", "token" => "def") }
      let!(:recipe3) { Fabricate(:recipe, "uid" => "789", "token" => "ghi") }

      let(:updated_recipe) { Fabricate.attributes_for(:recipe, "uid" => "789", "token" => "jkl") }

      let(:recipes_data) do
        [{ "uid" => "123",
           "token" => "abc" },
         { "uid" => "456",
           "token" => "def" },
         { "uid" => "789",
           "token" => "jkl" }]
      end

      before do
        expect_any_instance_of(PaprikaApi::Client).to receive(:recipe).with("789").and_return(updated_recipe)
        expect_any_instance_of(PaprikaApi::Client).to receive(:recipes_data).and_return(recipes_data)
        PaprikaSync.new.update_recipes
      end

      it "updates the recipe" do
        expect(Recipe.find_by("uid" => recipe3.uid).name).to eq(updated_recipe[:name])
      end
    end

    context "with invalid updated recipe data" do
      let!(:recipe1) { Fabricate(:recipe, "uid" => "123", "token" => "abc") }
      let!(:recipe2) { Fabricate(:recipe, "uid" => "456", "token" => "def") }
      let!(:recipe3) { Fabricate(:recipe, "uid" => "789", "token" => "ghi") }

      let(:updated_recipe1) { Fabricate.attributes_for(:recipe, "uid" => "123", "token" => "jkl", "name" => "pizza") }
      let(:updated_recipe2) { Fabricate.attributes_for(:recipe, "uid" => "456", "token" => "mno", "name" => nil) }

      let(:recipes_data) do
        [{ "uid" => "123",
           "token" => "jkl" },
         { "uid" => "456",
           "token" => "mno" },
         { "uid" => "789",
           "token" => "ghi" }]
      end

      before do
        allow_any_instance_of(PaprikaApi::Client).to receive(:recipe).with("123").and_return(updated_recipe1)
        allow_any_instance_of(PaprikaApi::Client).to receive(:recipe).with("456").and_return(updated_recipe2)
        allow_any_instance_of(PaprikaApi::Client).to receive(:recipes_data).and_return(recipes_data)
      end

      it "does not update any recipes" do
        PaprikaSync.new.update_recipes rescue nil

        expect(Recipe.find_by("uid" => recipe1.uid).name).to eq(recipe1.name)
        expect(Recipe.find_by("uid" => recipe2.uid).name).to eq(recipe2.name)
      end
    end
  end

  describe "#save_new_recipes" do
    context "with valid new recipe data" do
      let(:recipes_data) do
        [{ "uid" => "123",
           "token" => "abc" },
         { "uid" => "456",
           "token" => "def" },
         { "uid" => "789",
           "token" => "ghi" }]
      end

      let!(:recipe1) { Fabricate(:recipe, "uid" => "123", "token" => "abc") }
      let!(:recipe2) { Fabricate(:recipe, "uid" => "456", "token" => "def") }
      let!(:recipe_data) { Fabricate.attributes_for(:recipe, "uid" => "789", "token" => "ghi") }

      it "saves a new recipe" do
        expect_any_instance_of(PaprikaApi::Client).to receive(:recipe).with("789").and_return(recipe_data)
        expect_any_instance_of(PaprikaApi::Client).to receive(:recipes_data).and_return(recipes_data)
        PaprikaSync.new.save_new_recipes
        expect(Recipe.count).to eq(3)
      end
    end

    context "with invalid new recipe data" do
      let(:recipes_data) do
        [{ "uid" => "123",
           "token" => "abc" },
         { "uid" => "456",
           "token" => "def" },
         { "uid" => "789",
           "token" => "ghi" },
         { "uid" => "234",
           "token" => "jkl" }]
      end

      let!(:recipe1) { Fabricate(:recipe, "uid" => "123", "token" => "abc") }
      let!(:recipe2) { Fabricate(:recipe, "uid" => "456", "token" => "def") }
      let!(:recipe_data1) { Fabricate.attributes_for(:recipe, "uid" => "789", "token" => "ghi", "name" => "pizza") }
      let!(:recipe_data2) { Fabricate.attributes_for(:recipe, "uid" => "234", "token" => "jkl", "name" => nil) }

      before do
        expect_any_instance_of(PaprikaApi::Client).to receive(:recipe).with("789").and_return(recipe_data1)
        expect_any_instance_of(PaprikaApi::Client).to receive(:recipe).with("234").and_return(recipe_data2)
        expect_any_instance_of(PaprikaApi::Client).to receive(:recipes_data).and_return(recipes_data)
      end

      it "does not save any new recipes" do
        PaprikaSync.new.save_new_recipes rescue nil
        expect(Recipe.count).to eq(2)
      end
    end
  end

  describe "#update_categories" do
    context "with valid category data" do
      let(:category_data) do
        [{ "uid" => "123",
           "name" => "pizza" },
         { "uid" => "456",
           "token" => "pasta" }]
      end

      it "saves a new category" do
        expect_any_instance_of(PaprikaApi::Client).to receive(:categories).and_return(category_data)
        PaprikaSync.new.update_categories
        expect(Category.count).to eq(2)
      end
    end
  end

  describe '#parse_image_url' do
    let(:url) { "http://www.amazon.com/photo.jpg?param=something" }
    let(:parsed_url) { "http://www.amazon.com/photo.jpg" }

    it "removes everything after .jpg in the url" do
      expect(PaprikaSync.new.parse_image_url(url)).to eq(parsed_url)
    end

    it "returns nil when a nil value is given" do
      expect(PaprikaSync.new.parse_image_url(nil)).to eq(nil)
    end

    it "returns nil for an empty string" do
      expect(PaprikaSync.new.parse_image_url("")).to eq(nil)
    end

    it "returns a valid local .jpg file" do
      expect(PaprikaSync.new.parse_image_url("placeholder.jpg")).to eq("placeholder.jpg")
    end
  end
end
