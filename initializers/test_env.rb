require_relative 'base'

require 'fabrication'
require 'faker'

require 'minitest/autorun'
require 'minitest/spec'
require 'minitest/pride'
require 'rack/test'

class MiniTest::Spec
  include Rack::Test::Methods
end

# class MiniTest::Unit::TestCase
#   alias_method :_original_run, :run
# 
#   def run(*args, &block)
#     result = nil
#     Sequel::Model.db.transaction(:rollback => :always) do
#       result = _original_run(*args, &block)
#     end
#     result
#   end
# end

