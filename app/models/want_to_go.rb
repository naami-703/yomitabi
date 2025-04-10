class WantToGo < ApplicationRecord

  belongs_to :user
  belongs_to :spot
  has_one :notification, as: :notifiable, dependent: :destroy

  validates :user_id, uniqueness: {scope: :spot_id}

  # 行きたい！登録時の通知作成
  after_create :send_want_to_go_notification

  private
  
  # 投稿通知
  def send_want_to_go_notification
    user.followers.each do |follower|
      Notification.create(user_id: follower.id,  notifiable: self)
    end
  end

end
