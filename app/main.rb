module App
  class Main < Sinatra::Base
    enable :logging

    set :root, File.dirname(__FILE__) + "/.."

    before do
      env["warden"].authenticate!
      @current_user = env["warden"].user
    end

    get "/" do
      @questions = Question.all.shuffle
      slim :start_page
    end

    get "/:id" do |id|
      @question = Question[id]
      status = QuestionStatus.new(@question, @current_user).status
      slim :"questions/#{status}"
    end

    post "/answer/:id" do |id|
      @question = Question[id]
      result, answer = SubmissionCreator.new(@question, @current_user).create!(params)

      if result
        redirect to("/")
      else
        status = QuestionStatus.new(@question, @current_user).status
        slim :"questions/#{status}"
      end
    end
  end
end

