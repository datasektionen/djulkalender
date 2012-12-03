require_relative '../unit_helper'

describe Person do
  let(:it) { Person.new }
  it 'can be created' do
    it.must_be_instance_of(Person)
  end

  it "concatenates first and last name in #name" do
    it.name.must_equal "#{it.first_name} #{it.last_name}"
  end

  %w[ugid first_name last_name].each do |attribute|
    it "is invalid without #{attribute}" do
      it.valid?.must_equal false
      it.errors[attribute.to_sym].must_equal [ "is not present" ]
    end
  end

  describe "#current_offices" do
    it "returns all currently held offices"
  end

end

