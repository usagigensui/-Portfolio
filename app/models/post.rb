class Post < ApplicationRecord
  belongs_to :profile

  # プロフィールID、投稿本文は空白禁止
  with_options presence: true do
    validates :profile_id
    validates :text
  end
end
