class AddLatestEditToPosts < ActiveRecord::Migration
  def change
  	add_column :posts, :latest_edit, :datetime, default: Time.now
  end
end