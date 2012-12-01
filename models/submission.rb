DB.create_table? :submissions do
  primary_key :id
  foreign_key :person_id, :people
  foreign_key :question_id, :questions
  DateTime :answered_at, null: false
  String :answer, null: false
  Boolean :correct, null: false, default: false
end

class Submission < Sequel::Model
  plugin :validation_helpers

  many_to_one :question
  many_to_one :person

  def validate
    super
    self.correct = answer == question.answer
    self.answered_at = Time.now
    validates_presence [:answer, :person_id, :question, :answered_at]
  end

  def correct?
    correct
  end

  def incorrect?
    !correct
  end
end
