module App
  module Admin
    class Questions < Base
      # list questions
      get "/" do
        @questions = Question.all
        slim :'questions/index', layout: :admin
      end

      # show question
      get "/:id" do |id|
        @question = Question[id]
        slim :'questions/show', layout: :admin
      end

      get "/:id/edit" do |id|
        @question = Question[id]
        slim :'questions/edit'
      end

      put "/:id" do |id|
        @question = Question[id]
        if @question.update(params["question"])
          redirect to("/")
        else
          slim :'questions/edit'
        end
      end
    end
  end
end
