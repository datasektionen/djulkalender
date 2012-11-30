DB.create_table? :questions do
  primary_key :id
  String :title, null: false
  String :question_text, null: false
  String :answer, null: false
  Date   :publish_date, null: false
end

class Question < Sequel::Model
  plugin :validation_helpers

  one_to_many :submissions

  def validate
    super
    validates_presence [:question_text, :answer, :publish_date]
  end

  def status
    if publish_date > Date.today
      "not available yet"
    elsif locked?
      "locked"
    elsif correctly_answered?
      "done"
    else
      "available"
    end
  end
end
