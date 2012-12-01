require_relative 'base'
module App
  module Admin
    class Dashboard < Base
      get "/" do
        slim :'admin/dashboard', layout: :admin
      end

      get "/progress" do
        @progress = Person.progress
        @people_without_correct_answers = Person.count - @progress.count

        slim :'admin/progress', layout: :admin
      end
    end
  end
end
