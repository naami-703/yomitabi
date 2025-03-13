class Comment < ApplicationRecord

  belongs_to :user
  belongs_to :book, optional: true
  belongs_to :spot, optional: true

  validates :comment, presence: true
  validates :book_id, presence: true

  has_one_attached :comment_image

  def get_comment_image(width,height)
    unless comment_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      comment_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
      # comment_image.analyze_later if comment_image.attached? && !comment_image.analyzed?
      comment_image.variant(resize_to_limit: [width, height]).processed
  end

  before_destroy :delete_image

  private

  def delete_image
    # 画像が関連付けられていれば削除
    comment_image.purge if comment_image.attached?
  end

end
