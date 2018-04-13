Fabricator(:user) do
  username { Faker:: Internet.user_name }
  password { Faker::Internet.password }
end

Fabricator(:admin, from: :user) do
  role "admin"
end