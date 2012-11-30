Fabricator(:submission) do
  person
  question
  answered_at   { Time.now }
  answer        { "herp derp" }
  correct       { false }
end

Fabricator(:correct_submission, from: :submission) do
  person
  question
  correct   { true }
end
