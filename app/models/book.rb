class Book < ApplicationRecord

  belongs_to :user
  belongs_to :genre
  has_many :comments, dependent: :destroy
  has_many :post_managements,  dependent: :destroy

  validates :title, presence: true
  
  # すべての投稿関連設定がすんだら削除
  has_one_attached :book_image, dependent: :destroy

  # すべての投稿関連設定がすんだら削除
  def get_book_image(width,height)
    unless book_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      book_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
      book_image.variant(resize_to_limit: [width, height]).processed
  end

end
