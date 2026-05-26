class Notice < ApplicationRecord
  validates :notice_date, presence: true, uniqueness: true
end
