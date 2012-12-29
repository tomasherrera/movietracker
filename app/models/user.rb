class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :full_name, :email, :password, :password_confirmation, :remember_me

  has_many :checkins
  has_many :views
  has_many :movies, through: :checkins

  has_many :ratings
  has_many :rated_movies, through: :ratings, source: :movies
  has_many :viewed_movies, through: :views, source: :movie

  def self.recommended_movies user
    recommended_movies = []
    user.viewed_movies.each do |viewed_movie|
      recommended_movies.concat(viewed_movie.find_related_tags)
    end
    # sorting by rating is missing due to Edgar's changes hasn't been merged yet
    recommended_movies.take(5)
  end
end
