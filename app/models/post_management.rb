class PostManagement < ApplicationRecord

  belongs_to :book, optional: true
  belongs_to :spot, optional: true
  
end
