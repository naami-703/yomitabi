class Public::NotificationsController < Public::ApplicationController
 before_action :authenticate_user!

  def update
    notification = current_user.notifications.find(params[:id])
    notification.update(read: true)
    case notification.notifiable_type
      when "Relation"
        redirect_to user_path(notification.notifiable.follower)
      when "Book"
        redirect_to book_path(notification.notifiable)
      when "Spot"
        redirect_to spot_path(notification.notifiable)
      when "Bookmark"
        redirect_to book_path(notification.notifiable.book)
      when "WantToGo"
        redirect_to spot_path(notification.notifiable.spot)
      when "Went"
        redirect_to spot_path(notification.notifiable.spot)
    end
  end

end
