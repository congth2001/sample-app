class Micropost < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  scope :arrange, -> {order(created_at: :desc)}
  validates :user_id, presence: true
  validates :content, presence: true, length: {maximum: Settings.digits.length_content_max}
  validates :image, content_type: {in: Settings.image.format,
                                   message: I18n.t("valid_img_format")},
                    size: {less_than: Settings.digits.volume_img_max.megabytes,
                           message: I18n.t("valid_img_volume")}

  delegate :name, to: :user

  def display_image 
    image.variant resize_to_limit: Settings.digits.resize_limit
  end
end
