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

    get "/profile" do
      redirect to("/people/#{@current_user.username}")
    end

    get "/people/:username" do |username|
      @person = Person.where(username: username).first
      slim :"people/profile"
    end

    get "/:id" do |id|
      @question = Question[id]
      status = QuestionStatus.new(@question, @current_user).status
      slim :"questions/#{status}"
    end

    post "/answer/:id" do |id|
      @question = Question[id]
      success, answer = SubmissionCreator.new(@question, @current_user).create!(params)

      status = QuestionStatus.new(@question, @current_user).status

      @error = "Fel svar!" if !success || answer.incorrect?

      slim :"questions/#{status}", locals: { error: "Fel svar!", hide_question_text: true }
    end

  end
end

