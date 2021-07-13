class Schedule < ApplicationRecord
  belongs_to :profile

  # プロフィールID、タイトル、開始時刻は空白禁止
  with_options presence: true do
    validates :profile_id
    validates :title
    validates :start_date
  end
end
