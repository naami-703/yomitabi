class CreateLocations < ActiveRecord::Migration[6.1]
  def change
    create_table :locations do |t|
      t.string "name", null: false
      t.integer "address_prefectures", null: false
      t.timestamps
    end
  end
end
