class NotificationController < ApplicationController
 before_action :authenticate_user!

def update
  norification = current_user.norifications.find([:id])
  notification.update(read: true)
  # 通知の種類によるリダイレクトパスの生成
  case notification.notifiable_type
    when "Book"
      redirect_to book_path(notification.notifiable)
    when "Spot"
      redirect_to spot_path(notification.notifiable)
    else
      redirect_to mypage_users_path(notification.notifiable.user)
    end
  end

end
