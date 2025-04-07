class WantToGo < ApplicationRecord

  belongs_to :user
  belongs_to :spot
  has_one :notification, as: :notifiable/ dependent: :destroy

  validates :user_id, uniqueness: {scope: :spot_id}

end
