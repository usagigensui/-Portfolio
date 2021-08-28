class FunctionSetting < ApplicationRecord
  belongs_to :profile

  # すべての項目で空白禁止
  validates :profile_id ,presence: true
  with_options inclusion: { in: [true, false] } do
    validates :timeline
    validates :schedule
    validates :gallery
    validates :mail
  end

end
