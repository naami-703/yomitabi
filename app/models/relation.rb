class Relation < ApplicationRecord

  #フォローされている
  belongs_to :follower, class_name: "User"
  #フォローしている
  belongs_to :follow, class_name: "User"

  validates :follower_id, presence: true
  validates :follow_id, presence: true, uniqueness: { scope: :follower_id }

  # フォローされた時の通知作成
  after_create :send_follow_notification

  private

  # フォロー通知
  def send_follow_notification
    Notification.create(user_id: follow.id, notifiable: self)
  end

end
