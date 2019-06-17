class Micropost < ApplicationRecord
  belongs_to :user
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, presence: true,
    length: {maximum: Settings.validation.content_max}
  validate :picture_size
  scope :order_posts, ->{order created_at: :desc}

  private

  def picture_size
    return unless picture.size > Settings.pic_size.megabytes
    errors.add :picture, t("errors_pic")
  end
end
