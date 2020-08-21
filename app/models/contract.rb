class Contract < ApplicationRecord
  belongs_to :creator
  belongs_to :company
  belongs_to :order
end
