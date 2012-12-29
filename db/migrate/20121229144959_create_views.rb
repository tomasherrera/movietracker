class CreateViews < ActiveRecord::Migration
  def change
    create_table :views do |t|
      t.references :user
      t.references :movie
      t.timestamps
    end
    add_index "views", [:user_id, :movie_id]
  end
end
