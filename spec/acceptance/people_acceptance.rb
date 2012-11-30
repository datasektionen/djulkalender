# encoding: utf-8
# require_relative "../acceptance_helper.rb"

SINATRA_ENV = 'test'
require_relative '../../initializers/test_env'
require_relative "../../app/people"
require 'capybara'
require 'capybara/dsl'
require 'capybara/webkit'
require 'capybara_minitest_spec'

Capybara.app = App::People
Capybara.default_driver = :webkit

class MiniTest::Spec
  include Capybara::DSL
  include Warden::Test::Helpers
  include Rack::Test::Methods

  before do
    logout
  end

  after do
    Warden.test_reset!
  end
end


class Capybara::Session
  def params
    Hash[*URI.parse(current_url).query.split(/\?|=|&/)]
  end
end

describe "People" do
  let(:current_user) { Fabricate :person }

  describe "admin" do
    let(:current_user) { Fabricate :admin }

    it "can create people" do
      new_person = Fabricate.build :person

      login_as current_user

      post '/people', person: new_person.values

      puts last_response.status

      assert last_response.ok?
    end
  end

end

