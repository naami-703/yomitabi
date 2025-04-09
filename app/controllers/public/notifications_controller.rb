class Public::NotificationsController < ApplicationController
 before_action :authenticate_user!

  def update
    notification = current_user.notifications.find(params[:id])
    notification.update(read: true)
    case notification.notifiable_type
      when "User"
        redirect_to user_path(notification.notifiable)
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
