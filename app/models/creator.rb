class Creator < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
  has_many :rooms
  has_many :contract
  has_one :career
  has_one :introduction
  has_one :portforio
  has_one :skill

  zenkaku = /\A[ぁ-んァ-ン一-龥]/
  kana = /\A[ァ-ヶー－]+\z/

  with_options presence: true do
    validates :first_name, :last_name, format: { with: zenkaku, message: 'は全角で入力してください。' }
    validates :kana_first_name, :kana_last_name, format: { with: kana, message: 'は全角カタカナで入力して下さい。' }
    validates :prefecture
    validates :birth_date, :prefecture
  end

  validates :prefecture_id, numericality: { other_than: 1, message: 'を選択してください' }
end
