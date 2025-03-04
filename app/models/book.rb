class Book < ApplicationRecord

  belongs_to :user
  belongs_to :genre

  has_one_attached :book_image
  
end
