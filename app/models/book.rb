class Book < ApplicationRecord

  belongs_to :user
  belongs_to :genre
  has_many :comments, dependent: :destroy
  has_many :post_managements,  dependent: :destroy

  validates :title, uniqueness: true, presence: true

  def self.looks(search, word)
    search == "partial_match" ? Book.where("title LIKE ?", "%#{word}%") : Book.all
  end
  
  has_one_attached :book_image, dependent: :destroy

  def get_book_image(width, height)
    return book_image.variant(resize_to_limit: [width, height]).processed if book_image.attached?
    ActionController::Base.helpers.asset_path('no_image.jpg')
  end

end
