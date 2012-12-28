ActiveAdmin.register Movie do
  form :html => { :enctype => "multipart/form-data" } do |f|
    f.inputs "Movie", :multipart => true do
      f.input :title
      f.input :synopsis
      f.input :release_date, as: :date
      f.input :poster, :as => :file,
                       :hint => f.template.image_tag(f.object.poster.url(:medium))
      f.input :tag_list
    end
    f.buttons
  end
  index do
    column :title
    column :synopsis, as: :text
    column :release_date
    column :tag_list
    column "Poster" do |movie| 
        link_to image_tag("/assets/posters/#{movie.id}/thumb/#{movie.poster_file_name}",
                           :alt => "poster"), admin_movie_path(movie)
    end
    default_actions
  end
end
