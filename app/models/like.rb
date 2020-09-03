class Like < ApplicationRecord
  belongs_to :order
  belongs_to :creator
end
