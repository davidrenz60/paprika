Fabricator(:recipe) do
  name { Faker::Food.dish }
  rating { Faker::Number.between(1, 5) }
  ingredients { Faker::Lorem.paragraph }
  directions { Faker::Lorem.paragraph }
  created { Faker::Date.backward(20) }
  uid { Faker::Lorem.characters(15) }
  token { Faker::Lorem.characters(15) }
end