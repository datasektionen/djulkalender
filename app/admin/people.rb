module App
  module Admin
    class People < Base
      get "/" do
        @people = Person.all
        slim :'people/index', layout: :admin
      end

      get "/new" do
        @person = Person.new
        slim :'people/new'
      end

      post "/" do
        @person = Person.new(params[:person])
        if @person.save
          redirect "/"
        else
          slim :'people/new'
        end
      end

      get "/:id/edit" do |id|
        @person = Person[id]
        slim :'people/edit'
      end

      put "/:id" do |id|
        @person = Person[id]
        if @person.update(params["person"])
          redirect to("/")
        else
          slim :'people/edit'
        end
      end

      delete "/:id" do |id|
        person = Person[id]
        if person != current_person && person.destroy
          flash[:notice] = 'Person was successfully destroyed.'
        else
          flash[:error] = 'Unable to destroy Person!'
        end
        redirect url(:people, :index)
      end
    end
  end
end
