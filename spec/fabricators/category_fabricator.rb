Fabricator(:category) do
  name { Faker::Lorem.word }
  uid { Faker::Lorem.characters(15) }
end