class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :full_name, :email, :password, :password_confirmation, :remember_me

  has_many :checkins
  has_many :movies, through: :checkins

  def self.recommended_movies user    
    recommended_movies = {}
    movies_tags = []      
    valid_movies = Movie.all - user.movies #We only want to evaluate the movies that the user hasn't seen
    user.movies.each do |user_movie| #Put all the user's movie tags into an array called movie_tags
      movies_tags.concat(user_movie.tag_list)
    end
    movies_tags = movies_tags.uniq #Eliminate all the duplicated tags using the 'uniq' method
    valid_movies.each do |valid_movie|
      recommended_rate = 0 #We declare a variable that is going to hold the amount of tags that the user_movies have in common with the rest of the movies.
      valid_movie.tag_list.each do |tag|
        if movies_tags.include?(tag) #We ask if the tag that it's been passed from the valid_movies array is included in the users tags and if so to increment the recomended rate by one.
          recommended_rate += 1
        end
      end
      recommended_movies.store(valid_movie.id, recommended_rate) #We store the valid_movie.id as the key and the recommended_rate as the value into the recommended_movies hash.     
    end
    recommended_movies = recommended_movies.keep_if {| key, value | value > 0 }.sort_by { |id, rr| rr }.reverse.take(5) #We only want the movies that share tags in common with our movies, so with keep only the ones which the recommende rate is greater then 0, we also sorted them so we can have kind of a top 5 of movies by 'likeness'.
  end 

end
