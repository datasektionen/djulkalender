require_relative 'base'
module App
  module Admin
    class Dashboard < Base
      # list questions
      get "/" do
      end

      # show question
      get "/:id" do |id|
      end
    end
  end
end
