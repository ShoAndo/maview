class Company < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :orders
  has_many :rooms
  has_many :contract
  has_one :outline
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture

  with_options presence: true do
    validates :name, length: {maximum: 30}
    validates :prefecture
  end

  validates :prefecture_id, numericality: { other_than: 1, message: 'を選択してください' }
end
