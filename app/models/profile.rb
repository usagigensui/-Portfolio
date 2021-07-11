class Profile < ApplicationRecord
  belongs_to :user

  # プロフィールコードは一意とする
  validates :cord, uniqueness: true

  # image_idに画像投稿機能を追加
  attachment :image
  
  # URLのIDをコードに
  def to_param
    cord
  end
end
