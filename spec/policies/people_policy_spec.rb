require_relative '../unit_helper.rb'
require 'ostruct'

describe PeoplePolicy do
  describe "current_user is admin" do
    it "allows creation" do
      admin_user = OpenStruct.new(admin?: true)
      pp = PeoplePolicy.new(admin_user, OpenStruct.new) 

      assert pp.create?
    end
  end
end
