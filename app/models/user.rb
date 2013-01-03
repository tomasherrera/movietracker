class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :full_name, :email, :password, :password_confirmation, :remember_me

  has_many :checkins
  has_many :views
  has_many :movies, through: :checkins

  has_many :ratings

  has_many :rated_movies, through: :ratings, source: :movie
  has_many :viewed_movies, through: :views, source: :movie

  def self.recommended_movies user
    recommended_movies = user.viewed_movies.inject([]) do |movies, element| 
      movies.concat(element.find_related_tags)
    end
    recommended_movies -= user.viewed_movies 
    recommended_movies.take(5).sort{|x,y| y.average_rating <=> x.average_rating }
  end

end
