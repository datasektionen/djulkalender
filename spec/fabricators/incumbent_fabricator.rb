Fabricator(:incumbent) do
  start_date                  { Date.civil(Date.today.year, 1, 1) }
  end_date                 { Date.civil(Date.today.year, 12, 31)}
  person
  official
end
