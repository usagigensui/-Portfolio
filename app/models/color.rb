class Color < ApplicationRecord
  belongs_to :profile

  # 全ての項目で空白禁止
  with_options presence: true do
    validates :profile_id
    validates :text
    validates :background
    validates :accent
  end
end
