class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.string :content
      t.string :status
      t.integer :user_id

      t.timestamps
    end
    add_index :posts, [:user_id, :updated_at]
  end
end