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
  end
end
