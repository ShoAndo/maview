class Room < ApplicationRecord
  belongs_to :order
  belongs_to :creator
  belongs_to :company
  has_many :messages

  validates :name,presence: true
end
