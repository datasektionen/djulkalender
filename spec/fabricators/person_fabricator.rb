Fabricator(:person) do
  first_name            { Faker::Name.first_name }
  last_name             { Faker::Name.last_name }
  ugid                  { Faker::Base.bothify("u1???###") }
  role                  { "" }
end

Fabricator(:admin, from: :person) do
  role { "admin" }
end

