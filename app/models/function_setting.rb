class FunctionSetting < ApplicationRecord
  belongs_to :profile, optional: true

  # すべての項目で空白禁止
  with_options inclusion: { in: [true, false] } do
    validates :timeline
    validates :schedule
    validates :gallery
    validates :mail
  end

end
