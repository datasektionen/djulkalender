require 'sinatra'
# require sub-apps
Dir.glob("#{File.dirname(__FILE__)}/../app/**/*.rb").each do |app|
  require_relative app
end


