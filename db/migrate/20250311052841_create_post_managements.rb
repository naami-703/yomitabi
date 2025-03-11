class CreatePostManagements < ActiveRecord::Migration[6.1]
  def change
    create_table :post_managements do |t|
      t.integer :book_id
      t.integer :spot_id
      t.timestamps
    end
  end
end
