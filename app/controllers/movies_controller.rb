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
    if user_signed_in?
      @checkin = current_user.checkins.
        where(movie_id: @movie.id).first
      @view = current_user.views.where(movie_id: @movie.id).first
      @rating = current_user.ratings.find_or_initialize_by_movie_id(@movie.id)
    end
  end
end
