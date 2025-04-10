class CreateSpots < ActiveRecord::Migration[6.1]
  def change
    create_table :spots do |t|
      t.integer "user_id"
      t.integer "location_id"
      t.integer "book_id"
      t.string "name", null: false
      t.integer "address_prefectures", null: false
      t.string "address_city"
      t.float "latitude"
      t.float "longitude"
      t.string "post_type", null: false
      t.timestamps
    end
  end
end
