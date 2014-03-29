class AddLatestInteractionToPosts < ActiveRecord::Migration
  def change
  	add_column :posts, :latest_interaction, :datetime, default: Time.now
  end
end
