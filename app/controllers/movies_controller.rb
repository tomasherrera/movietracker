class MoviesController < ApplicationController
  def index
    if params[:tag]
      @movies = Movie.tagged_with(params[:tag])
    else
      @movies = Movie.search(params[:search], params[:type])
    end
  end

  def show
    @movie = Movie.find(params[:id])
    @checkin = current_user.checkins.
      where(movie_id: @movie.id).first if user_signed_in?
  end
end
