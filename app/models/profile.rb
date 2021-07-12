class Profile < ApplicationRecord
  belongs_to :user

  with_options presence: true do
    # プロフィールコードは一意で20文字以内とする
    validates :code, uniqueness: true, length: {maximum: 20}, format: { with: /\A[a-z0-9]+\z/ }
    # 名前は20文字以内
    validates :name, length: {maximum: 20}
  end
  # 自己紹介は160文字以内
  validates :introduction, length: {maximum: 160}

  # image_idに画像投稿機能を追加
  attachment :image

  # URLのIDをコードに
  # def to_param
  #   cord
  # end
end
