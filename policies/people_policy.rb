class PeoplePolicy < Struct.new(:user, :person)
  def create?
    user.admin?
  end
end
