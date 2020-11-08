class Post < ApplicationRecord
  belongs_to :user
  # お気に入り機能追加
  has_many :favorites, dependent: :destroy
  has_many :users, through: :favorites
  
  mount_uploader :img, ImgUploader
  
  validates :content, presence: true, length: { maximum: 255 }
end
