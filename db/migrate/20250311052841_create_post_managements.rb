class CreatePostManagements < ActiveRecord::Migration[6.1]
  def change
    create_table :post_managements do |t|
      t.integer :book_id
      t.integer :spot_id
      t.string "post_type", null: false
      t.timestamps
    end
  end
end
