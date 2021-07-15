class Inquiry < ApplicationRecord
  belongs_to :profile

  # プロフィールID、名前、メールアドレス、投稿本文は空白禁止
  with_options presence: true do
    validates :profile_id
    validates :sender
    validates :email
    validates :message
  end
end
