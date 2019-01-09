Fabricator(:rating) do
  rating { Faker::Number.between(1, 5) }
  user
end