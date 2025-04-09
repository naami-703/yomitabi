class WantToGo < ApplicationRecord

  belongs_to :user
  belongs_to :spot
  has_one :notification, as: :notifiable, dependent: :destroy

  validates :user_id, uniqueness: {scope: :spot_id}
  
  # 投稿通知
  after_create do
    user.followers.each do |follower|
      Notification.create(user_id: follower.id, notifiable: spot)
    end
  end
end
