class Book < ApplicationRecord

  belongs_to :user
  belongs_to :genre
  has_many :comments, dependent: :destroy
  has_many :post_managements, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :notification, as: :notifiable, dependent: :destroy

  validates :title, length:{in:2..50}, uniqueness: true, presence: true
  validates :isbn, uniqueness: true

  def self.looks(search, word)
    search == "partial_match" ? Book.where("title LIKE ?", "%#{word}%") : Book.all
  end

  def bookmarked_by?(user)
    bookmarks.exists?(user_id: user.id)
  end

  # book投稿時の通知作成
  after_create :send_book_notification

  private
 
  # 投稿通知
  def send_book_notification
    user.followers.each do |follower|
      Notification.create(user_id: follower.id, notifiable: self)
  end
  end

end
