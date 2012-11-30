class SubmissionCreator
  def initialize(question, person)
    @question, @person = question, person
  end

  def create!(params)
    status = QuestionStatus.new(@question, @person).status
    if status == "available"
      answer = Submission.new

      answer.set_only({
        person_id: @person.id,
        question_id: @question.id,
        answer: params["answer"]
      }, :person_id, :question_id, :answer)

      if answer.valid? && answer.save
        return true, answer
      end
    else
      return false, answer
    end
  end
end
