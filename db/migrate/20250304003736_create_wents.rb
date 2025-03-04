class CreateWents < ActiveRecord::Migration[6.1]
  def change
    create_table :wents do |t|
      t.integer "user_id"
      t.integer "spot_id"
      t.timestamps
    end
  end
end
