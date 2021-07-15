class Comment < ApplicationRecord
  belongs_to :profile

  # プロフィールID、コメント本文は空白禁止
  with_options presence: true do
    validates :profile_id
    validates :text
  end
end
