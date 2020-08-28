class Card < ApplicationRecord
  belongs_to :company
  with_options presence: true do
    validates :card_token, :customer_token
  end
end
