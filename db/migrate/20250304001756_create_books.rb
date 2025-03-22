class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|
      t.integer "user_id", null: false
      t.integer "genre_id", null: false
      t.integer "spot_id"
      t.string "title", null: false
      t.string "author"
      t.string "image_url"
      t.string "post_type", null: false
      t.timestamps
    end
  end
end
