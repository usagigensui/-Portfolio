class Schedule < ApplicationRecord
  belongs_to :profile

  # プロフィールID、タイトル、開始時刻は空白禁止
  with_options presence: true do
    validates :profile_id
    validates :title
    validates :start_date
    validates :end_date
  end

  # 未完了の予定一覧を取得
  def self.waiting_schedules
    where('end_date > ?', DateTime.now)
  end

  # 完了した予定一覧を取得
  def self.completed_schedules
    where('end_date < ?', DateTime.now)
  end
end
