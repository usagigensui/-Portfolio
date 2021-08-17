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
  enum text: { black: 0, white: 1, sepia: 2 }, _prefix: true
  enum background: { white: 0, black: 1, gray: 2, ivory: 3, brown: 4 }, _prefix: true
  enum accent: { lightgray: 0, darkgray: 1, blue: 2, red: 3, pink: 4, skyblue: 5, lightgreen: 6, yellow: 7, orange: 8 },
       _prefix: true
end
