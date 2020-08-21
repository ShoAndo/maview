class Order < ApplicationRecord
  belongs_to :company
  has_many :rooms
  has_one :contract
  has_one :payment
  with_options presence: true do
    validates :title, length: { maximum: 40 }
    validates :content, length: { maximum: 1000 }
    validates :last_day
    validates :award, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999,
                                      message: 'が可能な範囲を超えています' }
  end
end
