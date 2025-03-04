class CreateSpots < ActiveRecord::Migration[6.1]
  def change
    create_table :spots do |t|
      t.integer "user_id"
      t.integer "location_id"
      t.string "name", null: false
      t.string "address", null: false
      t.timestamps
    end
  end
end
