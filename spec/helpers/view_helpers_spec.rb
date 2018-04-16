require 'rails_helper'

describe ApplicationHelper do
  describe '#format_ingredients' do
  end

  it "returns a string with the quantities wrapped in strong tags" do
    ingredients = "1 cup salt\n1 cup sugar\n1 cup yellow mustard"
    result = "<p><strong>1</strong> cup salt\n<br /><strong>1</strong> cup sugar\n<br /><strong>1</strong> cup yellow mustard</p>"
    expect(format_ingredients ingredients).to eq(result)
  end

  it "handles numbers with more than one digit" do
    ingredients = "12 cup salt\n300 cup sugar\n2 cup yellow mustard"
    result = "<p><strong>12</strong> cup salt\n<br /><strong>300</strong> cup sugar\n<br /><strong>2</strong> cup yellow mustard</p>"
    expect(format_ingredients ingredients).to eq(result)
  end

  it "handles numbers written as fractions" do
    ingredients = "1/2 cup salt\n3/4 cup sugar\n5/8 cup yellow mustard"
    result = "<p><strong>1/2</strong> cup salt\n<br /><strong>3/4</strong> cup sugar\n<br /><strong>5/8</strong> cup yellow mustard</p>"
    expect(format_ingredients ingredients).to eq(result)
  end

  it "handles a whole number plus a fraction" do
    ingredients = "1 1/2 cup salt\n15 3/4 cup sugar\n5/8 cup yellow mustard"
    result = "<p><strong>1 1/2</strong> cup salt\n<br /><strong>15 3/4</strong> cup sugar\n<br /><strong>5/8</strong> cup yellow mustard</p>"
    expect(format_ingredients ingredients).to eq(result)
  end

  it "handles decimal points" do
    ingredients = "1.5 cup salt\n12.50 cup sugar\n4.0 cup yellow mustard"
    result = "<p><strong>1.5</strong> cup salt\n<br /><strong>12.50</strong> cup sugar\n<br /><strong>4.0</strong> cup yellow mustard</p>"
    expect(format_ingredients ingredients).to eq(result)
  end
end
