class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :following_user, through: :follower, source: :followed
  has_many :follower_user, through: :followed, source: :follower
  attachment :profile_image, destroy: false

  def follow(user_id)
    if user_id != self.id
      follower.create(followed_id: user_id)
    end
  end

  def unfollow(user_id)
    if user_id != self.id
      follower.find_by(followed_id: user_id).destroy
    end
  end

  def following?(user)
    following_user.include?(user)
  end
  
  def self.search(search,word)
    if search == "forward_match"
      User.where("name LIKE?","#{word}%")
    elsif search == "backward_match"
      User.where("name LIKE?","%#{word}")
    elsif search == "perfect_match"
      User.where(name: "#{word}")
    elsif search == "partial_match"
      User.where("name LIKE?","%#{word}%")
    end
  end
  
  validates :name, length: {maximum: 20, minimum: 2}, uniqueness: true
  validates :introduction, length: {maximum: 50}
end