source :rubygems

gem 'rake'

gem 'sinatra', require: "sinatra/base", require: false
gem 'sinatra-flash', require: false
gem 'clogger', require: false
gem 'thin', require: false

gem 'warden', require: false
gem 'omniauth-cas', require: false
gem 'ldap_lookup', :git => 'https://github.com/Frost/ldap_lookup.git'

gem 'slim', require: false

gem 'sequel'
gem 'sqlite3'

group :test do
  gem 'test-unit'
  gem 'rack-test', require: "rack/test"
  gem 'minitest'
  
  gem 'capybara'
  gem 'capybara-webkit', require: false
  gem 'capybara_minitest_spec'

  gem 'fabrication', require: false
  gem 'faker', require: false

  gem 'launchy', require: false
end

