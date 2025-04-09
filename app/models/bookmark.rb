class Bookmark < ApplicationRecord

  belongs_to :user
  belongs_to :book
  has_one :notification, as: :notifiable, dependent: :destroy

  validates :user_id, uniqueness: {scope: :book_id}
  
  # 投稿通知
  after_create do
    user.followers.each do |follower|
      Notification.create(user_id: follower.id, notifiable: book)
    end
  end

end
