module App
  class Questions < Sinatra::Base
    set :root, File.dirname(__FILE__)+ "/../"
    set :method_override, true

    before do
      env["warden"].authenticate!
      @current_user = env["warden"].user
    end

    # list questions
    get "/" do
      "luckor..."  
    end

    # show question
    get "/:id" do |id|
    end
  end
end
