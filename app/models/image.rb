class Image < ApplicationRecord
  belongs_to :profile

  # プロフィールID、タイトルは空白禁止
  with_options presence: true do
    validates :profile_id
    validates :title
  end

  # body_idに画像投稿機能を追加
  attachment :body
end
