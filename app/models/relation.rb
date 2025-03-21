class Relation < ApplicationRecord

  #フォローされている
  belongs_to :follower, class_name: "User"
  #フォローしている
  belongs_to :follow, class_name: "User"

  validates :follower_id, presence: true
  validates :follow_id, presence: true, uniqueness: { scope: :follower_id }

end
