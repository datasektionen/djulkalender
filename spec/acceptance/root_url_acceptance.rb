require_relative "../acceptance_helper.rb"

describe "Test root url" do
  it "should render the start page" do
    visit '/'

    page.must_have_content "Logga in"
  end
end

