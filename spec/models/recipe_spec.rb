require 'rails_helper'

describe Recipe do
  it "updates the slug if the name is changed" do
    recipe = Fabricate(:recipe, name: "Pizza")
    recipe.update(name: "Barbecue Ribs")
    expect(recipe.slug).to eq("barbecue-ribs")
  end

  describe ".delete_not_in" do
    context "a recipe was removed from the uid list" do
      let!(:recipe1) { Fabricate(:recipe, uid: "123") }
      let!(:recipe2) { Fabricate(:recipe, uid: "456") }
      let!(:recipe3) { Fabricate(:recipe, uid: "789") }
      let(:uids) { ["123", "456"] }

      it "deletes the recipe" do
        Recipe.delete_not_in(uids)
        expect(Recipe.count).to eq(2)
        expect(Recipe.all.map(&:uid)).to match_array(uids)
      end
    end
  end

  describe "#update_average_rating" do
    context "when reviews are created" do
      let!(:recipe) { Fabricate(:recipe) }

      it "creates an average rating for the recipe" do
        Fabricate(:rating, rating: 3, recipe: recipe)
        expect(recipe.reload.average_rating).to eq("3.0")
      end

      it "rounds to the nearest 0.5 point" do
        Fabricate(:rating, rating: 2, recipe: recipe)
        Fabricate(:rating, rating: 5, recipe: recipe)
        Fabricate(:rating, rating: 4, recipe: recipe)
        expect(recipe.reload.average_rating).to eq("3.5")
      end
    end

    context "no ratings associated" do
      let!(:recipe) { Fabricate(:recipe) }

      it "returns nil" do
        recipe.update_average_rating
        expect(recipe.average_rating).to eq(nil)
      end

      it "keeps the average_rating column as nil" do
        expect(recipe.update_average_rating).to be_nil
      end
    end
  end
end
