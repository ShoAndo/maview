class Message < ApplicationRecord
  belongs_to :room
  has_one_attached :image
  validates :content, presence: true, unless: :was_attached?
  validates :category, presence: true

  def was_attached?
    self.image.attached?
  end
end
