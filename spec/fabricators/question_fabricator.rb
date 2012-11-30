Fabricator(:question) do
  title                  { "foo" }
  question_text          { "foo" }
  done_text              { "foo" }
  hint                   { "foo" }
  answer                 { "foo" }
  publish_date           { Date.today }
end
