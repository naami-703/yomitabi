class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true
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

  # フォローしたときの処理
  def follow(user_id)
    relations.create(follow_id: user_id)
  end
  # フォローを外すときの処理
  def unfollow(user_id)
    relationss.find_by(follow_id: user_id).destroy
  end
  # フォローしているか判定
  def following?(user)
    followings.include?(user)
  end

  def bookmarked_by?(book_id)
    bookmarks.where(book_id: book_id).exists?
  end

  def get_profile_image(width,height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
      profile_image.variant(resize_to_limit: [width, height]).processed
  end

  def self.looks(search, word)
    search == "partial_match" ? User.where("name LIKE ?", "%#{word}%") : User.all
  end
  
end
