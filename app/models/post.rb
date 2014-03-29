class Post < ActiveRecord::Base
	acts_as_taggable # Alias for acts_as_taggable_on :tags
  	acts_as_taggable_on :tags
  	
  	acts_as_votable
	
	has_many :comments, dependent: :destroy
	has_many :post_attachments, dependent: :destroy
   	
   	accepts_nested_attributes_for :post_attachments
	
	belongs_to :user
	belongs_to :board
	
	default_scope -> { order('updated_at DESC') }
	
	validates :title,	presence: true, length: { maximum: 50}
	validates :content, presence: true
	validates :user_id, presence: true
	validates :board_id, presence: true

	def self.search(search)
	  if search
	  	where('title LIKE ?', "%#{search}%")
	  end
	end
end