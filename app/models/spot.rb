class Spot < ApplicationRecord

  belongs_to :user
  belongs_to :location, optional: true
  has_many :post_managements,  dependent: :destroy, as: :postable

  validates :name, presence: true
  validates :address, presence: true

  has_one_attached :spot_image, dependent: :destroy

  def get_spot_image(width,height)
    unless spot_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      spot_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
      spot_image.variant(resize_to_limit: [width, height]).processed
  end

end
