class Board < ActiveRecord::Base
	has_many :posts
	validates :title,	presence: true, length: { maximum: 50}
end
