class Spot < ApplicationRecord

  belongs_to :user
  belongs_to :location

  has_one_attached :spot_image

end
