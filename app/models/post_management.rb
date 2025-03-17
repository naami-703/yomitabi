class PostManagement < ApplicationRecord

  belongs_to :book, optional: true
  belongs_to :spot, optional: true

  validates :book_id, uniqueness: { scope: :spot_id }
  
end
