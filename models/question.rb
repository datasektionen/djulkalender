require 'tzinfo'

DB.create_table? :questions do
  primary_key :id
  String :title, null: false
  String :question_text, null: false
  String :done_text, null: false
  String :answer, null: false
  String :hint, null: false
  Date   :publish_date, null: false
end

class Question < Sequel::Model
  plugin :validation_helpers

  one_to_many :submissions

  def validate
    super
    validates_presence [:question_text, :answer, :publish_date]
  end

  def published?
    publish_date <= today
  end

  def correctly_answered_by?(user)
    Submission.where(person_id: user.id).where(correct: true).where("question_id = #{id}").any?
  end

  def today
    TZInfo::Timezone.get("Europe/Stockholm").now.to_date
  end
end
