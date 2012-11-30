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

  def label_class
    case status
    when "available"
      "label-warning"
    when "unavailable"
      "label-inverse"
    when "locked"
      "label-info"
    when "done"
      "label-success"
    end
  end
end
