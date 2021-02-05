class Book < ApplicationRecord
	belongs_to :user
	has_many :favorites, dependent: :destroy
	has_many :post_comments, dependent: :destroy

	def favorite_by?(user)
	  favorites.where(user_id: user.id).exists?
	end

	def self.search(search, word)
    if search == "forward_match"
      Book.where("title LIKE?","#{word}%")
    elsif search == "backward_match"
      Book.where("title LIKE?","%#{word}")
    elsif search == "perfect_match"
      Book.where(title: "#{word}")
    elsif search == "partial_match"
      Book.where("title LIKE?","%#{word}%")
    end
  end
  
	validates :title, presence: true
	validates :body, presence: true, length: {maximum: 200}
end
