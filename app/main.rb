module App
  class Main < Sinatra::Base
    enable :logging

    set :root, File.dirname(__FILE__) + "/.."

    get "/" do
      @current_user = env["warden"].user
      @questions = Question.all.shuffle
      slim :start_page
    end
  end
end

