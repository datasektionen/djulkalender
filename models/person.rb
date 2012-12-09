DB.create_table? :people do
  primary_key :id
  String :ugid, null: false, unique: true
  String :first_name, null: false
  String :last_name, null: false
  String :role, null: false, default: ""
  String :username, null: false, default: ""
end

class Person < Sequel::Model
  include LDAPLookup::Importable
  plugin :validation_helpers

  one_to_many :submissions
  one_to_many :correct_submissions, :class => :Submission do |cs|
    cs.where(correct: true)
  end

  def validate
    super
    validates_presence [:ugid, :first_name, :last_name]
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
    previous_question = Question[question.id - 1]

    return previous_question.nil? || question.old? || previous_question.correctly_answered_by?(self)
  end

  def admin?
    role == 'admin'
  end

  def self.progress
    Person.left_outer_join(:submissions, :person_id => :id).
      where(:correct => true).
      group_and_count(:person_id).
      select_append(:first_name, :last_name).
      order(:count).reverse
  end
end

