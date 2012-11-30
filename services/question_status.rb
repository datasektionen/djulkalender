class QuestionStatus
  def initialize(question, user)
    @question, @user = question, user
  end

  def status
    if @question.published?
      if @user.has_unlocked?(@question)
        if @question.correctly_answered_by?(@user)
          "done"
        else
          "available"
        end
      else
        "locked"
      end
    else
      "unavailable"
    end
  end
end
