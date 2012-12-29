class Movie < ActiveRecord::Base
  attr_accessible :title, :synopsis, :release_date, :poster, :uri_trailer, :tag_list
  acts_as_taggable
  validates :title, presence: true
  validates :release_date, presence: true

  validates :uri_trailer, format: {with: /([\w-]{11}).*/,
                        message: "Video Identifier Invalid"}


  has_many :checkins
  has_many :views
  has_many :users, through: :checkins

  has_many :ratings
  has_many :raters, through: :ratings, source: :users
  has_many :viewers, through: :views, source: :user

  has_attached_file :poster,
            :styles => { :medium => "256x320>", :thumb => "60x80>" },
            :url => "/assets/posters/:id/:style/:basename.:extension",
            :path => ":rails_root/public/assets/posters/:id/:style/:basename.:extension"
  validates_attachment :poster,
            :content_type => { :content_type => ["image/jpg", "image/jpeg", "image/png"]  },
            :size => { :less_than => 3.megabytes }

  SEARCH_TYPES = %w(title synopsis)
  
  def self.search(search, type)
    if search
      where("#{type} LIKE ?", "%#{search}%")
    else
      all
    end
  end

  def average_rating
    average = ratings.average(:value).to_f
  end

end
