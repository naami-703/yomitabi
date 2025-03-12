class PostManagement < ApplicationRecord

  belongs_to :book, optional: true
  belongs_to :spot, optional: true

  has_one_attached :book_image
  has_one_attached :spot_image

  def get_book_image(width,height)
    unless book_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      book_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
      book_image.variant(resize_to_limit: [width, height]).processed
  end
  
  def get_spot_image(width,height)
    unless spot_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      spot_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
      spot_image.variant(resize_to_limit: [width, height]).processed
  end
  
end
