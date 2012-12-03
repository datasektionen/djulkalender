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

  one_to_many :correct_submissions, :class => :Submission do |cs|
    cs.where(correct: true)
  end

  one_to_many :incorrect_answers, :class => :Submission do |ia|
    ia.where(correct: false).group_and_count(:answer).select_append(:id, :person_id).order(:count).reverse
  end

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

  def self.published
    where{ publish_date <= TZInfo::Timezone.get("Europe/Stockholm").now.to_date}
  end

  def average_incorrect_submissions
   (submissions_from_people_with_correct_submissions.count.to_f / people_with_correct_submissions.count.to_f).tap {|average|
     return average.nan? ? 0 : "%0.2f" % average
   }
  rescue ZeroDivisionError => e
    0
  end

  def people_with_correct_submissions
    Person.where(id: correct_submissions_dataset.map(&:person_id))
  end

  def submissions_from_people_with_correct_submissions
    submissions_dataset.where(person_id: people_with_correct_submissions.map(&:id))
  end
end
