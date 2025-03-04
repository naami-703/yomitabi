class Comment < ApplicationRecord

  belongs_to :user
  belongs_to :book, optional: true
  belongs_to :spot, optional: true

end
