class Order < ApplicationRecord
  belongs_to :company
  with_options presense: true do
    validates :title, length: { maximum: 40 }
    validates :content, length: { maximum: 1000 }
    validates :last_day, :deadline, :company_id
  end
end
