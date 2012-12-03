require_relative '../unit_helper'

describe Submission do
  let(:it) { Submission.new }
  it 'can be created' do
    it.must_be_instance_of(Submission)
  end

  it "is case insensitive" do
    u = Fabricate :person
    q = Fabricate :question

    s = Submission.new(person_id: u.id, question_id: q.id)

    s.answer = q.answer.upcase

    s.valid?

    assert s.correct?

    s.answer = q.answer.downcase
    s.correct = false

    s.valid?

    assert s.correct?
  end

end

