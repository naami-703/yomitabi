class Bookmark < ApplicationRecord

  belongs_to :user
  belongs_to :book
  has_one :notification, as: :notifiable, dependent: :destroy

  validates :user_id, uniqueness: {scope: :book_id}
  
  # bookmark登録時の通知作成
  after_create :send_bookmark_notification

  private
  
  # 投稿通知
  def send_bookmark_notification
    user.followers.each do |follower|
      Notification.create(user_id: follower.id, notifiable: self)
    end
  end

end
