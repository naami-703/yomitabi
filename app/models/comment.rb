class Comment < ApplicationRecord

  belongs_to :user
  belongs_to :book, optional: true
  belongs_to :spot, optional: true

  validates :comment, length:{in:2..50}, presence: true
  validates :book_id, presence: true 

  has_one_attached :comment_image
  
  def get_comment_image(width, height)
    return comment_image.variant(resize_to_limit: [width, height]).processed if comment_image.attached?
    ActionController::Base.helpers.asset_path('no_image.jpg')
  end

  before_destroy :delete_image

  private

  # 画像が関連付けられていれば削除
  def delete_image
    comment_image.purge if comment_image.attached?
  end

end
