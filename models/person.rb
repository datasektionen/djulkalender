DB.create_table? :people do
  primary_key :id
  String :ugid, null: false, unique: true
  String :first_name, null: false
  String :last_name, null: false
  String :role, null: false, default: ""
  String :email, null: false, unique: true
end

class Person < Sequel::Model
  include LDAPLookup::Importable
  plugin :validation_helpers

  one_to_many :submissions

  def validate
    super
    validates_presence [:ugid, :first_name, :last_name, :email]
    validates_unique :ugid
    validates_format /^[A-Za-z]*$/, :role
  end

  def self.find_or_create_from_ldap(ugid)
    person = Person.first(ugid: ugid)

    unless person
      person = Person.from_ldap(ugid: ugid)
      person.save
    end
    
    person
  end

  def name
    [first_name, last_name].join(' ')
  end

  def to_s
    name
  end

  def has_unlocked?(question)
    previous_questions = Question.where("id < #{question.id}").map(&:id)
    correct_answers = Submission.where(question_id: previous_questions).where(person_id: id).where(correct: true).map(&:question_id)

    return correct_answers == previous_questions
  end
end

