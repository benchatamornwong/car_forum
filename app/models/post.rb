class Post < ActiveRecord::Base
	belongs_to :user
	default_scope -> { order('updated_at DESC') }
	validates :title,	presence: true, length: { maximum: 50}
	validates :content, presence: true
	validates :status,	presence: true
	validates :user_id, presence: true
end