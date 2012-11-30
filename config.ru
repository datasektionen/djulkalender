#!/usr/bin/env rackup
# encoding: utf-8

# This file can be used to start Padrino,
# just execute it from the command line.

require 'sinatra/flash'
require 'slim'
require 'thin'
require "warden"
require 'omniauth-cas'

require File.dirname(__FILE__) + '/boot.rb'

# use Clogger, format: Clogger::Format::Combined, path: "#{SINATRA_ROOT}/log/#{SINATRA_ENV}.log"
use Rack::MethodOverride
use Rack::Session::Cookie

use OmniAuth::Builder do
  provider :cas, :host => "login.kth.se", :ssl => true
end

Warden::Manager.serialize_into_session {|user| user.id }
Warden::Manager.serialize_from_session {|id| User[id] }

use Warden::Manager do |manager|
  manager.failure_app = App::Sessions
end

map "/auth" do
  run App::Sessions
end

map "/" do
  run App::Main
end

map "/luckor" do
  run App::Questions
end

map "/admin" do
  run App::Admin::Dashboard
end

map "/admin/people" do
  run App::Admin::People
end

map "/admin/questions" do
  run App::Admin::Questions
end
