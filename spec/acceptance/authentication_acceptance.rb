# encoding: utf-8
require_relative "../acceptance_helper.rb"

describe "Login" do
  let(:app) { App::People.new }
  let(:user) { Fabricate :person }
  it "redirects back to root url" do
    login_as user
    visit '/people'

    page.must_have_content("Lägg till person")
  end

  it "renders root url when not logged in" do
    visit '/people'

    page.wont_have_content(user.name)
  end
end

