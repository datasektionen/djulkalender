# Defines our constants
SINATRA_ENV  = ENV['SINATRA_ENV'] ||= ENV['RACK_ENV'] ||= 'development'  unless defined?(SINATRA_ENV)
SINATRA_ROOT = File.expand_path('..', __FILE__) unless defined?(SINATRA_ROOT)

require_relative 'initializers/base'
require_relative 'initializers/models'
require_relative 'initializers/services'
require_relative 'initializers/sub_apps'

