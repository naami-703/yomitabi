class Spot < ApplicationRecord

  belongs_to :user
  belongs_to :location, optional: true
  has_many :comments, dependent: :destroy
  has_many :post_managements,  dependent: :destroy

  validates :name, presence: true
  validates :address, presence: true
  validates :book_id, presence: true

  def self.looks(search, word)
    search == "partial_match" ? Spot.where("name LIKE ?", "%#{word}%") : Spot.all
  end

  # すべての投稿関連設定がすんだら削除
  has_one_attached :spot_image, dependent: :destroy

  # すべての投稿関連設定がすんだら削除
  def get_spot_image(width,height)
    unless spot_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      spot_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
      spot_image.variant(resize_to_limit: [width, height]).processed
  end

end
