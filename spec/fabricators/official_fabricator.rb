Fabricator(:official) do
  name                  { Faker::Name.name }
  email                 { Faker::Internet.email }
  description           { "" }
end
