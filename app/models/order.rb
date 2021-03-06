class Order < ApplicationRecord
  belongs_to :company
  has_many :rooms
  has_one :contract
  has_one :payment
  has_many :likes
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :job_category

  with_options presence: true do
    validates :title, length: { maximum: 40 }
    validates :content, length: { maximum: 1000 }
    validates :last_day, :job_category
    validates :award, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999,
                                      message: 'が可能な範囲を超えています' }
  end
  validates :job_category_id, numericality: { other_than: 1 }

  def self.search(search)
    if search != ''
      Order.where('title LIKE(?)', "%#{search}%").where.not(id: Contract.select('order_id')).order('created_at DESC')
    else
      Order.includes(:company).where.not(id: Contract.select('order_id')).order('created_at DESC')
    end
  end
end
