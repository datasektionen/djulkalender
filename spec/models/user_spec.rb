require_relative '../unit_helper.rb'

describe User do
  let(:it) { User.new }
  it "is admin if role is 'admin'" do
    it.role = "admin"

    assert it.admin?
  end
end
