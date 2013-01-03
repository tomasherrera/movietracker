require 'spec_helper'

describe ViewsController, "Routing" do
  it {{post: "/movies/1/views"}.should route_to(controller: "views",
                                                   action: "create",
                                                   movie_id: "1") }
  it {{delete: "/movies/1/views/1"}.should route_to(controller: "views",
                                                      action: "destroy",
                                                      id: "1",
                                                      movie_id: "1")}
end

describe ViewsController, "Actions" do
  render_views

  before do
    @user = FactoryGirl.create(:user)
    @movie = FactoryGirl.create(:movie)
  end

  describe "as an authenticated user" do

    before do     
      sign_in :user, @user
    end

    describe "on POST to #create" do

      it "should create a new view on the given movie by the current_user" do
        expect {
          post :create, movie_id: @movie.to_param
        }.to change(@user.reload.views, :count).by(1)
      end

      it "should redirect to the movie page" do
        post :create, movie_id: @movie.to_param
        should redirect_to(movie_path(@movie))
      end
    end

    describe "on DELETE to #destroy" do
      it "should delete an existing view for a given movie" do
        @view = FactoryGirl.create(:view, :user => @user, :movie=> @movie)
        expect {
          delete :destroy, movie_id: @movie.to_param, id: @view.to_param
        }.to change(@movie.reload.views, :count).by(-1)
      end
    end

  end

  describe "as a visitor" do
    describe "on DELETE to #destroy" do
      it "should redirect to the log in page" do
        post :create, movie_id: @movie.to_param
        should redirect_to(new_user_session_path)
      end
    end

    describe "on DELETE to #destroy" do
      it "should redirect to the log in page" do
        @view = FactoryGirl.create(:view, :user => @user, :movie=> @movie)
        delete :destroy, movie_id: @movie.to_param, id: @view.to_param
        should redirect_to(new_user_session_path)
      end
    end

  end
  
end