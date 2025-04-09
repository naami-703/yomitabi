module Public::NotificationsHelper
  def notification_message(notification)
    case notification.notifiable_type
    when "User"
      "#{notification.notifiable.user.name}さんにフォローされました"
    when "Book"
      "フォローしている#{notification.notifiable.user.name}さんが#{notification.notifiable.title}を投稿しました"
    when "Spot"
      "フォローしている#{notification.notifiable.user.name}さんが#{notification.notifiable.name}を投稿しました"
    when "Bookmark"
      "投稿した#{notification.notifiable.book.title}が#{notification.notifiable.user.name}さんにブックマークされました"
    when "WantToGo"
      "投稿した#{notification.notifiable.spot.name}が#{notification.notifiable.user.name}さんに行きたい！されました"
    when "Went"
      "投稿した#{notification.notifiable.spot.name}が#{notification.notifiable.user.name}さんに行ったよ！されました"
    end
  end
end
