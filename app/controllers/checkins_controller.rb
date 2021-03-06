class CheckinsController < ApplicationController
  before_filter :authenticate_user!

  def create
    @movie = Movie.find(params[:movie_id])
    @checkin = current_user.checkins.create(movie: @movie)
    redirect_to @movie
  end

  def destroy
    @movie = Movie.find(params[:movie_id])
    @checkin = current_user.checkins.find(params[:id])
    if @checkin.destroy
      redirect_to @movie, notice: "This movie is not on your watchlist anymore"
    else
      redirect_to @movie, alert: "Oops, something went wrong"
    end
  end
end
