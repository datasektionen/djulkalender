require_relative '../unit_helper'

def cleanup
  Submission.delete
  Question.delete
  Person.delete
end

describe "QuestionStatus" do
  it "takes two parameters" do
    lambda { QuestionStatus.new }.must_raise ArgumentError
    lambda { QuestionStatus.new({}) }.must_raise ArgumentError
    QuestionStatus.new({},{}).must_be_instance_of QuestionStatus
  end

  describe "status" do
    it "is unavailable when no questions are published" do
      cleanup
      q = Fabricate :question, publish_date: Date.today + 1
      u = Fabricate :person

      qs = QuestionStatus.new(q,u)

      qs.status.must_equal "unavailable"
    end

    it "is available if it's the first question and it's published" do
      cleanup

      q = Fabricate :question, publish_date: Date.today - 1
      u = Fabricate :person


      qs = QuestionStatus.new(q,u)

      assert q.published?
      qs.status.must_equal "available"
    end

    describe "with previous questions" do
      before do
        Submission.delete
        Question.delete
        Person.delete
      end

      it "is available if all the previous questions are done and the current one is published" do
        oq = Fabricate :question, publish_date: Date.today - 1
        u = Fabricate :person
        a = Fabricate :submission, answer: oq.answer, person_id: u.id, question: oq


        q = Fabricate :question


        qs = QuestionStatus.new(q,u)

        assert oq.correctly_answered_by?(u)
        assert q.published?
        assert u.has_unlocked?(q)
        qs.status.must_equal "available"
      end
    end

    it "is done if it's the first question and the user has a correct answer" do
      cleanup
      q = Fabricate :question, publish_date: Date.today - 1
      u = Fabricate :person
      a = Fabricate :submission, answer: q.answer, person_id: u.id, question: q

      assert_equal a.person.id, u.id
      assert a.correct

      qs = QuestionStatus.new(q,u)

      assert q.correctly_answered_by?(u)
      qs.status.must_equal "done"
    end
  end
end
