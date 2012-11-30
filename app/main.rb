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
      answer = Submission.new

      answer.set_only({
        person_id: @current_user.id,
        question_id: @question.id,
        answer: params["answer"]
      }, :person_id, :question_id, :answer)

      if answer.valid?
        answer.save
        redirect to("/")
      else
        puts answer.inspect
        puts answer.errors
        status = QuestionStatus.new(@question, @current_user).status
        slim :"questions/#{status}"
      end
    end
  end
end

