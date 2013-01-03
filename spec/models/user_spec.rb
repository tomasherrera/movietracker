require 'spec_helper'

describe User, "Relations" do
  it { should have_many(:checkins) }
  it { should have_many(:movies).through(:checkins) }
  it { should have_many(:ratings) }
  it { should have_many(:rated_movies).through(:ratings) }
  it { should have_many(:viewed_movies).through(:views) }
end
describe User, "Methods" do
  before do
    @user = FactoryGirl.create(:user)    
  end

  it "should give us an empty array when the user hasn't watch no movies yet" do
    User.recommended_movies(@user).should_not be_nil
    User.recommended_movies(@user).should be_empty
  end

  it "should give us an array with 5 recommended movies sorted by rating" do
    movies = []
    i = 9
    (1..5).each do |m|
      movies<<(FactoryGirl.create(:movie, id: m, average_rating: i, tag_list: "action"))
      i -= 1
    end
    FactoryGirl.create(:view, movie_id: 1, user_id: @user.id)
    movies<<(FactoryGirl.create(:movie, id: 6, average_rating: 10, tag_list: "comedy"))
    User.recommended_movies(@user).should be_eql(
      [movies[1],movies[2],movies[3],movies[4]]
    )
  end

end

