class Image < ApplicationRecord
  belongs_to :profile

  # プロフィールID、画像は空白禁止
  with_options presence: true do
    validates :profile_id
    validates :body_id
  end

  # body_idに画像投稿機能を追加
  attachment :body
end
