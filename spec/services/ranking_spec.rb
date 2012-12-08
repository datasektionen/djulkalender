require_relative '../unit_helper'

describe Ranking do
  let(:p1) { Fabricate :person }
  let(:p2) { Fabricate :person }
  let(:q1) { Fabricate :question }
  let(:q2) { Fabricate :question }

  before do 
    Submission.delete
    Question.delete
    Person.delete
  end
  
  after do 
    Submission.delete
    Question.delete
    Person.delete
  end

  it "contains people with correct solutions" do
    s1_1 = Submission.create(person_id: p1.id, question_id: q1.id, answer: q1.answer)
    s1_1 = Submission.create(person_id: p1.id, question_id: q1.id, answer: "aoeuaoeuaoeu")

    people = Ranking.new.rank_people

    assert people.all.find {|p| p[:id] == p1.id }
  end

  it "contains people with no correct solutions" do
    s1_1 = Submission.create(person_id: p1.id, question_id: q1.id, answer: "aoeuaoeuaoeu")

    people = Ranking.new.rank_people

    assert people.all.find {|p| p[:id] == p1.id }
  end

  it "contains people with no incorrect solutions" do
    s1_1 = Submission.create(person_id: p1.id, question_id: q1.id, answer: q1.answer)

    people = Ranking.new.rank_people
    people.count.must_equal 1

    assert people.all.find {|p| p[:id] == p1.id }
  end

  it "ranks people with more correct solutions higher" do
    s2_1 = Submission.create(person_id: p2.id, question_id: q1.id, answer: q1.answer)
    s2_2 = Submission.create(person_id: p2.id, question_id: q2.id, answer: q1.answer)

    s1_1 = Submission.create(person_id: p1.id, question_id: q1.id, answer: q1.answer)

    people = Ranking.new.rank_people
    
    people.count.must_equal 2
    people.first[:id].must_equal p2.id
    people.to_a.last[:id].must_equal p1.id
  end

  it "filters out admin users" do
    p1.role = "admin"
    p1.save

    people = Ranking.new.rank_people
    
    assert_nil people.find {|p| p[:id] == p1.id }
  end
end
