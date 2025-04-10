class Spot < ApplicationRecord
  # スポット名から緯度経度算出
  geocoded_by :address_googlemap
  after_validation :geocode, if: ->(obj) { obj.address_googlemap.present? && (obj.latitude.blank? || obj.longitude.blank?) }
  # 緯度経度から住所算出
  after_save :set_address_from_googlemap

  belongs_to :user
  belongs_to :location, optional: true
  has_many :comments, dependent: :destroy
  has_many :post_managements,  dependent: :destroy
  has_many :want_to_gos, dependent: :destroy
  has_many :wents, dependent: :destroy
  has_many :notification, as: :notifiable, dependent: :destroy

  validates :name, length:{in:2..20}, uniqueness: true, presence: true
  validates :address_prefectures, length:{in:2..10}, presence: true
  validates :address_googlemap, length:{in:2..50}, presence: true
  validates :book_id, presence: true

  has_one_attached :spot_image, dependent: :destroy

  geocoded_by :address_googlemap
  after_validation :geocode

  # 都道府県プルダウン
  enum address_prefectures:{
    北海道:1,青森県:2,岩手県:3,宮城県:4,秋田県:5,山形県:6,福島県:7,
    茨城県:8,栃木県:9,群馬県:10,埼玉県:11,千葉県:12,東京都:13,神奈川県:14,
    新潟県:15,富山県:16,石川県:17,福井県:18,山梨県:19,長野県:20,
    岐阜県:21,静岡県:22,愛知県:23,三重県:24,
    滋賀県:25,京都府:26,大阪府:27,兵庫県:28,奈良県:29,和歌山県:30,
    鳥取県:31,島根県:32,岡山県:33,広島県:34,山口県:35,
    徳島県:36,香川県:37,愛媛県:38,高知県:39,
    福岡県:40,佐賀県:41,長崎県:42,熊本県:43,大分県:44,宮崎県:45,鹿児島県:46,
    沖縄県:47,海外:48,
  }

  def self.looks(search, word)
    search == "partial_match" ? Spot.where("name LIKE ?", "%#{word}%") : Spot.all
  end

  def get_spot_image(width, height)
    return spot_image.variant(resize_to_limit: [width, height]).processed if spot_image.attached?
    ActionController::Base.helpers.asset_path('no_image.jpg')
  end

  def want_to_gosed_by?(user)
    want_to_gos.exists?(user_id: user.id)
  end

  def wented_by?(user)
    wents.exists?(user_id: user.id)
  end

  # spot投稿時の通知作成
  after_create :send_spot_notification
  before_save :set_location

  # 都道府県に応じたLocationを設定
  def set_location
    self.location = Location.find_by(address_prefectures: self.address_prefectures)
  end

  def set_address_from_googlemap
    if latitude.present? && longitude.present? && address_googlemap == name
      calculated_address = Geocoder.address([latitude, longitude])
      update_column(:address_googlemap, calculated_address) if calculated_address.present?
    end
  end

  private

  # 投稿通知
  def send_spot_notification
    user.followers.each do |follower|
      Notification.create(user_id: follower.id, notifiable: self)
    end
  end

end
