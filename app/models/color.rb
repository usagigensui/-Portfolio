class Color < ApplicationRecord
  belongs_to :profile

  # 全ての項目で空白禁止
  with_options presence: true do
    validates :profile_id
    validates :text
    validates :background
    validates :accent
  end

  # enum管理
  enum text: { black: 0, white: 1 }, _prefix: true
  enum background: { white: 0, black: 1 }, _prefix: true
  enum accent: { blue: 0, red: 1 }, _prefix: true
end
