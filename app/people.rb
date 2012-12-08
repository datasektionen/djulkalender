module App
  class People < Sinatra::Base
    enable :logging

    set :root, File.dirname(__FILE__) + "/.."

    before do
      env["warden"].authenticate!
      @current_user = env["warden"].user
    end

    get "/" do
      @people = Ranking.new.rank_people
      slim :"people/ranking"
    end

    get "/profile" do
      redirect to("/people/#{@current_user.username}")
    end

    get "/:username" do |username|
      @person = Person.where(username: username).first
      slim :"people/profile"
    end
  end
end

