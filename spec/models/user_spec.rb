require 'spec_helper'

describe User, "Relations" do
  it { should have_many(:checkins) }
  it { should have_many(:movies).through(:checkins) }
  it { should have_many(:ratings) }
  it { should have_many(:rated_movies).through(:ratings) }
  it { should have_many(:viewed_movies).through(:views) }
end
describe User, "Methods" do
  it "should give us an array with 5 recommended movies" 
end
