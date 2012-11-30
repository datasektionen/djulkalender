SINATRA_ENV = 'test' unless defined?(SINATRA_ENV)

require_relative '../initializers/test_env'
require_relative '../initializers/models'
require_relative '../initializers/policies'

