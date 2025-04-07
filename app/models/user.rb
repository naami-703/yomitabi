class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, length:{in:2..20}, presence: true
  validates :email, presence: true

  has_one_attached :profile_image
  has_many :books, dependent: :destroy
  has_many :spots, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :want_to_gos, dependent: :destroy
  has_many :wents, dependent: :destroy
  has_many :relations, class_name: "Relation", foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_of_relations, class_name: "Relation", foreign_key: "follow_id", dependent: :destroy
  has_many :followings, through: :relations, source: :follow
  has_many :followers, through: :reverse_of_relations, source: :follower
  has_many :notifications, dependent: :destroy

  # フォローしたときの処理
  def follow(user_id)
    relations.create(follow_id: user_id)
  end
  # フォローを外すときの処理
  def unfollow(user_id)
    relations.find_by(follow_id: user_id).destroy
  end
  # フォローしているか判定
  def following?(user)
    followings.include?(user)
  end

  def bookmarked_by?(book_id)
    bookmarks.where(book_id: book_id).exists?
  end

  def get_profile_image(width,height)
    return profile_image.variant(resize_to_limit: [width, height]).processed if profile_image.attached?
    ActionController::Base.helpers.asset_path('no_image.jpg')
  end

  def self.looks(search, word)
    search == "partial_match" ? User.where("name LIKE ?", "%#{word}%") : User.all
  end

  # フォロー通知
  user.followers.each do |follower|
    notification.create(user_id: follower_id)
  end
  
end
