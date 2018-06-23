require 'rails_helper'

describe Recipe do
  describe ".delete_not_in" do
    context "a recipe was removed from the uid list" do
      let!(:recipe1) { Fabricate(:recipe, uid: "123") }
      let!(:recipe2) { Fabricate(:recipe, uid: "456") }
      let!(:recipe3) { Fabricate(:recipe, uid: "789") }
      let(:uids) { ["123", "456"] }

      it "deletes the recipe" do
        Recipe.delete_not_in(uids)
        expect(Recipe.count).to eq(2)
        expect(Recipe.all.map(&:uid)).to eq(uids)
      end
    end
  end
end
