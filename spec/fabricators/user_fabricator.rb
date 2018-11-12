Fabricator(:user) do
  username { Faker:: Internet.user_name }
  password { Faker::Internet.password }
  email { Faker::Internet.email }
end

Fabricator(:admin, from: :user) do
  role "admin"
end