module App
  class People < Sinatra::Base
    enable :logging

    set :root, File.dirname(__FILE__) + "/.."

    helpers do
      def submission_timestamp(timestamp)
        timestamp ? TZInfo::Timezone.get("Europe/Stockholm").utc_to_local(timestamp).strftime("%Y-%m-%d %H:%M") : "-"
      end

      def question_number_from_date(date)
        date ? Date.parse(date).day : '-'
      end
    end

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

