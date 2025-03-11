class PostManagement < ApplicationRecord

  belongs_to :postable, polymorphic: true

  # 投稿管理テーブルからtypeが"spot"でかつbook_idが1であるレコードを取得
  spot = Spot.find(id)
  spot_post_management = PostManagement.find_by(type: "spot", postable: spot)
  # 投稿管理レコードに関連するスポットを取得
  spot = spot_post_management.postable

  # 投稿管理テーブルからtypeが"book"でかつ関連するspotがid:1であるレコードを取得
  book = Book.find(id)
  book_post_management = PostManagement.find_by(type: "book",  postable: book)
  # 投稿管理レコードに関連する書籍を取得
  book = book_post_management.postable

  # スポットに関連する書籍投稿を取得
  related_book_posts = spot.post_managements.where(type: "book")
  # 書籍に関連するスポット投稿を取得
  related_spot_posts = book.post_managements.where(type: "spot")

end
