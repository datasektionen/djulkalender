# encoding: utf-8
module App
  module Admin
    class Base < Sinatra::Base
      set :root, File.dirname(__FILE__)+ "/../../"
      set :method_override, true

      before do
        env["warden"].authenticate!
        @current_user = env["warden"].user

        unless @current_user.admin?
          halt 403
        end
      end
    end
  end
end
