class ViewsController < ApplicationController
  before_filter :authenticate_user!

  def create
    @movie = Movie.find(params[:movie_id])
    @view = current_user.views.create(movie: @movie)
    redirect_to @movie
  end

  def destroy
    @movie = Movie.find(params[:movie_id])
    @view = current_user.views.find(params[:id])
    if @view.destroy
      redirect_to @movie, notice: "You haven't watch this movie yet!"
    else
      redirect_to @movie, alert: "Oops, something went wrong"
    end
  end
end
